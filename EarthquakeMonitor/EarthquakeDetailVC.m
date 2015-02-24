//
//  EarthquakeDetailVC.m
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 24/02/15.
//  Copyright (c) 2015 juliozatarain. All rights reserved.
//


#import "EarthquakeDetailVC.h"

@interface EarthquakeDetailVC ()

@end

@implementation EarthquakeDetailVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // we initialize the point
    [self setPoint:[[MKPointAnnotation alloc] init]];
    // we initialize the date formatter
    [self setEDateFormatter:[[NSDateFormatter alloc] init]];
    [[self eDateFormatter] setDateFormat:@"MM/dd/yyyy hh:mma"];
    [self requestEarthquakeDetail];
    [self setTitle:[[self earthquake] ePlace]];
}
-(void) requestEarthquakeDetail {
   self.eTask =  [[RequestHelper sharedHTTPClient] get:[NSString stringWithFormat:@"detail/%@.geojson",[[self earthquake] eId]] completion:^(id responseObject) {
        [[self earthquake] setDetailInfoWithDict:responseObject];
        [self setDetailText];
        [self dropPinWithLatitude:[NSNumber numberWithFloat:[[self earthquake] eLatitude]] AndLongitude:[NSNumber numberWithFloat:[[self earthquake] eLongitude]]];
    } failure:^(NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
}

-(void)viewDidDisappear:(BOOL)animated {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) dropPinWithLatitude:(NSNumber*)latitude AndLongitude:(NSNumber*)longitude {
    [[self point] setCoordinate:CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue])];
    //If you want to clear other pins/annotations this is how to do it
    for (id annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    //Drop pin on map
    [[self mapView] setCenterCoordinate:[[self point] coordinate] animated:YES];
    [[self mapView] addAnnotation:[self point]];
}
- (void) setDetailText{
    [[self textView] setText:[NSString stringWithFormat:@"The earthquake happened %@, with a magnitude of %.02f, depth of %.02f and happened %@.", [[self earthquake] ePlace], [[[self earthquake] eMagnitude] floatValue],[[self earthquake] depth], [[self eDateFormatter] stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[self earthquake] eDate]/1000]]]];
}
@end
