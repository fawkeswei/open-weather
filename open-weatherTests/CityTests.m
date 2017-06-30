//
//  CityTests.m
//  open-weather
//
//  Created by Fawkes Wei on 29/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "City.h"

@interface CityTests : XCTestCase

@end

@implementation CityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReverseGeocodeCoordinate {
    XCTestExpectation *expectation = [self expectationWithDescription:@"reverse geocode coordinate to amsterdam"];
    
    CLLocationCoordinate2D coordinateOfAmsterdam = CLLocationCoordinate2DMake(52.3745291, 4.7585304);
//    CLLocationCoordinate2D coordinateOfSomewhereInPacificOcean = CLLocationCoordinate2DMake(18.072629, 163.7364493);
//    CLLocationCoordinate2D coordinateOfTaiwan = CLLocationCoordinate2DMake(23.5821073, 118.7761817);
    
    [City reverseGeocodeCoordinate:coordinateOfAmsterdam completionHandler:^(City * _Nullable city, NSError * _Nullable error) {
        XCTAssert([city.name length] != 0);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:10];
}

- (void)testGetCurrentWeather {
    XCTestExpectation *expectation = [self expectationWithDescription:@"get weather for city"];
    
    City *city = [City cityWithName:@"Amsterdam" locationCoordinate:CLLocationCoordinate2DMake(52.3745291, 4.7585304)];
    
    [city getCurrentWeatherWithCompletionHandler:^(Weather * _Nullable weather, NSError * _Nullable error) {
        XCTAssertNotNil(weather);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:20];
}

- (void)testForecastCurrentWeather {
    XCTestExpectation *expectation = [self expectationWithDescription:@"get weather for city"];
    
    City *city = [City cityWithName:@"Amsterdam" locationCoordinate:CLLocationCoordinate2DMake(52.3745291, 4.7585304)];
    
    [city getForecastWeatherWithCompletionHandler:^(NSArray<Weather *> * _Nullable weatherArray, NSError * _Nullable error) {
        XCTAssert([weatherArray count] != 0);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    
    [self waitForExpectations:@[expectation] timeout:20];
}

@end
