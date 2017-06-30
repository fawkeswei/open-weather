//
//  SettingsTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

@import SafariServices;

#import "SettingsTableViewController.h"
#import "CityList.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *helpPageStaticCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteAllCitiesStaticCell;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell == self.helpPageStaticCell) {
        NSURL *helpPageUrl = [NSURL URLWithString:@"http://open-weather.getforge.io/"];
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:helpPageUrl];
        [self presentViewController:safariViewController animated:YES completion:nil];
    }
    else if (selectedCell == self.deleteAllCitiesStaticCell) {
        UIAlertController *deleteConfirmation = [UIAlertController alertControllerWithTitle:@"Delete All Cities" message:@"All your saved cities will be deleted." preferredStyle:UIAlertControllerStyleAlert];
        [deleteConfirmation addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CityList cityList] deleteSavedCities];
        }]];
        [deleteConfirmation addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:deleteConfirmation animated:YES completion:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (IBAction)dismissSettingsTableView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
