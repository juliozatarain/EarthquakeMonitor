//
//  EarthquakeDetailVC.h
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 24/02/15.
//  Copyright (c) 2015 juliozatarain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Earthquake.h"
#import "RequestHelper.h"
#import "CustomTextView.h"
@interface EarthquakeDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet CustomTextView *textView;
@property Earthquake *earthquake;
@property RequestHelper *requestor;
@property NSURLSessionTask *eTask;
@property MKPointAnnotation *point;
@property NSDateFormatter *eDateFormatter;
@end
