//
//  XYZAddTasteInfoViewController.m
//  WineTaster2
//
//  Created by François Schapiro on 26/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZAddTasteInfoViewController.h"

#define kGoodAlltheTime       @"Good in any occasion"
#define kGoodDrink            @"Good for a drink"
#define kGoodMeat             @"Good with meat"
#define kGoodFish             @"Good with fish"
#define kGoodCheese           @"Good with cheese"
#define kGoodDessert          @"Good with dessert"
#define kBad                  @"Bad"

@interface XYZAddTasteInfoViewController ()

@property NSMutableArray *OverallTasteInfo;
@property NSArray *TasteInfoLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end


@implementation XYZAddTasteInfoViewController

- (void)loadInitialData {
    
    self.OverallTasteInfo = [[NSMutableArray alloc] init];
    self.TasteInfoLabel =@[kGoodAlltheTime,kGoodDrink,kGoodMeat,kGoodFish,kGoodCheese,kGoodDessert,kBad];
    if (self.SelectedTasteInfo)
        [self.OverallTasteInfo setArray:self.SelectedTasteInfo];
    else
        [self.OverallTasteInfo addObjectsFromArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@NO]];
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self loadInitialData];
    [self.doneButton setEnabled:NO];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.OverallTasteInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TasteInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([self.OverallTasteInfo[indexPath.row]  isEqual:@NO])
    {
        cell.accessoryType = UITableViewCellAccessoryNone  ;
        
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }
    cell.textLabel.text = self.TasteInfoLabel[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];;
    [self.tableView beginUpdates];
    if ([self.OverallTasteInfo[indexPath.row]  isEqual:@NO])
    {
        self.OverallTasteInfo[indexPath.row] = @YES;
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }
    else
    {
        self.OverallTasteInfo[indexPath.row] = @NO;
        cell.accessoryType = UITableViewCellAccessoryNone ;
    }
    
    if([self.OverallTasteInfo[indexPath.row]  isEqual:@YES] && (indexPath.row == 0))
    {
        [self.OverallTasteInfo setArray:@[@YES,@NO,@NO,@NO,@NO,@NO,@NO]];
    }
    if([self.OverallTasteInfo[indexPath.row]  isEqual:@YES] && (indexPath.row == 6))
    {
        [self.OverallTasteInfo setArray:@[@NO,@NO,@NO,@NO,@NO,@NO,@YES]];
    }
    if([self.OverallTasteInfo[indexPath.row]  isEqual:@YES] && (indexPath.row < 6) && (indexPath.row > 0))
     {
        self.OverallTasteInfo[0]=@NO;
        self.OverallTasteInfo[6]=@NO;
     }
    
    
    cell.textLabel.text = self.TasteInfoLabel[indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.doneButton setEnabled:YES];
    [self.tableView endUpdates];
    
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender != self.doneButton) return;
    if (sender == self.doneButton)
    {
        self.SelectedTasteInfo = [self.OverallTasteInfo copy];
    }
}


@end
