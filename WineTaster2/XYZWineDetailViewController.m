//
//  XYZWineDetailViewController.m
//  WineTaster2
//
//  Created by François Schapiro on 13/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZWineDetailViewController.h"

@interface XYZWineDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *WineDetailTable;
@end

@implementation XYZWineDetailViewController

- (IBAction)unwindToDetail:(UIStoryboardSegue *)segue
{
    [self reloadInputViews];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.row)
    {
        case 0:
        {
            if (self.WineDetail.Name)
                cell.textLabel.text = self.WineDetail.Name;
            else
                cell.textLabel.text = @"No name entered";
        }
        case 1:
        {
            
            if (self.WineDetail.Year)
                cell.textLabel.text = self.WineDetail.Year;
            else
                cell.textLabel.text = @"No year entered";
        }
        case 2:
        {
            if (self.WineDetail.Country)
                cell.textLabel.text = self.WineDetail.Country;
            else
                cell.textLabel.text = @"No country entered";
        }
        case 3:
        {
            if (self.WineDetail.AOC)
                cell.textLabel.text = self.WineDetail.AOC;
            else
                cell.textLabel.text = @"No region entered";
        }
        case 4:
        {
            if (self.WineDetail.Varietal)
                cell.textLabel.text = self.WineDetail.Varietal;
            else
                cell.textLabel.text = @"No varietal entered";
        }
        case 5:
        {
            if (self.WineDetail.Color)
                cell.textLabel.text = self.WineDetail.Color;
            else
                cell.textLabel.text = @"No color entered";
        }
        case 6:
        {
            NSArray *CellLines = [self CalculateTasteInfoLines];
            cell.textLabel.text = CellLines[0];
            cell.detailTextLabel.text = CellLines[1];
        }
    }
    
    return cell;
}


// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        // Get the new view controller using [segue destinationViewController].
    
        // Pass the selected object to the new view controller.


}

@end
