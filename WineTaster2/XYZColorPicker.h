//
//  XYZColorPicker.h
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZColorPicker;

@protocol ColorPickerViewDelegate <NSObject>;

- (void)ColorPicker:(XYZColorPicker *)picker didSelectColorWithName:(NSString *)name;

@end

@interface XYZColorPicker : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<ColorPickerViewDelegate> Colordelegate;
@property (nonatomic, copy) NSString *selectedColorName;

-(id)init;

-(id)initWithColor:(NSString *)Color;

- (void)setSelectedColorName:(NSString *)ColorName;

@end
