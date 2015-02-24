//
//  ViewController.h
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 23/02/15.
//  Copyright (c) 2015 juliozatarain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Earthquake.h"
#import "EarthquakeDetailVC.h"

@interface EarthquakeTVC : UITableViewController<UITableViewDelegate,UITableViewDataSource>

// data source for the tableview
@property NSMutableArray *earthquakeData;

// color set
@property NSArray *colorArray;

//tableView IBOutlet
@property (weak, nonatomic) IBOutlet UITableView *earthquakesTableView;

//title item
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
// action for refresh button
- (IBAction)refreshButtonAction:(id)sender;
@end

