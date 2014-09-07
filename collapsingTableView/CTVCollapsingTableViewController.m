//
//  CTVCollapsingTableViewController.m
//  collapsingTableView
//
//  Created by Richard Turton on 07/09/2014.
//  Copyright (c) 2014 jrturton. All rights reserved.
//

#import "CTVCollapsingTableViewController.h"

@interface CTVCollapsingTableViewController ()

@property (nonatomic,strong) NSMutableArray *sectionOpenFlags;

@end

@implementation CTVCollapsingTableViewController

-(void)viewDidLoad
{
  [super viewDidLoad];
  self.sectionOpenFlags = [@[@NO,@NO] mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0)
  {
    // Header cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Header %d",indexPath.section + 1];
    return cell;
  }
  else
  {
    // Detail cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Detail %d",indexPath.row];
    return cell;
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0)
    return 44.0;
  
  if ([self.sectionOpenFlags[indexPath.section] boolValue])
  {
    return 44.0;
  }
  else
  {
    return 0.0;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0)
  {
    // Toggle open flag
    BOOL currentOpenStatus = [self.sectionOpenFlags[indexPath.section] boolValue];
    self.sectionOpenFlags[indexPath.section] = @(!currentOpenStatus);
    [tableView beginUpdates];
    [tableView endUpdates];
  }
}

@end
