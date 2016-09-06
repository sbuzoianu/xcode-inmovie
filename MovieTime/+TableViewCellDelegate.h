//
//  TableViewCellDelegate.h
//  InMovies
//
//  Created by Marius Ilie on 06/09/2016.
//  Copyright © 2016 Marius Ilie. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellDelegate <NSObject>

- (void)didInvokedCellTapGesture:(UITableViewCell *)sender;

@end
