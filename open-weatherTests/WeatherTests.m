//
//  WeatherTests.m
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Weather.h"
#import "Weather+ViewModel.h"

@interface WeatherTests : XCTestCase

@end

@implementation WeatherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWeatherWithData {
    NSDictionary *data = @{
                           @"main": @{
                                   @"temp": @22.6,
                                   @"humidity": @99,
                                   },
                           @"wind": @{
                                   @"speed": @5.46,
                                   @"deg": @65.5,
                                   },
                           @"dt": @1498834800,
                           };
    
    Weather *weather = [Weather weatherWithData:data];
    XCTAssert(weather);
    XCTAssertEqualObjects(@22.6, weather.temperature);
    XCTAssertEqualObjects(@99, weather.humidity);
    XCTAssertEqualObjects(@5.46, weather.windSpeed);
    XCTAssertEqualObjects(@65.5, weather.windDirection);
    XCTAssertNotNil(weather.date);
    
    XCTAssertNil([Weather weatherWithData:@{}]);
}

- (void)testWeatherViewModel {
    NSDictionary *data = @{
                           @"main": @{
                                   @"temp": @30.1,
                                   @"humidity": @50,
                                   },
                           @"wind": @{
                                   @"speed": @4.20,
                                   @"deg": @90.5,
                                   },
                           @"dt": @1498844800,
                           };
    
    Weather *weather = [Weather weatherWithData:data];
    XCTAssert(weather);
    XCTAssertEqualObjects(@"30.1°C", weather.stringFromTemperature);
    XCTAssertEqualObjects(@"50%", weather.stringFromHumidity);
    XCTAssertEqualObjects(@"4.2 m/s", weather.stringFromWindSpeed);
    XCTAssertEqualObjects(@"90.5", weather.stringFromWindDirection);
    XCTAssert([weather.stringFromDate length] != 0);
}

@end
