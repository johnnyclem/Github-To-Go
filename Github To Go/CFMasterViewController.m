//
//  CFMasterViewController.m
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFMasterViewController.h"
#import "CFDetailViewController.h"
#import "Repo.h"
#import "User.h"

@interface CFMasterViewController () <UISearchBarDelegate>

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation CFMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (CFDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self performSearch:searchBar];
}

- (void)findOrCreateNewRepo:(NSDictionary *)repo withExistingRepoID:(NSNumber *)repoID error:(NSError *)error
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"repoID == %@", repoID]];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"repoID" ascending:YES]]];
    NSArray *existingRepos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if (existingRepos.count) {
        NSLog(@"Repo %@ Already Exists", repo[@"name"]);
    } else {
        NSEntityDescription *repoEntity = [NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.managedObjectContext];
        Repo *newRepo = [[Repo alloc] initWithEntity:repoEntity insertIntoManagedObjectContext:self.managedObjectContext withJSONDictionary:repo];
        [newRepo.managedObjectContext save:&error];
        if (error) {
            NSLog(@"Error Saving New Object: %@", error);
        }
    }
}

- (void)downloadReposForSearchURL:(NSURL *)searchURL
{
    NSError *error;
    NSData *repoData = [NSData dataWithContentsOfURL:searchURL];
    NSDictionary *repoDict = [NSJSONSerialization JSONObjectWithData:repoData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];

    for (NSDictionary *repo in [repoDict objectForKey:@"items"]) {
        [self findOrCreateNewRepo:repo withExistingRepoID:repo[@"id"] error:error];
    }
}

- (IBAction)performSearch:(UISearchBar *)sender
{
    NSString *searchString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@", sender.text];
    NSURL *searchURL = [NSURL URLWithString:searchString];

    [self downloadReposForSearchURL:searchURL];
//    
//    NSArray *employeeIDs = [[listOfIDsAsString componentsSeparatedByString:@"\n"]
//                            sortedArrayUsingSelector: @selector(compare:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Repo *repo = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        self.detailViewController.repo = repo;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Repo *repo = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setRepo:repo];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Repo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Repos"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Repo *repo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.user.login;
}

@end
