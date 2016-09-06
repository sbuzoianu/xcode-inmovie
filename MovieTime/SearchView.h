//
//  SearchView.h
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "+NavigationDelegates.h"

@interface SearchView : UITableView

@property (nonatomic, weak) id<SearchNavigationDelegate, UITableViewDelegate> delegate;
@property (nonatomic, strong) UITableViewController<UISearchBarDelegate> *controller;
@property (nonatomic, strong) UIActivityIndicatorView *loadDataMonitor;
@property (nonatomic, assign) CGPoint offset;

- (id)initNavigationToolBarWithNavigationController:(UINavigationController *)navController andNavigationItem:(UINavigationItem *)navItem andSearchBar:(UISearchBar *)searchBar;

- (void)addActivityIndicator;
- (void)removeActivityIndicator;

+ (void)setNoDataTableView:(UITableView *)tableView;

@end
