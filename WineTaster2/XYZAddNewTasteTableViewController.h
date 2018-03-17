//
//  XYZAddNewTasteTableViewController.h
//  WineTaster2
//
//  Created by François Schapiro on 23/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYZWine.h"
#import "XYZYearPicker.h"
#import "XYZColorPicker.h"
#import "XYZVarietalsPicker.h"
#import "XYZCountryPicker.h"
#import "XYZRegionPicker.h"

@interface XYZAddNewTasteTableViewController : UITableViewController<UITextFieldDelegate,YearPickerViewDelegate,ColorPickerViewDelegate,VarietalsPickerViewDelegate,CountryPickerViewDelegate,RegionPickerViewDelegate>

@property XYZWine *NewTaste;
@property XYZWine *EditTaste;

@end
