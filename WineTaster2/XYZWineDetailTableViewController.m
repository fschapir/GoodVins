//
//  XYZWineDetailTableViewController.m
//  WineTaster2
//
//  Created by François Schapiro on 27/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZWineDetailTableViewController.h"
#import "XYZAddNewTasteTableViewController.h"

@interface XYZWineDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *HiddenSegueButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TrashButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ActionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *FlexibleSpacingButton;


@end

@implementation XYZWineDetailTableViewController

- (IBAction)unwindToDetail:(UIStoryboardSegue *)segue
{
    [self.tableView reloadData];
}

- (IBAction)share:(id)sender
{
    NSString *BaseString=@"Tasted a ";
    NSString *NameString;
    NSString *FeatureString;
    NSString *TasteInfoString;
    NSString *ShareText;
    
    if (self.WineDetail.Year)
    {NameString = [BaseString stringByAppendingFormat:@"%@ %@ ", self.WineDetail.Year, self.WineDetail.Name];}
    else
    {NameString = [BaseString stringByAppendingFormat:@"%@ ",self.WineDetail.Name];}
    
    if(self.WineDetail.AOC)
    {FeatureString = [NameString stringByAppendingFormat:@"(%@)",self.WineDetail.AOC];}
    else if(self.WineDetail.Country)
    {
        if (self.WineDetail.Color)
        {FeatureString = [NameString stringByAppendingFormat:@"(%@, %@)",self.WineDetail.Color, self.WineDetail.Country];}
        else
        {FeatureString = [NameString stringByAppendingFormat:@"(%@)",self.WineDetail.Country];}
    }
    else
    {
        if (self.WineDetail.Color)
        {FeatureString = [NameString stringByAppendingFormat:@"(%@ wine)",self.WineDetail.Color];}
        else
        {FeatureString = NameString;}
    }

    if ([self.WineDetail.TasteInfo[6] isEqual:@YES])
    {TasteInfoString = [FeatureString stringByAppendingString:@"- Tasted bad"];}
    else if (([self.WineDetail.TasteInfo[0] isEqual:@YES])||([self.WineDetail.TasteInfo[1] isEqual:@YES])||([self.WineDetail.TasteInfo[2] isEqual:@YES])||([self.WineDetail.TasteInfo[3] isEqual:@YES])||([self.WineDetail.TasteInfo[4] isEqual:@YES])||([self.WineDetail.TasteInfo[5] isEqual:@YES]))
    {TasteInfoString = [FeatureString stringByAppendingString:@"- Tasted good"];}
    else
    {TasteInfoString = FeatureString;}
    
    //NSString *AppSignature= [NSString stringWithFormat:@". Sent from %@ app",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    
    NSURL *shareURL = [NSURL URLWithString:@"http://appstore.com/goodvins"];
    
    //NSAttributedString *AppNameWithLink = [[NSAttributedString alloc] initWithString:AppSignature attributes:[NSDictionary dictionaryWithObject:shareURL forKey:NSLinkAttributeName]];
    
    NSString *AppNameWithLink = [NSString stringWithFormat:@"<html><body>. Sent from <a href=\"%@\">%@</a></body></html>",
                     shareURL,
                     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    
    ShareText = [TasteInfoString stringByAppendingString:AppNameWithLink];
    
    NSArray *objectsToShare = @[ShareText];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludedActivities = @[UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo];
    controller.excludedActivityTypes = excludedActivities;
    
    // Present the controller
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)ProposeDeletion:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete wine ?"
                                                     message:@"Do you really want to delete this wine?"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Delete", nil];
    [alert show];
}
                          
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
    //cancel clicked ... dismiss the alert
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }else{
    //Delete clicked
        [self performSegueWithIdentifier: @"DeletionConfirmed" sender: self];
    }
}

