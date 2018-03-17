//
//  XYZCountryPicker.m
//  WineTaster2
//
//  Created by François Schapiro on 07/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZCountryPicker.h"

@implementation XYZCountryPicker

@synthesize Countrydelegate;

- (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    NSArray *countryList = @[@"Algeria", @"Cape Verde", @"Morocco", @"South Africa", @"Tunisia", @"Argentina", @"Bolivia", @"Brazil", @"Canada", @"Chile",@"Mexico",	@"Peru",	@"United States",	@"Uruguay",	@"Venezuela",	@"Albania",	@"Austria",	@"Armenia",	@"Azerbaijan",	@"Belgium",	@"Bulgaria",	@"Croatia",	@"Cyprus",	@"Czech Republic",	@"Denmark",	@"France",	@"Germany",	@"Greece",	@"Hungary",	@"Ireland",	@"Italy",	@"Latvia",	@"Luxembourg",	@"Macedonia",	@"Moldova",	@"Montenegro",	@"Netherlands",	@"Poland",	@"Portugal",	@"Romania",	@"Russia",	@"Serbia", @"Kosovo", @"Slovakia",	@"Slovenia",	@"Spain",	@"Sweden",	@"Switzerland",	@"Turkey",	@"Ukraine",	@"United Kingdom",	@"China",	@"India",	@"Indonesia",	@"Iran",	@"Israel",	@"Japan",	@"Kazakhstan",	@"Republic of Korea",	@"Lebanon",	@"Burma",	@"Palestinian territories",	@"Syria",	@"Vietnam",	@"Australia",	@"New Zealand"];
    if (!_countryNames)
    {
       // _countryNames = [[[[self countryNamesByCode] allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
        _countryNames = [[countryList sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
    }
    return _countryNames;
}

-(NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleCountryCode: code}];
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
            if (countryName) namesByCode[code] = countryName;
        }
        
        _countryNamesByCode = [namesByCode copy];
    }
    return _countryNamesByCode;
}

- (void)setup
{
    [super setDataSource:self];
    [super setDelegate:self];
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

-(id)initWithCountry:(NSString *)countryName
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self setSelectedCountryName:countryName];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated
{
    NSInteger index = [[self countryNames] indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRow:(index+1) inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    [self setSelectedCountryName:countryName animated:NO];
}

- (NSString *)selectedCountryName
{
    if ([self selectedRowInComponent:0] > 0)
    {
    NSInteger index = [self selectedRowInComponent:0]-1;
    return [self countryNames][index];
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
    return [[self countryNames] count]+1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 90.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    
    if(row != 0)
    {
        label.text = [self countryNames][row-1];
    }
    else
    {
        label.text = @"Pick a country";
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
        [Countrydelegate countryPicker:self didSelectCountryWithName:self.selectedCountryName];
    }
    else
    {
        [Countrydelegate countryPicker:self didSelectCountryWithName:@""];
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
