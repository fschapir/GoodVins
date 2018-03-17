//
//  XYZColorPickerTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZColorPicker.h"

@interface XYZColorPickerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYZColorPicker *ColorPicker;
@property NSString *Country;
@property NSString *Region;
@property NSString *Varietals;
@property NSString *Color;

-(void)SetColor:(NSString *)Color;

@end
