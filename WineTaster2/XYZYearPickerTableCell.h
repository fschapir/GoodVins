//
//  XYZYearPickerTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 24/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZYearPicker.h"

@interface XYZYearPickerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYZYearPicker *yearPicker;
@property NSString *Year;

-(void)SetYear:(NSString *)Year;

@end
