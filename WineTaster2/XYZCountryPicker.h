//
//  XYZCountryPicker.h
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZCountryPicker;

@protocol CountryPickerViewDelegate <NSObject>;

- (void)countryPicker:(XYZCountryPicker *)picker didSelectCountryWithName:(NSString *)name;

@end

@interface XYZCountryPicker : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<CountryPickerViewDelegate> Countrydelegate;
@property (nonatomic, copy) NSString *selectedCountryName;

-(id)init;

-(id)initWithCountry:(NSString *)countryName;

- (void)setSelectedCountryName:(NSString *)countryName;

@end
