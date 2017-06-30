

//
//  CityListTests.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "CityList.h"

@interface CityListTests : XCTestCase

@property (nonatomic, strong) CityList *cityList;

@end

@implementation CityListTests

- (void)setUp {
    [super setUp];
    
    self.cityList = [CityList cityList];
    
    [self.cityList addCity:[City cityWithName:@"Amsterdam" locationCoordinate:CLLocationCoordinate2DMake(52.3745291, 4.7585304)]];
    [self.cityList addCity:[City cityWithName:@"Taipei" locationCoordinate:CLLocationCoordinate2DMake(23.5821073, 118.7761817)]];
}

- (void)tearDown {
    self.cityList = nil;
    
    [super tearDown];
}

- (void)testAddCity {
    XCTAssertEqual(2, [self.cityList tableView:[[UITableView alloc] init] numberOfRowsInSection:0]);
    
    [self.cityList addCity:[City cityWithName:@"Pacific" locationCoordinate:CLLocationCoordinate2DMake(18.072629, 163.7364493)]];

    XCTAssertEqual(3, [self.cityList tableView:[[UITableView alloc] init] numberOfRowsInSection:0]);
}

- (void)testDeleteCity {
    XCTAssertEqual(2, [self.cityList tableView:[[UITableView alloc] init] numberOfRowsInSection:0]);
    
    NSIndexPath *indexPathToDelete = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.cityList tableView:[[UITableView alloc] init] commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPathToDelete];
    
    XCTAssertEqual(1, [self.cityList tableView:[[UITableView alloc] init] numberOfRowsInSection:0]);
}

@end
