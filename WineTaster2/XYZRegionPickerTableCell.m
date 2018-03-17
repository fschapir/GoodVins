//
//  XYZRegionPickerTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 14/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZRegionPickerTableCell.h"

@implementation XYZRegionPickerTableCell

@synthesize RegionPicker;

/*- (void)regionPicker:(XYZRegionPicker *)picker didSelectRegionWithName:(NSString *)name
{
    self.Region = name;
}*/

-(void)SetCountry:(NSString *) Country
{
    self.Country = Country;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetRegion:(NSString *) Region withCountry:(NSString *)Country
{
    [self.RegionPicker setSelectedRegionName:Region withCountry:Country];
    self.Country = Country;
    self.Region = Region;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    //self.RegionPicker.Regiondelegate = self;
    
    if(self.Region)
    {
       [self.RegionPicker initWithRegion:self.Region withCountry:self.Country];
    }
    else
    {[self.RegionPicker initWithCountry:self.Country];}
}

@end
