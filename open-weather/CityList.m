
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
        sharedInstance.cities = [sharedInstance getCitiesFromDisk];
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
}

#pragma mark - Data Persistance

- (void)deleteSavedCities {
    self.cities = [NSMutableArray array];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromSelector(@selector(cities))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (nonnull NSMutableArray<City *> *)getCitiesFromDisk {
    NSMutableArray *cities = nil;
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromSelector(@selector(cities))];
    if ([data length] != 0) {
        cities = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    if (!cities) {
        cities = [NSMutableArray array];
    }
    return cities;
}

- (void)saveCitiesToDisk {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.cities];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:NSStringFromSelector(@selector(cities))];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
