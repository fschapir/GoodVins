//
//  XYZYearPicker.m
//  WineTaster2
//
//  Created by François Schapiro on 16/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZYearPicker.h"

#define DefaultMinimumYear 1789

@interface XYZYearPicker()

@property (nonatomic) int yearComponent;
@property (nonatomic) int maximumYear;

//-(int)yearFromRow:(NSInteger)row;
//-(NSInteger)rowFromYear:(int)year;

@end

@implementation XYZYearPicker

@synthesize Yeardelegate;

static const int DefaultMaximumYear = 2100;
static const NSCalendarUnit DateComponentFlags = NSYearCalendarUnit;

- (NSArray *)YearList
{
    static NSArray *_YearList = nil;
    NSMutableArray *YearsArray = [NSMutableArray arrayWithObject:[NSNumber numberWithInt:(self.maximumYear)]];
    int year = (self.maximumYear);
    while(year > (DefaultMinimumYear))
    {
        year = year-1;
        [YearsArray addObject:[NSNumber numberWithInt:year]];
    }
    
    if (!_YearList)
    {
        _YearList = [YearsArray copy];
    }
    year = DefaultMinimumYear;
    return _YearList;
}

-(NSInteger)rowFromYear:(int)year
{
    return (self.maximumYear - year);
}

- (void)setup
{
    [super setDataSource:self];
    [super setDelegate:self];
}

-(id)init
{
    //self = [self initWithDate:[NSDate date]];
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self SetMaximumYear];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

-(id)initWithYear:(int)Year
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self SetMaximumYear];
        [self setSelectedYear:Year];
        self.showsSelectionIndicator = YES;
    }
    
    return self;

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
        [self SetMaximumYear];
    }
    return self;
}

-(void)SetMaximumYear
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:DateComponentFlags fromDate:[NSDate date]];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    self.maximumYear = [components year];
}

- (void)setSelectedYear:(int)Year animated:(BOOL)animated
{
    NSInteger index = [self rowFromYear:Year];
    if (index != NSNotFound)
    {
        [self selectRow:(index+1)inComponent:0 animated:animated];
    }
}

- (void)setSelectedYear:(int)Year
{
    [self setSelectedYear:Year animated:NO];
}

- (NSString *)selectedYear
{
    if ([self selectedRowInComponent:0] > 0 )
    {
        NSInteger index = [self selectedRowInComponent:0]-1;
        return [NSString stringWithFormat:@"%@",[self YearList][index]];
    }
    else
    {return @"";}
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        return 250;
    }
    else
        return 530;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[self YearList] count]+1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 90.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    if(row != 0)
    {
        label.text = [NSString stringWithFormat:@"%@",[self YearList][row-1]];
    }
    else
    {
        label.text = @"Pick a year";
    }
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:20.0f];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (row != 0)
    {
        [Yeardelegate YearPicker:self didSelectYear:self.selectedYear];
    }
    else
    {
        [Yeardelegate YearPicker:self didSelectYear:@""];
    }
    
}

/*
 -(id)initWithDate:(NSDate *)date
 {
 self = [super init];
 
 if (self)
 {
 [self prepare];
 [self setDate:date];
 self.showsSelectionIndicator = YES;
 }
 
 return self;
 }
 
 
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 // Initialization code
 [self prepare];
 if (!_date)
 [self setDate:[NSDate date]];
 }
 return self;
 }
 
 -(void)prepare
 {
 self.dataSource = self;
 self.delegate = self;
 }
 
 
 -(int)yearComponent
 {
 return 0;
 }
 
 
 -(NSArray *)monthStrings
{
    return [[NSDateFormatter alloc] init].monthSymbols;
}

-(int)yearFromRow:(NSUInteger)row
{
    return row + DefaultMinimumYear;
}

-(void)setDate:(NSDate *)date
{
    NSDateComponents* components = [[NSCalendar currentCalendar] components:DateComponentFlags fromDate:date];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    self.maximumYear = [components year];
    
    //[self selectRow:[self rowFromYear:components.year] inComponent:self.yearComponent animated:NO];
    [self selectRow:([self rowFromYear:self.maximumYear] + 1) inComponent:0 animated:NO];
    
    _date = [[NSCalendar currentCalendar] dateFromComponents:components];
}*/


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
