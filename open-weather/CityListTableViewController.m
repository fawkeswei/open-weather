//
//  CityListTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

#import "CityListTableViewController.h"
#import "AddCityViewController.h"

#import "CityList.h"

@interface CityListTableViewController ()

@end

@implementation CityListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.dataSource = [CityList cityList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCity:(UIStoryboardSegue *)segue {
    if ([segue.sourceViewController isKindOfClass:[AddCityViewController class]] && [self.tableView.dataSource isKindOfClass:[CityList class]]) {
        AddCityViewController *addCityViewController = (AddCityViewController *)segue.sourceViewController;
        CityList *cityList = (CityList *)self.tableView.dataSource;
        
        if (addCityViewController.selectedCity) {
            [cityList addCity:addCityViewController.selectedCity];
            [self.tableView reloadData];
        }
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
