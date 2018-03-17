//
//  XYZMyTasteListViewController.m
//  WineTaster2
//
//  Created by François Schapiro on 13/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZMyTasteListViewController.h"

#import "XYZWineDetailTableViewController.h"

#import "XYZAddNewTasteTableViewController.h"

#import "XYZWine.h"


@interface XYZMyTasteListViewController ()

@property NSMutableArray *WineList;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedListFilter;
@property NSMutableDictionary *WineDicoByColor;
@property NSMutableDictionary *WineDicoByArea;
@property NSMutableDictionary *WineDicoByTaste;

@end

@implementation XYZMyTasteListViewController

- (void) SetListFilteredbyColor {

    _WineDicoByColor = nil;
    for (XYZWine *WineTest in self.WineList) {
        // do something with object
        NSString *KeyOfWineColor;
        
        if (WineTest.Color)
        {KeyOfWineColor = WineTest.Color;}
        else
        {KeyOfWineColor = @"(No color entered)";}
        
        if (!_WineDicoByColor)
        {
            //first entry of a key in the dictionary
            _WineDicoByColor = [NSMutableDictionary dictionary];
            [_WineDicoByColor setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:KeyOfWineColor];
        }
        else
        {
            NSMutableArray *AreaArray = [_WineDicoByColor objectForKey:KeyOfWineColor];
            if (!AreaArray)
            {
                //first entry of this key in the dictionary
                [_WineDicoByColor setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:KeyOfWineColor];
            }
            else
            {
                //add value to the array associated to the key
                [AreaArray addObject:@[WineTest]];
                [_WineDicoByColor setObject:AreaArray forKey:KeyOfWineColor];
            }
        }
    }

}

- (void) SetListFilteredbyArea {

    _WineDicoByArea = nil;
    for (XYZWine *WineTest in self.WineList) {
        // do something with object
        NSString *KeyOfWineArea;
        
        if (WineTest.Country && !WineTest.AOC)
        {KeyOfWineArea = WineTest.Country;}
        else if (!WineTest.Country && WineTest.AOC)
        {KeyOfWineArea = WineTest.AOC;}
        else if (WineTest.Country && WineTest.AOC)
        {KeyOfWineArea = [NSString stringWithFormat:@"%@ - %@",WineTest.Country, WineTest.AOC];}
        else
        {KeyOfWineArea = @"(No region nor country entered)";}
        
        if (!_WineDicoByArea)
        {
            //first entry of a key in the dictionary
            _WineDicoByArea = [NSMutableDictionary dictionary];
            [_WineDicoByArea setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:KeyOfWineArea];
        }
        else
        {
            NSMutableArray *AreaArray = [_WineDicoByArea objectForKey:KeyOfWineArea];
            if (!AreaArray)
            {
                //first entry of this key in the dictionary
                [_WineDicoByArea setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:KeyOfWineArea];
            }
            else
            {
                //add value to the array associated to the key
                [AreaArray addObject:@[WineTest]];
                [_WineDicoByArea setObject:AreaArray forKey:KeyOfWineArea];
            }
        }
    }

}

