//
//  XYZAddNewTasteWineNameTableCell.m
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZAddNewTasteWineNameTableCell.h"

@interface XYZAddNewTasteWineNameTableCell ()
@end

@implementation XYZAddNewTasteWineNameTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)SetName:(NSString *) Name
{
    self.Name = Name;
    self.NameEntry.text = Name;
}

@end
