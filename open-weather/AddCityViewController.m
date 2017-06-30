//
//  AddCityViewController.m
//  open-weather
//
//  Created by Fawkes Wei on 30/06/2017.
//  Copyright © 2017 Fawkes Wei. All rights reserved.
//

@import MapKit;

#import "AddCityViewController.h"

#import "City.h"

@interface AddCityViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *addCityButton;

@property (nonatomic, strong) City *selectedCity;

@end

@implementation AddCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedMap:)];
    [self.mapView addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedMap:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGPoint point = [tapGestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // clear previous selection
    [self.mapView removeAnnotations:self.mapView.annotations];
    self.selectedCity = nil;
    
    // add pin on map
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinate;
    [self.mapView addAnnotation:annotation];
    
    // load city name
    [self.addCityButton setEnabled:NO];
    [self.addCityButton setTitle:@"Loading City Name..." forState:UIControlStateNormal];
    [City reverseGeocodeCoordinate:coordinate completionHandler:^(City * _Nullable city, NSError * _Nullable error) {
        if (error) {
            [self.addCityButton setTitle:@"Failed to Load City Name" forState:UIControlStateNormal];
        }
        else {
            self.selectedCity = city;
            [self.addCityButton setEnabled:YES];
            [self.addCityButton setTitle:[NSString stringWithFormat:@"Add \"%@\"", city.name] forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)dismissAddCityViewController:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
