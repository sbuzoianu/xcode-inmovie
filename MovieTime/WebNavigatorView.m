//
//  WebNavigatorView.m
//  InMovies
//
//  Created by Buzoianu Stefan on 10/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import "WebNavigatorView.h"

@implementation WebNavigatorView

- (void)loadPageFromUri:(NSString *)pageUri
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    NSURL *pageUrl = [NSURL URLWithString:pageUri];
    NSURLRequest *request = [NSURLRequest requestWithURL:pageUrl];
    
    [self.controller.view addSubview:webView];
    [webView loadRequest:request];
}

@end