- (NSArray *) CalculateTasteInfoLines
{
    NSString *TitleLine = @"Tasted good...";
    NSString *SubtitleLine = [[NSString alloc] init];
    
    BOOL Hasinfo = NO;
    BOOL IsFirst = YES;
    
    if ([self.WineDetail.TasteInfo[0] isEqual:@YES])
    {
        SubtitleLine = @"with everything";
        return @[TitleLine,SubtitleLine];
    }
    if ([self.WineDetail.TasteInfo[6] isEqual:@YES])
    {
        TitleLine = @"Tasted bad";
        SubtitleLine = @"overall";
        return @[TitleLine,SubtitleLine];
    }
    if ([self.WineDetail.TasteInfo[1] isEqual:@YES])
    {
        Hasinfo = YES;
        SubtitleLine = @"for a drink";
        if (IsFirst)
            IsFirst = NO;
    }
    if ([self.WineDetail.TasteInfo[2] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with meat";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with meat"];
    }
    if ([self.WineDetail.TasteInfo[3] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with fish";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with fish"];
    }
    if ([self.WineDetail.TasteInfo[4] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with cheese";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with cheese"];
    }
    if ([self.WineDetail.TasteInfo[5] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with dessert";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with dessert"];
    }
    
    if (!Hasinfo)
    {
        TitleLine = @"No info on your taste";
        SubtitleLine = @"Select to precise your taste";
    }
    
    return @[TitleLine,SubtitleLine];
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
    
    self.navigationController.navigationBar.tintColor = self.editButton.tintColor;
    
    self.navigationController.toolbarHidden = NO;
    
    self.toolbarItems = [ NSArray arrayWithObjects: self.TrashButton, self.FlexibleSpacingButton, self.ActionButton, nil ];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    
    UITableViewCell *cell = nil;
    
    // Configure the cell...
    switch (indexPath.row)
    {
        case 0:
        {
            CellIdentifier = @"DetailCellName";
            break;
        }
        case 1:
        {
            CellIdentifier = @"DetailCellYear";
            break;
        }
        case 2:
        {
            CellIdentifier = @"DetailCellCountry";
            break;
        }
        case 3:
        {
            CellIdentifier = @"DetailCellRegion";
            break;
        }
        case 4:
        {
            CellIdentifier = @"DetailCellVarietal";
            break;
        }
        case 5:
        {
            CellIdentifier = @"DetailCellColor";
            break;
        }
        case 6:
        {
            CellIdentifier = @"DetailCellTasteInfo";
            break;
        }
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([CellIdentifier isEqualToString:@"DetailCellName"])
    {if (self.WineDetail.Name)
        cell.textLabel.text = self.WineDetail.Name;
    else
        cell.textLabel.text = @"No name entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellYear"])
    {if (self.WineDetail.Year)
        cell.textLabel.text = self.WineDetail.Year;
    else
        cell.textLabel.text = @"No year entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellCountry"])
    {if (self.WineDetail.Country)
        cell.textLabel.text = self.WineDetail.Country;
    else
        cell.textLabel.text = @"No country entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellRegion"])
    {if (self.WineDetail.AOC)
        cell.textLabel.text = self.WineDetail.AOC;
    else
        cell.textLabel.text = @"No region entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellVarietal"])
    {if (self.WineDetail.Varietal)
        cell.textLabel.text = self.WineDetail.Varietal;
    else
        cell.textLabel.text = @"No varietal entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellColor"])
    {if (self.WineDetail.Color)
        cell.textLabel.text = self.WineDetail.Color;
    else
        cell.textLabel.text = @"No color entered";}
    else if ([CellIdentifier isEqualToString:@"DetailCellTasteInfo"])
    {NSArray *CellLines = [self CalculateTasteInfoLines];
        cell.textLabel.text = CellLines[0];
        cell.detailTextLabel.text = CellLines[1];}
    
    return cell;
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

    if ([segue.identifier isEqualToString:@"EditWine"])
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        XYZAddNewTasteTableViewController *viewController =
        (XYZAddNewTasteTableViewController *)segue.destinationViewController;
        
         // Pass the selected object to the new view controller.
        
        viewController.EditTaste = self.WineDetail;
    }
    if ([segue.identifier isEqualToString:@"DeletionConfirmed"])
    {
        self.DeletionRequest = @YES;
    }
}


@end
