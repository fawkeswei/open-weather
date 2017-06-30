
//
//  CityList.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityList.h"

@interface CityList ()

@property (nonatomic, strong) NSMutableArray<City *> *cities;

@end

@implementation CityList

+ (nonnull instancetype)cityList {
    CityList *cityList = [[CityList alloc] init];
    cityList.cities = [NSMutableArray array];
    return cityList;
}

- (void)addCity:(City * _Nonnull)city {
    [self.cities addObject:city];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @throw [[NSException alloc] init];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cities removeObjectAtIndex:indexPath.row];
    }
}

@end
