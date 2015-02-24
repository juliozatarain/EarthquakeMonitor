//
//  ViewController.m
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 23/02/15.
//  Copyright (c) 2015 juliozatarain. All rights reserved.
//

#import "EarthquakeTVC.h"
#import "RequestHelper.h"

@interface EarthquakeTVC ()

@end

@implementation EarthquakeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // initialize the refresher
    [self initializeRefresher];
    //initialize data source
    [self setEarthquakeData:[[NSMutableArray alloc] init]];
    // we set the delegate
    [[self earthquakesTableView] setDelegate:self];
    // we set the data source
    [[self earthquakesTableView] setDataSource:self];
    // we initialize the color set
    [self setColorArray:[[NSArray alloc] initWithObjects:
                         [UIColor colorWithRed:97.0f/255.0f green:193.0f/255.0f blue:16.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:124.0f/255.0f green:207.0f/255.0f blue:53.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:160.0F/255.0f green:232.0f/255.0f blue:73.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:211.0f/255.0f green:231.0f/255.0f blue:71.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:231.0f/255.0f green:210/255.0f blue:71.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:231.0f/255.0f green:166.0F/255.0f blue:71.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:230.0f/255.0f green:110.0f/255.0f blue:71.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:230.0f/255.0f green:80.0f/255.0f blue:71.0f/255.0f alpha:1.0f],
                         [UIColor colorWithRed:102.0f/255.0f green:0.0f blue:0.0f alpha:1.0f],nil]];
    
    // We request the summarized information
    [self loadData];
    
    // We schedule a timer to  reload data every minute
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(loadData) userInfo:nil repeats:YES];
}
-(void) initializeRefresher {
    [self setRefreshControl:[[UIRefreshControl alloc] init]];
    [[self refreshControl] setBackgroundColor:[UIColor whiteColor]];
    [[self refreshControl] setTintColor:[UIColor blackColor]];
    [self.refreshControl addTarget:self
                            action:@selector(loadData)
                  forControlEvents:UIControlEventValueChanged];
}
-(void) loadData {
    [[RequestHelper sharedHTTPClient] get:@"summary/all_hour.geojson" completion:^(id responseObject) {
        if([responseObject objectForKey:@"features"] && [responseObject objectForKey:@"features"] != [NSNull null]) {
            [[self earthquakeData] removeAllObjects];
            for( id eDict in [responseObject objectForKey:@"features"]) {
                if([eDict objectForKey:@"properties"] && [eDict objectForKey:@"properties"] != [NSNull null] &&  [eDict objectForKey:@"id"] && [eDict objectForKey:@"id"] != [NSNull null])
                    [[self earthquakeData] addObject:[[Earthquake alloc] initWithDict:[eDict objectForKey:@"properties"] andWithId:[eDict objectForKey:@"id"]]];
            }
        }
        [[self earthquakesTableView] reloadData];
        [self.refreshControl endRefreshing];
        // update title
        [self updateTitle];
    } failure:^(NSError *error) {
        NSLog(@"error %@",[error description]);
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"earthquakeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"earthquakeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // we set the earthquake information
    [[cell textLabel] setText:[[[self earthquakeData] objectAtIndex:[indexPath row]] ePlace]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Magnitude: %.02f",[[[[self earthquakeData] objectAtIndex:[indexPath row]] eMagnitude] floatValue]]];
    // we get the appropriate color index from the magnitude
    int colorIndex = (int)floor([[[[self earthquakeData] objectAtIndex:[indexPath row]] eMagnitude] floatValue]);
    if(colorIndex > 9 )
        colorIndex = 9;
    else if(colorIndex < 0)
        colorIndex = 0;
    [cell setBackgroundColor:[[self colorArray] objectAtIndex:colorIndex]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self earthquakeData] count];
}
- (IBAction)refreshButtonAction:(id)sender {
    [self loadData];
}
-(void) updateTitle {
    [[self titleItem] setTitle:[NSString stringWithFormat:@" %d Eartquakes in the last hour", [[self earthquakeData] count]]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // we prove the destination view controller with the earthquake object
    if ([segue.identifier isEqualToString:@"detailSegue"])
        [(EarthquakeDetailVC*)[segue destinationViewController] setEarthquake:[[self earthquakeData] objectAtIndex:[(NSIndexPath *)sender row]]];
}

@end
