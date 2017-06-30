//
//  Weather+ViewModel.h
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "Weather.h"

@interface Weather (ViewModel)

- (NSString *)stringFromTemperature;
- (NSString *)stringFromHumidity;
- (NSString *)stringFromWindSpeed;
- (NSString *)stringFromWindDirection;
- (NSString *)stringFromDate;

@end
