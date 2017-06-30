//
//  CityList.h
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "City.h"

@interface CityList : NSObject <UITableViewDataSource>

+ (nonnull instancetype)cityList;

- (void)addCity:(City * _Nonnull)city;


// private methods, only for unit testing
- (void)deleteSavedCities;
- (void)saveCitiesToDisk;
- (nonnull NSMutableArray<City *> *)getCitiesFromDisk;

@end
