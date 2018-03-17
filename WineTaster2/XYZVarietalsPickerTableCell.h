//
//  XYZVarietalsPickerTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZVarietalsPicker.h"

@interface XYZVarietalsPickerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYZVarietalsPicker *VarietalsPicker;
@property NSString *Country;
@property NSString *Region;
@property NSString *Varietals;

-(void)SetVarietal:(NSString *)Varietal;

@end
