//
//  SearchView.m
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView


- (void) callCloseButtonDelegate:(id)sender
{
    [self.delegate didClickedCloseBarButton:sender];
}

- (id)initNavigationToolBarWithNavigationController:(UINavigationController *)navController andNavigationItem:(UINavigationItem *)navItem andSearchBar:(UISearchBar *)searchBar
{
    [navController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navController.navigationBar setShadowImage:nil];
    
    [navController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    navController.navigationBar.translucent = YES;
    
    UIBarButtonItem *closeModalButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(callCloseButtonDelegate:)];
    closeModalButton.tintColor = [UIColor whiteColor];
    
    [navItem setLeftBarButtonItem:closeModalButton];
    
    long leftPos =[[closeModalButton valueForKey:@"view"] frame].size.width + 8;
    long width = navController.navigationBar.bounds.size.width - leftPos - 15;
    long height = navController.navigationBar.bounds.size.height/2;
    
    [searchBar setFrame:CGRectMake(leftPos,10,width,height)];
    searchBar.placeholder = @"Type movie title...";
    
    [navController.navigationBar addSubview:searchBar];
    
    return (id)searchBar;
}

- (void)addActivityIndicator
{
    UITableView *tableView = self.controller.tableView;
    
    UIView *bgView = [[UIView alloc] initWithFrame:tableView.bounds];
    UIActivityIndicatorView *activIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(tableView.bounds.size.width/2-20, tableView.bounds.size.height/2-12, tableView.bounds.size.width, 40)];
    UILabel *movies = [[UILabel alloc] initWithFrame:CGRectMake(0, tableView.bounds.size.height/2+30, tableView.bounds.size.width, 40)];
    
    activIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activIndicator.tintColor = [UIColor grayColor];
    activIndicator.color = [UIColor grayColor];
    activIndicator.hidden = NO;
    [activIndicator sizeToFit];
    
    movies.text = @"Loading...";
    [movies setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    movies.textAlignment = NSTextAlignmentCenter;
    movies.textColor = [UIColor grayColor];
    
    [bgView addSubview:activIndicator];
    [bgView addSubview:movies];
    
    tableView.backgroundView = bgView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [activIndicator startAnimating];
}

- (void)removeActivityIndicator
{
    self.controller.tableView.backgroundView = nil;
}

+ (void)setNoDataTableView:(UITableView *)tableView
{
    UIView *bgView = [[UIView alloc] initWithFrame:tableView.bounds];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tableView.bounds.size.height/2-61, tableView.bounds.size.width, 80)];
    UIImage *bgImg = [UIImage imageNamed:@"television"];
    UILabel *movies = [[UILabel alloc] initWithFrame:CGRectMake(0, tableView.bounds.size.height/2+28, tableView.bounds.size.width, 40)];
    UILabel *noDataLoaded = [[UILabel alloc] initWithFrame:CGRectMake(0, tableView.bounds.size.height/2+68, tableView.bounds.size.width, 40)];
    
    imgView.image = bgImg;
    imgView.tintColor = [UIColor grayColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    movies.text = @"No Movies";
    [movies setFont:[UIFont fontWithName:@"Helvetica-Light" size:25]];
    movies.textAlignment = NSTextAlignmentCenter;
    movies.textColor = [UIColor grayColor];
    
    noDataLoaded.text = @"You can search for a movie\nusing search bar.";
    [noDataLoaded setFont:[UIFont fontWithName:@"Helvetica-Light" size:16]];
    noDataLoaded.textAlignment = NSTextAlignmentCenter;
    noDataLoaded.numberOfLines = 2;
    noDataLoaded.textColor = [UIColor grayColor];
    
    [bgView addSubview:imgView];
    [bgView addSubview:movies];
    [bgView addSubview:noDataLoaded];
    
    tableView.backgroundView = bgView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
