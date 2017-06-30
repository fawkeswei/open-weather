//
//  CityListTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityListTableViewController.h"
#import "AddCityViewController.h"
#import "CityWeatherTableViewController.h"

#import "CityList.h"

@interface CityListTableViewController ()

@property (nonatomic, strong) CityList *cityList;

@end

@implementation CityListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityList = [CityList cityList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCity:(UIStoryboardSegue *)segue {
    if ([segue.sourceViewController isKindOfClass:[AddCityViewController class]]) {
        AddCityViewController *addCityViewController = (AddCityViewController *)segue.sourceViewController;
        
        if (addCityViewController.selectedCity) {
            [self.cityList addCity:addCityViewController.selectedCity];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cityList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityTableViewCellIdentifier"];
    cell.textLabel.text = [self.cityList cityAtIndex:indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.cityList removeCityAtIndex:indexPath.row];
        [self.cityList saveCitiesToDisk];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CityWeatherTableViewController class]] && [sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:selectedCell];
        City *selectedCity = [self.cityList cityAtIndex:selectedIndexPath.row];
        
        CityWeatherTableViewController *cityWeatherTableViewController = (CityWeatherTableViewController *)segue.destinationViewController;
        cityWeatherTableViewController.city = selectedCity;
    }
}

@end
