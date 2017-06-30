//
//  CityWeatherTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityWeatherTableViewController.h"
#import "WeatherTableViewCell.h"

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionCurrent,
    TableViewSectionForcast,
    
    TableViewSection_Count,
};

@interface CityWeatherTableViewController ()

@property (nonatomic, strong) Weather *currentWeather;

@end

@implementation CityWeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.city.name;
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load data

- (void)loadData {
    [self.city getCurrentWeatherWithCompletionHandler:^(Weather * _Nullable weather, NSError * _Nullable error) {
        self.currentWeather = weather;
        
        [self.tableView.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return TableViewSection_Count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == TableViewSectionCurrent) {
        return 1;
    }
    else if (section == TableViewSectionForcast) {
        return 0; // not implemented yet
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TableViewSectionCurrent) {
        WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherTableViewCellIdentifier" forIndexPath:indexPath];
        cell.temperatureLabel.text = self.currentWeather.temperature.stringValue;
        cell.humidityLabel.text = self.currentWeather.humidity.stringValue;
        cell.windSpeedLabel.text = self.currentWeather.windSpeed.stringValue;
        cell.windDirectionLabel.text = self.currentWeather.windDirection.stringValue;
        return cell;
    }
    else if (indexPath.section == TableViewSectionForcast) {
        return nil; // not implemented yet
    }
    else {
        return nil;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
