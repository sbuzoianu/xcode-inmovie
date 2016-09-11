//
//  WebNavigatorController.m
//  InMovies
//
//  Created by Buzoianu Stefan on 10/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "WebNavigatorController.h"
#import "WebNavigatorView.h"

@interface WebNavigatorController () <UIScrollViewDelegate>
{
    WebNavigatorView *_view;
}

@end

@implementation WebNavigatorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initGraphics];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _view = nil;
    
    for(UIView *view in self.view.subviews)
    [view removeFromSuperview];
    
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initGraphics
{
    _view = [[WebNavigatorView alloc] init];
    _view.controller = self;
    
    [_view loadPageFromUri:self.pageUri];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
