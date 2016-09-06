//
//  AppDelegate.h
//  MovieTime
//
//  Created by Buzoianu Stefan on 30/08/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "RootController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootController *mainViewController;
@property (strong, nonatomic) UINavigationController *navController;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