- (void) SetListFilteredbyTaste {
    
    _WineDicoByTaste = [NSMutableDictionary dictionaryWithObjects:@[@[],@[],@[],@[],@[],@[],@[],@[],@[],@[]] forKeys:@[@"In any occasion",@"For a drink",@"With meat",@"With fish",@"With cheese",@"With dessert",@"With meat, cheese and dessert",@"With fish, cheese and dessert",@"Bad",@"No info on taste"]];
    
    NSMutableArray *ValueForKeyNoInfo =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyAnyOcc =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyBad =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyDrink =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyMeat =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyFish =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyCheese =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyDessert =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyMeatMeal =[[NSMutableArray alloc] init];
    NSMutableArray *ValueForKeyFishMeal =[[NSMutableArray alloc] init];
    
    for (XYZWine *WineTest in self.WineList) {
        // do something with object
        // NSArray *KeyOfWineTaste = [WineTest.TasteInfo copy];
        
        if (!WineTest.TasteInfo)
        {
            //add new entry for the key
            [ValueForKeyNoInfo addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyNoInfo forKey:@"No info on taste"];
        }
        else
        {
        if ([WineTest.TasteInfo[0] isEqual:@YES])
        {
            [ValueForKeyAnyOcc addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyAnyOcc forKey:@"In any occasion"];
        }
        if ([WineTest.TasteInfo[6] isEqual:@YES])
        {
            [ValueForKeyBad addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyBad forKey:@"Bad"];
        }
        if ([WineTest.TasteInfo[1] isEqual:@YES])
        {
            [ValueForKeyDrink addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyDrink forKey:@"For a drink"];
        }
        if ([WineTest.TasteInfo[2] isEqual:@YES])
        {
            [ValueForKeyMeat addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyMeat forKey:@"With meat"];
        }
        if ([WineTest.TasteInfo[3] isEqual:@YES])
        {
            [ValueForKeyFish addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyFish forKey:@"With fish"];
        }
        if ([WineTest.TasteInfo[4] isEqual:@YES])
        {
            [ValueForKeyCheese addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyCheese forKey:@"With cheese"];
        }
        if ([WineTest.TasteInfo[5] isEqual:@YES])
        {
            [ValueForKeyDessert addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyDessert forKey:@"With dessert"];
        }
        if ([WineTest.TasteInfo[2] isEqual:@YES] && [WineTest.TasteInfo[4] isEqual:@YES] && [WineTest.TasteInfo[5] isEqual:@YES])
        {
            [ValueForKeyMeatMeal addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyMeatMeal forKey:@"With meat, cheese and dessert"];
            //[_WineDicoByTaste setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:@"With meat, cheese and dessert"];
        }
        if ([WineTest.TasteInfo[3] isEqual:@YES] && [WineTest.TasteInfo[4] isEqual:@YES] && [WineTest.TasteInfo[5] isEqual:@YES])
        {
            [ValueForKeyFishMeal addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyFishMeal forKey:@"With fish, cheese and dessert"];
            //[_WineDicoByTaste setObject:[NSMutableArray arrayWithObjects:@[WineTest],nil] forKey:@"With fish, cheese and dessert"];
        }
        if ([WineTest.TasteInfo[0] isEqual:@NO] && [WineTest.TasteInfo[1] isEqual:@NO] && [WineTest.TasteInfo[2] isEqual:@NO] && [WineTest.TasteInfo[3] isEqual:@NO] &&[WineTest.TasteInfo[4] isEqual:@NO] && [WineTest.TasteInfo[5] isEqual:@NO] && [WineTest.TasteInfo[6] isEqual:@NO])
        {
            [ValueForKeyNoInfo addObjectsFromArray:@[WineTest]];
            [_WineDicoByTaste setObject:ValueForKeyNoInfo forKey:@"No info on taste"];
        }
        }
        
    }
    
    for(NSString *KeyToCheck in [self.WineDicoByTaste allKeys])
    {
        if([[self.WineDicoByTaste objectForKey:KeyToCheck] count]==0)
            [self.WineDicoByTaste removeObjectForKey:KeyToCheck];
    }
    
}


NSInteger compareWines(id wine1, id wine2, void *context)
{
    
    int retour;
    // fist we need to cast all the parameters
    //CLLocation* location = context;
    XYZWine* param1 = wine1;
    XYZWine* param2 = wine2;
    
    NSInteger NameComparisonResult = [param1.Name caseInsensitiveCompare:param2.Name];
    
    //make the comparaison
    if (NameComparisonResult == NSOrderedSame)
        retour = [param1.Year caseInsensitiveCompare:param2.Year];
    else
        retour = NameComparisonResult;
    
    return retour;
    
}

