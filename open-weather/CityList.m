
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCitiesToDisk) name:UIApplicationWillTerminateNotification object:nil];
    });
    return sharedInstance;
}

- (void)addCity:(City * _Nonnull)city {
    [self.cities addObject:city];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCellIdentifier"];
    cell.textLabel.text = self.cities[indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
