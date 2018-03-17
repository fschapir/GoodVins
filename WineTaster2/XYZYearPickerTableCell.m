//
//  XYZYearPickerTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 24/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZYearPickerTableCell.h"


@implementation XYZYearPickerTableCell

@synthesize yearPicker;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)SetYear:(NSString *)Year
{
    [self.yearPicker setSelectedYear:[Year intValue]];
    self.Year = Year;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    [self.yearPicker init];
    
    if (self.Year)
    {[self.yearPicker initWithYear:[self.Year intValue]];}
    else
    {[self.yearPicker init];}

}

/*
 - (NSString*)formatDate:(NSDate *)date
 {
 // A convenience method that formats the date in Year format
 
 NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
 formatter.dateFormat = @"yyyy";
 return [formatter stringFromDate:date];
 }
 
 - (void)YearPickerDidChangeDate:(XYZYearPicker *)yearPicker
 {
 if(self.yearPicker.date)
 {
 self.Year = [NSString stringWithFormat:@"%@", [self formatDate:self.yearPicker.date]];
 }
 else
 {
 self.Year = nil;
 }
 }
 
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated
 {
 [super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 self.yearPicker.Yeardelegate = self;
 
 [self.yearPicker init];
 
 if (self.Year != nil)
 {
 [self.yearPicker selectRow:[self.yearPicker rowFromYear:[self.Year integerValue]] inComponent:0 animated:YES];
 }
 
 }
 
 */

@end
