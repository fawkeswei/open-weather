//
//  SettingsTableViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

@import SafariServices;

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *helpPageStaticCell;

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
