//
//  XYZVarietalsPicker.h
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZVarietalsPicker;

@protocol VarietalsPickerViewDelegate <NSObject>;

- (void)VarietalsPicker:(XYZVarietalsPicker *)picker didSelectVarietalsWithName:(NSString *)name;

@end

@interface XYZVarietalsPicker : UIPickerView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id<VarietalsPickerViewDelegate> Varietalsdelegate;
@property (nonatomic, copy) NSString *selectedVarietalsName;

-(id)init;

-(id)initWithVarietal:(NSString *)Varietal;

- (void)setSelectedVarietalsName:(NSString *)VarietalsName;

@end