NSInteger compareColors(id Color1, id Color2, void *context)
{
    
    // fist we need to cast all the parameters
    //CLLocation* location = context;
    NSString* param1 = Color1;
    NSString* param2 = Color2;
    
    if([param1 isEqualToString:param2])
    {return NSOrderedSame;}
    
    //Red is always on top
    if ([param1 isEqualToString:@"Red"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"Red"])
    {    return NSOrderedDescending;}
    
    //White is always second to Red and first to Rosé
    //White case covered by the other cases
    
    
    //Rosé is always last
    if ([param1 isEqualToString:@"Rosé"])
    {    return NSOrderedDescending;}
    if ([param2 isEqualToString:@"Rosé"])
    {    return NSOrderedAscending;}
    
    //just in case none of the above cases is true
    //this code should never be called and is here to over compiler blocking
    return NSOrderedSame;
    
}

NSInteger compareTastes(id Taste1, id Taste2, void *context)
{
    
    // fist we need to cast all the parameters
    //CLLocation* location = context;
    NSString* param1 = Taste1;
    NSString* param2 = Taste2;
    
    if([param1 isEqualToString:param2])
    {return NSOrderedSame;}
    
    //Any occasion is always on top
    if ([param1 isEqualToString:@"In any occasion"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"In any occasion"])
    {    return NSOrderedDescending;}
    
    //For a drink is always second to In any occasion and first to all others
    if ([param1 isEqualToString:@"For a drink"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"For a drink"])
    {    return NSOrderedDescending;}
    
    //Meat is always second to drink
    if ([param1 isEqualToString:@"With meat"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With meat"])
    {    return NSOrderedDescending;}
    
    //Fish is always second to Meat
    if ([param1 isEqualToString:@"With fish"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With fish"])
    {    return NSOrderedDescending;}
    
    //Cheese is always second to Fish
    if ([param1 isEqualToString:@"With cheese"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With cheese"])
    {    return NSOrderedDescending;}
    
    //Dessert is always second to Cheese
    if ([param1 isEqualToString:@"With dessert"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With dessert"])
    {    return NSOrderedDescending;}
    
    //Meat meal is always second to Dessert
    if ([param1 isEqualToString:@"With meat, cheese and dessert"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With meat, cheese and dessert"])
    {    return NSOrderedDescending;}
    
    //Fish meal is always second to Dessert
    if ([param1 isEqualToString:@"With fish, cheese and dessert"])
    {    return NSOrderedAscending;}
    if ([param2 isEqualToString:@"With fish, cheese and dessert"])
    {    return NSOrderedDescending;}
    
    //No Info is always last
    if ([param1 isEqualToString:@"No info on taste"])
    {    return NSOrderedDescending;}
    if ([param2 isEqualToString:@"No info on taste"])
    {    return NSOrderedAscending;}
    
    //just in case none of the above cases is true
    //this code should never be called and is here to over compiler blocking
    return NSOrderedSame;
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    self.navigationController.toolbarHidden = YES;
    [self.tableView reloadData];
}

- (IBAction)unwindToListAdding:(UIStoryboardSegue *)segue
{
    XYZAddNewTasteTableViewController *source = [segue sourceViewController];
    XYZWine *NewWine = source.NewTaste;
    if (NewWine != nil) {
        [self.WineList addObject:NewWine];
        _WineDicoByColor = nil;
        _WineDicoByArea = nil;
        _WineDicoByTaste = nil;
        _SegmentedListFilter.selectedSegmentIndex=-1;
        
        if (source.EditTaste)
        {[self.WineList removeObjectIdenticalTo:source.EditTaste];}
        
        [self.WineList sortUsingFunction:compareWines context:nil];
        
        [self.tableView reloadData];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.WineList];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Wines"];
    }
    self.navigationController.toolbarHidden = YES;
}

- (IBAction)BackToList:(UIStoryboardSegue *)segue
{
    XYZWineDetailTableViewController *source = [segue sourceViewController];
    if (source.DeletionRequest) {
        [self.WineList removeObjectIdenticalTo:source.WineDetail];
        _WineDicoByColor = nil;
        _WineDicoByArea = nil;
        _WineDicoByTaste = nil;
        _SegmentedListFilter.selectedSegmentIndex=-1;
        
        [self.tableView reloadData];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.WineList];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Wines"];
    }
    self.navigationController.toolbarHidden = YES;

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
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Wines"];
    if (data !=nil)
    {
        self.WineList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    if (self.WineList == nil)
    {
        self.WineList = [[NSMutableArray alloc] init];
    }
    
    [self.WineList sortUsingFunction:compareWines context:nil];
    
    [self.SegmentedListFilter addTarget:self
                                action:@selector(segmentSwitch:)
                      forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.toolbarHidden = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
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
    if (self.WineDicoByColor)
        return [self.WineDicoByColor count];
    else if (self.WineDicoByArea)
        return [self.WineDicoByArea count];
    else if (self.WineDicoByTaste)
        return [self.WineDicoByTaste count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.WineDicoByColor)
    {
        NSString *KeySection = [[self.WineDicoByColor allKeys] sortedArrayUsingFunction:compareColors context:nil][section];
        if ([[self.WineDicoByColor objectForKey:KeySection] count]==1)
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d item", KeySection, [[self.WineDicoByColor objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
        else
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d items", KeySection, [[self.WineDicoByColor objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
    }
    else if (self.WineDicoByArea)
    {
        NSString *KeySection = [[self.WineDicoByArea allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][section];
        if ([[self.WineDicoByArea objectForKey:KeySection] count]==1)
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d item", KeySection, [[self.WineDicoByArea objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
        else
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d items", KeySection, [[self.WineDicoByArea objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
    }
    else if (self.WineDicoByTaste)
    {
        NSString *KeySection = [[self.WineDicoByTaste allKeys] sortedArrayUsingFunction:compareTastes context:nil][section];
        if ([[self.WineDicoByTaste objectForKey:KeySection] count]==1)
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d item", KeySection, [[self.WineDicoByTaste objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
        else
        {
            NSString *HeaderTitle = [NSString stringWithFormat:@"%@ - %d items", KeySection, [[self.WineDicoByTaste objectForKey:KeySection] count]];
            return HeaderTitle ;
        }
    }
    else
    {    return nil;}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (self.WineDicoByColor)
    {
        NSArray *KeyArray= [[self.WineDicoByColor allKeys] sortedArrayUsingFunction:compareColors context:nil];
        return [[self.WineDicoByColor objectForKey:KeyArray[section]] count];
    }
    else if (self.WineDicoByArea)
    {
        NSArray *KeyArray= [[self.WineDicoByArea allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        return [[self.WineDicoByArea objectForKey:KeyArray[section]] count];
    }
    else if (self.WineDicoByTaste)
    {
        NSArray *KeyArray= [[self.WineDicoByTaste allKeys] sortedArrayUsingFunction:compareTastes context:nil];
        return [[self.WineDicoByTaste objectForKey:KeyArray[section]] count];
    }
    else
        return [self.WineList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListOfWinesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    XYZWine *Wine;
    
    if (self.WineDicoByColor)
    {
        Wine = [self.WineDicoByColor objectForKey:[[self.WineDicoByColor allKeys] sortedArrayUsingFunction:compareColors context:nil][indexPath.section]][indexPath.row][0];
    }
    else if (self.WineDicoByArea)
    {
        Wine = [self.WineDicoByArea objectForKey:[[self.WineDicoByArea allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][indexPath.section]][indexPath.row][0];
    }
    else if (self.WineDicoByTaste)
    {
        Wine = [self.WineDicoByTaste objectForKey:[[self.WineDicoByTaste allKeys] sortedArrayUsingFunction:compareTastes context:nil][indexPath.section]][indexPath.row];
    }
    else
    {
        Wine = [self.WineList objectAtIndex:indexPath.row];
    }
    
    // Configure the cell...
    if (Wine.Year)
    {cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", Wine.Name, Wine.Year];}
    else
    {cell.textLabel.text = Wine.Name; }
    
    if (!self.WineDicoByArea)
    {
        if (Wine.Country && !Wine.AOC)
        {cell.detailTextLabel.text = Wine.Country;}
        else if (!Wine.Country && Wine.AOC)
        {cell.detailTextLabel.text = Wine.AOC;}
        else if (Wine.Country && Wine.AOC)
        {cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",Wine.Country, Wine.AOC];}
        else
        {cell.detailTextLabel.text=nil;}
    }
    else
    {cell.detailTextLabel.text=nil;}
    
    return cell;
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    //toggle the correct view to be visible
    switch (selectedSegment)
    {
        //show all wines sorted alphabetically
        case 0:
            _WineDicoByColor = nil;
            _WineDicoByArea = nil;
            _WineDicoByTaste = nil;
            [self.tableView reloadData];
            break;
        //show all wines sorted by country-region alphabetically
        case 1:
            _WineDicoByColor = nil;
            _WineDicoByTaste = nil;
            [self SetListFilteredbyArea];
            [self.tableView reloadData];
            break;
        //show all wines sorted by color alphabetically
        case 2:
            _WineDicoByArea = nil;
            _WineDicoByTaste = nil;
            [self SetListFilteredbyColor];
            [self.tableView reloadData];
            break;
        //show all wines sorted by taste alphabetically
        case 3:
            _WineDicoByColor = nil;
            _WineDicoByArea = nil;
            [self SetListFilteredbyTaste];
            [self.tableView reloadData];
            break;
        default:
            _WineDicoByColor = nil;
            _WineDicoByArea = nil;
            _WineDicoByTaste = nil;
            [self.tableView reloadData];
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZWine *WineToRemove;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if (_WineDicoByColor)
        {
            WineToRemove = [self.WineDicoByColor objectForKey:[[self.WineDicoByColor allKeys] sortedArrayUsingFunction:compareColors context:nil][indexPath.section]][indexPath.row][0];
            [self.WineList removeObjectIdenticalTo:WineToRemove];
            _WineDicoByColor = nil;
            [self SetListFilteredbyColor];
            [self.tableView reloadData];
            
        }
        else if (_WineDicoByArea)
        {
            WineToRemove = [self.WineDicoByArea objectForKey:[[self.WineDicoByArea allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][indexPath.section]][indexPath.row][0];
            [self.WineList removeObjectIdenticalTo:WineToRemove];
            _WineDicoByArea = nil;
            [self SetListFilteredbyArea];
            [self.tableView reloadData];
        }
        else if (_WineDicoByTaste)
        {
            WineToRemove = [self.WineDicoByTaste objectForKey:[[self.WineDicoByTaste allKeys] sortedArrayUsingFunction:compareTastes context:nil][indexPath.section]][indexPath.row];
            [self.WineList removeObjectIdenticalTo:WineToRemove];
            _WineDicoByTaste = nil;
            [self SetListFilteredbyTaste];
            [self.tableView reloadData];
        }
        else
        {
            [self.WineList removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.WineList];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Wines"];
        
        self.navigationController.toolbarHidden = YES;
    }   
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }  */ 
}

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
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        XYZWine *Wine;
        
        if (self.WineDicoByColor)
        {
            Wine = [self.WineDicoByColor objectForKey:[[self.WineDicoByColor allKeys] sortedArrayUsingFunction:compareColors context:nil][selectedIndexPath.section]][selectedIndexPath.row][0];
        }
        else if (self.WineDicoByArea)
        {
            Wine = [self.WineDicoByArea objectForKey:[[self.WineDicoByArea allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)][selectedIndexPath.section]][selectedIndexPath.row][0];
        }
        else if (self.WineDicoByTaste)
        {
            Wine = [self.WineDicoByTaste objectForKey:[[self.WineDicoByTaste allKeys] sortedArrayUsingFunction:compareTastes context:nil][selectedIndexPath.section]][selectedIndexPath.row];
        }
        else
        {
            Wine = [self.WineList objectAtIndex:selectedIndexPath.row];
        }
    
        XYZWineDetailTableViewController *viewController =
        (XYZWineDetailTableViewController *)segue.destinationViewController;
        
    // Pass the selected object to the new view controller.        
        viewController.WineDetail = Wine;
        viewController.IndexOfOrigin = selectedIndexPath;
        
    }
}


@end