//
//  TableViewCellDelegate.h
//  InMovies
//
//  Created by Buzoianu Stefan on 06/09/2016.
//  Copyright © 2016 Buzoianu Stefan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellDelegate <NSObject>

- (void)didInvokedCellTapGesture:(UITableViewCell *)sender;

@end
