//
//  Repo.m
//  Github To Go
//
//  Created by John Clem on 2/10/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "Repo.h"


@implementation Repo

@dynamic repoID;
@dynamic name;
@dynamic full_name;
@dynamic isPrivate;
@dynamic html_url;
@dynamic repoDescription;
@dynamic user;
@dynamic htmlString;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context withJSONDictionary:(NSDictionary *)json
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        [self parseJSONDictionary:json];
    }
    
    return self;
}

- (void) parseJSONDictionary:(NSDictionary *)dic
{
	// PARSER
	id id_ = [dic objectForKey:@"id"];
	if([id_ isKindOfClass:[NSNumber class]])
	{
		self.repoID = id_;
	}
    
	id name_ = [dic objectForKey:@"name"];
	if([name_ isKindOfClass:[NSString class]])
	{
		self.name = name_;
	}
    
	id full_name_ = [dic objectForKey:@"full_name"];
	if([full_name_ isKindOfClass:[NSString class]])
	{
		self.full_name = full_name_;
	}
    
//	id owner_ = [dic objectForKey:@"owner"];
//	if([owner_ isKindOfClass:[NSDictionary class]])
//	{
//		self.user = [[User alloc] initWithJSONDictionary:owner_];
//	}
    
	id private_ = [dic objectForKey:@"private"];
	if([private_ isKindOfClass:[NSNumber class]])
	{
		self.isPrivate = private_;
	}
    
	id html_url_ = [dic objectForKey:@"html_url"];
	if([html_url_ isKindOfClass:[NSString class]])
	{
		self.html_url = html_url_;
	}
    
	id description_ = [dic objectForKey:@"description"];
	if([description_ isKindOfClass:[NSString class]])
	{
		self.repoDescription = description_;
	}
    
    NSError *error;
    [self.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error Saving Object %@.  %@", self, error);
    }
}

@end
