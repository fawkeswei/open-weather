//
//  City.h
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

@import Foundation;
@import CoreLocation;

#import "Weather.h"

@interface City : NSObject <NSCoding>

@property (nonatomic, readonly) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, readonly, nullable) NSString *name;

+ (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate completionHandler:(void (^_Nonnull)(City * _Nullable city, NSError * _Nullable error))completionHandler;
+ (nonnull instancetype)cityWithName:(NSString *_Nonnull)name locationCoordinate:(CLLocationCoordinate2D)locationCoordinate;

- (void)getCurrentWeatherWithCompletionHandler:(void (^_Nonnull)(Weather * _Nullable weather, NSError * _Nullable error))completionHandler;
- (void)getForecastWeatherWithCompletionHandler:(void (^_Nonnull)(NSArray<Weather *> * _Nullable weatherArray, NSError * _Nullable error))completionHandler;

@end
