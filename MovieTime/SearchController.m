//
//  SearchController.m
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "SearchController.h"
#import "SearchView.h"
#import "SearchTableViewCell.h"

#import "IMDBMovieDataModel.h"
#import "IMDBManager.h"
#import "IMDBSearch.h"

@interface SearchController () <IMDBManagerDelegate, SearchNavigationDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_movies;
    IMDBManager *_manager;
    
    SearchView *_searchView;
    IBOutlet UISearchBar *_searchBar;
}

@end

@implementation SearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initIMDBManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initIMDBManager];
    [self initGraphics];
}

- (void) initIMDBManager
{
    _manager = [[IMDBManager alloc] init];
    _manager.search = [[IMDBSearch alloc] init];
    _manager.search.delegate = _manager;
    _manager.delegate = self;
}

- (void) initGraphics
{
    _searchView = [[SearchView alloc] init];
    _searchView.delegate = self;
    _searchView.controller = self;
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    
    _searchBar = (UISearchBar *)[_searchView initNavigationToolBarWithNavigationController:self.navigationController andNavigationItem:self.navigationItem andSearchBar:_searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _movies = nil;
    [self.tableView reloadData];
    
    [searchBar resignFirstResponder];
    
    [_searchView addActivityIndicator];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void) {
        [_manager fetchDatasByTitle:searchBar.text];
    });
}

#pragma mark SearchNavigationDelegate

- (IBAction)didClickedCloseBarButton:(id)sender
{
    [_searchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark IMDBManagerDelegate

- (void)didReceiveMovies:(NSArray *)movies
{
    _movies = movies;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchView removeActivityIndicator];
        [self.tableView reloadData];
    });
}

- (void)didReceiveActorsProperty:(NSDictionary *)actors forMovie:(IMDBMovieDataModel *)movie
{
    [movie addActorsProperty:actors];
}

- (void)fetchingJSONFailedWithError:(NSError *)error
{
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    long numOfRows = [_movies count];
    
    if(numOfRows>0)
    {
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        return 1;
    } else [SearchView setNoDataTableView:tableView];
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_movies count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SearchTableViewCell";
    
    SearchTableViewCell *cell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.thumbnailImageView.image = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void) {
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[_movies objectAtIndex:indexPath.row] valueForKey:@"urlPoster"]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        
        if (image)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.thumbnailImageView.image = image;
                [cell setNeedsLayout];
            });
        }
    });
    
    cell.titleLabel.text = [[_movies objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.yearLabel.text = [NSString stringWithFormat:@"Year: %@ | %@", [[_movies objectAtIndex:indexPath.row] valueForKey:@"year"], [[_movies objectAtIndex:indexPath.row] valueForKey:@"type"]];
    
    return cell;
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
