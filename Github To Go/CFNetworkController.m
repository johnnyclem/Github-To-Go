//
//  CFNetworkController.m
//  Github To Go
//
//  Created by John Clem on 2/3/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFNetworkController.h"

@implementation CFNetworkController

- (NSMutableArray *)reposForSearchString:(NSString *)searchString
{
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@", searchString];
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    NSError *error;
    NSMutableDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    if (error) {
        NSLog(@"Error deserializing JSON: %@", error.debugDescription);
    } else {
        NSMutableArray *repos = [searchDict objectForKey:@"items"];
        return repos;
    }
    
    return [NSMutableArray arrayWithObject:error];
}

@end
