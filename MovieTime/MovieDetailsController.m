//
//  MovieDetailsController.m
//  InMovies
//
//  Created by Buzoianu Stefan on 06/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "MovieDetailsController.h"
#import "MovieDetailsView.h"

@interface MovieDetailsController ()
{
    MovieDetailsView *_view;
}

@end

@implementation MovieDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initGraphics];
}

- (void)initGraphics
{
    _view = [[MovieDetailsView alloc] init];
    _view.controller = self;
    
    [_view setNavigationBarButtons];
    [_view initScrollView];
    
    [_view populateScrollViewWithMoviesFromList];
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
