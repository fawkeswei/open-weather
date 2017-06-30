
//
//  CityList.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityList.h"

@interface CityList ()

@property (nonatomic, strong) NSMutableArray<City *> *cities;

@end

@implementation CityList

+ (nonnull instancetype)cityList {
    static dispatch_once_t once;
    static CityList *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[CityList alloc] init];
        NSMutableArray *cities = [sharedInstance getCitiesFromDisk];
        if (!cities) {  // Nothing on disk -> load default cities
            cities = [@[
                        [City cityWithName:@"Amsterdam, Netherlands" locationCoordinate:CLLocationCoordinate2DMake(52.3745291, 4.7585304)],
                        [City cityWithName:@"Taipei, Taiwan" locationCoordinate:CLLocationCoordinate2DMake(23.5821073, 118.7761817)],
                        [City cityWithName:@"Tokyo, Japan" locationCoordinate:CLLocationCoordinate2DMake(35.6732619, 139.5703006)],
                        ] mutableCopy];
            [sharedInstance saveCitiesToDisk];
        }
        sharedInstance.cities = cities;
    });
    return sharedInstance;
}

- (void)addCity:(City * _Nonnull)city {
    [self.cities addObject:city];
    [self saveCitiesToDisk];
}

- (NSUInteger)count {
    return self.cities.count;
}

- (nonnull City *)cityAtIndex:(NSUInteger)index {
    return self.cities[index];
}

- (void)removeCityAtIndex:(NSUInteger)index {
    [self.cities removeObjectAtIndex:index];
    [self saveCitiesToDisk];
}

#pragma mark - Data Persistance

- (void)deleteSavedCities {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromSelector(@selector(cities))];
    self.cities = [NSMutableArray array];
    [self saveCitiesToDisk];
}

- (nonnull NSMutableArray<City *> *)getCitiesFromDisk {
    NSMutableArray *cities = nil;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(@selector(cities))];
    if ([data length] != 0) {
        cities = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return cities;
}

- (void)saveCitiesToDisk {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cities];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:NSStringFromSelector(@selector(cities))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
