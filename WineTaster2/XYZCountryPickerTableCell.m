//
//  XYZCountryPickerTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZCountryPickerTableCell.h"

@implementation XYZCountryPickerTableCell

@synthesize CountryPicker;

/*- (void)countryPicker:(XYZCountryPicker *)picker didSelectCountryWithName:(NSString *)name
{
    self.Country = self.CountryPicker.selectedCountryName;
}*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetCountry:(NSString *) Country
{
    [self.CountryPicker setSelectedCountryName:Country];
    self.Country = Country;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //self.CountryPicker.Countrydelegate = self;
    
    if (self.Country)
    {[self.CountryPicker initWithCountry:self.Country];}
    else
    {[self.CountryPicker init];}
    
}

@end
