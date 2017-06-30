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

@interface CityList : NSObject

+ (nonnull instancetype)cityList;

- (void)addCity:(City * _Nonnull)city;
- (NSUInteger)count;
- (nonnull City *)cityAtIndex:(NSUInteger)index;
- (void)removeCityAtIndex:(NSUInteger)index;

- (void)deleteSavedCities;

@end
