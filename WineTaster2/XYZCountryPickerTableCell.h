//
//  XYZCountryPickerTableCell.h
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZCountryPicker.h"

@interface XYZCountryPickerTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet XYZCountryPicker *CountryPicker;
@property NSString *Country;

-(void)SetCountry:(NSString *) Country;

@end
