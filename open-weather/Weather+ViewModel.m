//
//  Weather+ViewModel.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "Weather+ViewModel.h"

@implementation Weather (ViewModel)

- (NSString *)stringFromTemperature {
    return [NSString stringWithFormat:@"%@°C", self.temperature];
}

- (NSString *)stringFromHumidity {
    return [NSString stringWithFormat:@"%@%%", self.humidity];
}

- (NSString *)stringFromWindSpeed {
    return [NSString stringWithFormat:@"%@ m/s", self.windSpeed];
}

- (NSString *)stringFromWindDirection {
    return [NSString stringWithFormat:@"%@", self.windDirection];
}

- (NSString *)stringFromDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setDoesRelativeDateFormatting:YES];
    
    return [df stringFromDate:self.date];
}

@end
