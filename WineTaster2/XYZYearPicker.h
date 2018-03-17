//
//  XYZYearPicker.h
//  WineTaster2
//
//  Created by François Schapiro on 16/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZYearPicker;

@protocol YearPickerViewDelegate <NSObject>;

- (void)YearPicker:(XYZYearPicker *)picker didSelectYear:(NSString *)Year;

@end

@interface XYZYearPicker : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<YearPickerViewDelegate> Yeardelegate;

@property (nonatomic, copy) NSString *selectedYear;

-(id)init;

-(id)initWithYear:(int)Year;

- (void)setSelectedYear:(int)Year;

@end