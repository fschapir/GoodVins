//
//  XYZRegionPicker.h
//  WineTaster2
//
//  Created by François Schapiro on 14/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZRegionPicker;

@protocol RegionPickerViewDelegate <NSObject>;

- (void)regionPicker:(XYZRegionPicker *)picker didSelectRegionWithName:(NSString *)name;

@end

@interface XYZRegionPicker : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<RegionPickerViewDelegate> Regiondelegate;
@property (nonatomic, copy) NSString *selectedRegionName;

-(id)initWithCountry:(NSString *) Country;

-(id)initWithRegion:(NSString *) Region withCountry:(NSString *) Country;

- (void)setSelectedRegionName:(NSString *)RegionName withCountry:(NSString*) Country;


@end
