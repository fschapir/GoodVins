//
//  XYZColorPickerTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZColorPickerTableCell.h"

@implementation XYZColorPickerTableCell

@synthesize ColorPicker;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetColor:(NSString *)Color
{
    [self.ColorPicker setSelectedColorName:Color];
    self.Color = Color;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (self.Color)
    {[self.ColorPicker initWithColor:self.Color];}
    else
    {[self.ColorPicker init];}
}

@end
