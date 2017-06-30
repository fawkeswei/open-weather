//
//  City.m
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "City.h"

@interface City ()

@property (nonatomic) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, strong) NSString *name;

@end

@implementation City

+ (CLGeocoder *)geoCoder {
    static dispatch_once_t once;
    static CLGeocoder *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[CLGeocoder alloc] init];
    });
    return sharedInstance;
}

+ (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^_Nonnull)(City * _Nullable city, NSError * _Nullable error))completionHandler {
    
    [[City geoCoder] cancelGeocode];
    [[City geoCoder] reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
        }
        else {
            NSString *name = placemarks.firstObject.name;
            if ([name length] == 0) {
                name = [NSString stringWithFormat:@"(%@,%@)", @(coordinate.latitude), @(coordinate.longitude)];
            }
            completionHandler([City cityWithName:name locationCoordinate:coordinate], nil);
        }
    }];
}

+ (nonnull instancetype)cityWithName:(NSString *_Nonnull)name locationCoordinate:(CLLocationCoordinate2D)locationCoordinate {
    City *city = [[City alloc] init];
    city.name = name;
    city.locationCoordinate = locationCoordinate;
    return city;
}

#pragma mark -

- (void)getCurrentWeatherWithCompletionHandler:(void (^_Nonnull)(Weather * _Nullable weather, NSError * _Nullable error))completionHandler {
    
    NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"appid" value:@"c6e381d8c7ff98f0fee43775817cf6ad"],
                            [NSURLQueryItem queryItemWithName:@"units" value:@"metric"],
                            [NSURLQueryItem queryItemWithName:@"mode" value:@"json"],

                            [NSURLQueryItem queryItemWithName:@"lat" value:[@(self.locationCoordinate.latitude) stringValue]],
                            [NSURLQueryItem queryItemWithName:@"lon" value:[@(self.locationCoordinate.longitude) stringValue]],
                            ];
    
    NSURL *url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    components.queryItems = queryItems;
    components.path = [components.path stringByAppendingString:@"weather"];


    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:components.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        NSError *JSONSerializationError = nil;
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONSerializationError];
        if (JSONSerializationError) {
            completionHandler(nil, error);
            return;
        }
        
        
        Weather *weather = [Weather weatherWithData:responseData];
        if (weather) {
            completionHandler(weather, nil);
        }
        else {
            completionHandler(nil, nil);// data error
        }
        
    }];
    [task resume];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        CLLocationDegrees latitude = [decoder decodeDoubleForKey:@"latitude"];
        CLLocationDegrees longitude = [decoder decodeDoubleForKey:@"longitude"];
        self.locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        self.name = [decoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeDouble:self.locationCoordinate.latitude forKey:@"latitude"];
    [encoder encodeDouble:self.locationCoordinate.longitude forKey:@"longitude"];
    [encoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
}

@end
