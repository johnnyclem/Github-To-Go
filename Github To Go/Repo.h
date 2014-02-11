//
//  Repo.h
//  Github To Go
//
//  Created by John Clem on 2/10/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface Repo : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * full_name;
@property (nonatomic, retain) NSNumber * isPrivate;
@property (nonatomic, retain) NSString * html_url;
@property (nonatomic, retain) NSString * repoDescription;
@property (nonatomic, retain) NSString * htmlString;
@property (nonatomic, retain) User *user;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context withJSONDictionary:(NSDictionary *)json;

@end
