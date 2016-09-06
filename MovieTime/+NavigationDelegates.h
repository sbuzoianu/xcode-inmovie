//
//  NavigationDelegate.h
//  InMovies
//
//  Created by Buzoianu Stefan on 04/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Nav Controllers
#import "SearchController.h"

@protocol MainNavigationDelegate <NSObject>

- (IBAction)didClickedAddBarButton:(id)sender;

@end

@protocol SearchNavigationDelegate <NSObject>

- (IBAction)didClickedCloseBarButton:(id)sender;

@end
