//
//  XYZColorPicker.m
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZColorPicker.h"

@implementation XYZColorPicker

@synthesize Colordelegate;

- (NSArray *)ColorNames
{
    static NSArray *_ColorNames = nil;
    NSArray *ColorList = @[@"Red", @"White", @"Rosé"];
    if (!_ColorNames)
    {
            _ColorNames = [ColorList copy];
    }
    return _ColorNames;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    [super setDataSource:self];
    [super setDelegate:self];
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

-(id)initWithColor:(NSString *)Color
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self setSelectedColorName:Color];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

- (void)setSelectedColorName:(NSString *)ColorName animated:(BOOL)animated
{
    NSInteger index = [[self ColorNames] indexOfObject:ColorName];
    if (index != NSNotFound)
    {
        [self selectRow:(index+1)inComponent:0 animated:animated];
    }
}

- (void)setSelectedColorName:(NSString *)ColorName
{
    [self setSelectedColorName:ColorName animated:NO];
}

- (NSString *)selectedColorName
{
    if ([self selectedRowInComponent:0] > 0)
    {
    NSInteger index = [self selectedRowInComponent:0]-1;
    return [self ColorNames][index];
    }
    else
    {return @"";}
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 250;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self ColorNames] count]+1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 90.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    if(row != 0)
    {
        label.text = [self ColorNames][row-1];
    }
    else
    {
        label.text = @"Pick a color";
    }
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:20.0f];
    //label.backgroundColor = [UIColor clearColor];
    //label.shadowOffset = CGSizeMake(0.0f, 0.1f);
    //label.shadowColor = [UIColor whiteColor];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (row != 0)
    {
        [Colordelegate ColorPicker:self didSelectColorWithName:self.selectedColorName];
    }
    else
    {
        [Colordelegate ColorPicker:self didSelectColorWithName:@""];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
