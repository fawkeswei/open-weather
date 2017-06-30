//
//  CityWeatherTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityWeatherTableViewController.h"
#import "WeatherTableViewCell.h"
#import "Weather+ViewModel.h"

typedef NS_ENUM(NSUInteger, TableViewSection) {
    TableViewSectionCurrent,
    TableViewSectionForcast,
    
    TableViewSection_Count,
};

@interface CityWeatherTableViewController ()

@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSArray<Weather *> *forecastWeather;

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
    
    [self.city getForecastWeatherWithCompletionHandler:^(NSArray<Weather *> * _Nullable weatherArray, NSError * _Nullable error) {
        self.forecastWeather = weatherArray;
        
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
        return self.forecastWeather.count;
    }
    else {
        return 0;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == TableViewSectionCurrent) {
        return @"Current Weather";
    }
    else if (section == TableViewSectionForcast) {
        return @"Forecast Weather";
    }
    else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Weather *weather = nil;
    if (indexPath.section == TableViewSectionCurrent) {
        weather = self.currentWeather;
    }
    else if (indexPath.section == TableViewSectionForcast) {
        weather = self.forecastWeather[indexPath.row];
    }
    else {
        NSAssert(nil, @"unknown section");
    }
    
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherTableViewCellIdentifier" forIndexPath:indexPath];
    cell.dateLabel.text = weather.stringFromDate;
    cell.temperatureLabel.text = weather.stringFromTemperature;
    cell.humidityLabel.text = weather.stringFromHumidity;
    cell.windSpeedLabel.text = weather.stringFromWindSpeed;
    cell.windDirectionLabel.text = weather.stringFromWindDirection;
    return cell;
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
