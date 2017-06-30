//
//  CityWeatherTableViewController.h
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "City.h"

@interface CityWeatherTableViewController : UITableViewController

@property (nonatomic, strong) City *city;

@end
