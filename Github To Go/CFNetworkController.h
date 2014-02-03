//
//  CFNetworkController.h
//  Github To Go
//
//  Created by John Clem on 2/3/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFNetworkController : NSObject

- (NSMutableArray *)reposForSearchString:(NSString *)searchString;

@end
