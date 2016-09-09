//
//  RootViewController.m
//  MovieTime
//
//  Created by Buzoianu Stefan on 03/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "RootController.h"
#import "RootView.h"

#import "BlurryModalSegue.h"

@interface RootController () <MainNavigationDelegate>
{
    RootView *_mainView;
}

@end

@implementation RootController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[_manager fetchDatasByTitle:@"pirates+of+the"];
    //[_manager fetchActorsByMovie: [_movies objectAtIndex:0]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initGraphics];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mainView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initGraphics
{
    _mainView = [[RootView alloc] init];
    _mainView.delegate = self;
    
    [_mainView initNavigationToolBarWithNavigationController:self.navigationController andNavigationItem:self.navigationItem];
    
    [RootView addBlurredBgToMainView:self.view];
}

#pragma mark MainNavigationDelegate

- (IBAction)didClickedAddBarButton:(id)sender
{
    SearchController *searchPage = [[SearchController alloc] initWithNibName:@"SearchView" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchPage];
    
    BlurryModalSegue *segue = [[BlurryModalSegue alloc] initWithIdentifier:@"SearchView" source:self destination:navigationController];
    [segue setBackingImageBlurRadius:@(15)];
    [segue setBackingImageSaturationDeltaFactor:@(.15)];
    [segue setBackingImageTintColor: [[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
    
    [segue perform];
}

@end
