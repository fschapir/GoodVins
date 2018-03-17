//
//  XYZRegionPickerTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 14/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZRegionPicker.h"

@interface XYZRegionPickerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYZRegionPicker *RegionPicker;
@property NSString *Country;
@property NSString *Region;

-(void)SetCountry:(NSString *) Country;

-(void)SetRegion:(NSString *) Region withCountry:(NSString *)Country;

@end
