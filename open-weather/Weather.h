//
//  Weather.h
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, readonly, nonnull) NSNumber *temperature;
@property (nonatomic, readonly, nullable) NSNumber *humidity;
@property (nonatomic, readonly, nullable) NSNumber *windSpeed;
@property (nonatomic, readonly, nullable) NSNumber *windDirection;

+ (instancetype)weatherWithData:(NSDictionary *)data;

@end
