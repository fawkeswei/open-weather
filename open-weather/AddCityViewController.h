//
//  AddCityViewController.h
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class City;

@interface AddCityViewController : UIViewController

@property (nonatomic, readonly, nullable) City *selectedCity;

@end
