//
//  CFMasterViewController.m
//  Github To Go
//
//  Created by John Clem on 2/3/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFMasterViewController.h"
#import "CFNetworkController.h"
#import "CFDetailViewController.h"

@interface CFMasterViewController () <UISearchBarDelegate>
{
    NSMutableArray *_repos;
}
@end

@implementation CFMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (CFDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    CFNetworkController *networkController = [CFNetworkController new];
    _repos = [networkController reposForSearchString:@"iOS"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSMutableDictionary *repo = _repos[indexPath.row];
    cell.textLabel.text = [repo objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *repo = _repos[indexPath.row];
    self.detailViewController.repo = repo;
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchString = searchBar.text;
    CFNetworkController *networkController = [CFNetworkController new];
    _repos = [networkController reposForSearchString:searchString];
    [self.tableView reloadData];
}

@end
