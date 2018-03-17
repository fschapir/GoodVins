//
//  XYZAddNewTasteWineNameTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZAddNewTasteWineNameTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *NameEntry;
@property NSString *Name;

-(void)SetName:(NSString *) Name;

@end
