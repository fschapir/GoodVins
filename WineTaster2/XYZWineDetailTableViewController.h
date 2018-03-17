//
//  XYZWineDetailTableViewController.h
//  WineTaster2
//
//  Created by François Schapiro on 27/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZWine.h"

@interface XYZWineDetailTableViewController : UITableViewController<UIAlertViewDelegate>

@property (nonatomic,strong) XYZWine *WineDetail;
@property (nonatomic,weak) NSNumber *DeletionRequest;
@property NSIndexPath *IndexOfOrigin;

- (IBAction)unwindToDetail:(UIStoryboardSegue *)segue;
- (IBAction)share:(id)sender;
- (IBAction)ProposeDeletion:(id)sender;

@end
