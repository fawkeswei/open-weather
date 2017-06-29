//
//  Weather.m
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "Weather.h"

@interface Weather ()

@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windDirection;

@end

@implementation Weather

+ (instancetype)weatherWithData:(NSDictionary *)data {
    // if the most important data is missing, don't create a weather
    if (!data[@"main"][@"temp"]) {
        return nil;
    }
    
    Weather *weather = [[Weather alloc] init];
    weather.temperature = data[@"main"][@"temp"];
    weather.humidity = data[@"main"][@"humidity"];
    weather.windSpeed = data[@"wind"][@"speed"];
    weather.windDirection = data[@"wind"][@"deg"];
    
    return weather;
}

@end
