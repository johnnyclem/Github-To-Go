//
//  User.m
//  Github To Go
//
//  Created by John Clem on 2/10/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "User.h"
#import "Repo.h"


@implementation User

@dynamic login;
@dynamic userId;
@dynamic avatar_url;
@dynamic gists_url;
@dynamic starred_url;
@dynamic repos_url;
@dynamic repos;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        
    }
    
    return self;
}
@end
