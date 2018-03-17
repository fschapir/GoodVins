//
//  XYZVarietalsPickerTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZVarietalsPickerTableCell.h"

@implementation XYZVarietalsPickerTableCell

@synthesize VarietalsPicker;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetVarietal:(NSString *)Varietal
{
    [self.VarietalsPicker setSelectedVarietalsName:Varietal];
    self.Varietals = Varietal;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if(self.Varietals)
    {[self.VarietalsPicker initWithVarietal:self.Varietals];}
    else
    {[self.VarietalsPicker init];}

}

@end
