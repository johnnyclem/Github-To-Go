//
//  User.h
//  Github To Go
//
//  Created by John Clem on 2/10/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Repo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSDecimalNumber * userId;
@property (nonatomic, retain) NSString * avatar_url;
@property (nonatomic, retain) NSString * gists_url;
@property (nonatomic, retain) NSString * starred_url;
@property (nonatomic, retain) NSString * repos_url;
@property (nonatomic, retain) NSSet *repos;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addReposObject:(Repo *)value;
- (void)removeReposObject:(Repo *)value;
- (void)addRepos:(NSSet *)values;
- (void)removeRepos:(NSSet *)values;

@end
