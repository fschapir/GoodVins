//
//  XYZVarietalsPicker.m
//  WineTaster2
//
//  Created by François Schapiro on 24/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZVarietalsPicker.h"

@implementation XYZVarietalsPicker

@synthesize Varietalsdelegate;

- (NSArray *)VarietalsNames
{
    static NSArray *_VarietalsNames = nil;
    NSArray *VarietalsList = @[@"Airén", @"Alicante Bouschet", @"Aligoté", @"Ansonica", @"Aramon noir", @"Bobal", @"Cabernet franc", @"Cabernet-Sauvignon", @"Cardinal",@"Carignan", @"Catarratto bianco comune", @"Catarratto bianco lucido", @"Cayetana blanca", @"Cereza", @"Chardonnay", @"Chasselas", @"Chelva", @"Chenin", @"Cinsaut", @"Colombard", @"Concord", @"Criolla grande", @"Crljenak Kaštelanski", @"Dattier de Beyrouth", @"Fernão Pires", @"Gamay", @"Garganega", @"Gewurztraminer", @"Grenache blanc", @"Grenache noir", @"Grüner Veltliner", @"Kadarka", @"Macabeo", @"Malbec", @"Melon de Bourgogne",@"Mencia",@"Merlot",@"Monsastrell", @"Muller-thurgau", @"Muscat blanc à petits grains", @"Muscat d'Alexandrie", @"Muscat de Hambourg", @"Négrette", @"Nuragus", @"País", @"Palomino", @"Pardillo", @"Parellada", @"Pedro Ximénez", @"Pinot blanc", @"Pinot gris", @"Pinot meunier", @"Pinot noir", @"Plavac mali", @"Portugais bleu", @"Riesling", @"Rkatsiteli", @"Sangiovese", @"Sauvignon blanc", @"Sémillon", @"Sultanine", @"Sylvaner", @"Syrah", @"Tempranillo", @"Ugni Blanc", @"Welschriesling", @"Xarell-Lo", @"Vermentino", @"Sciaccarello", @"Barbaroux rosé", @"Muscat rose petits grains", @"Muscat ottonel", @"Savagnin", @"Grolleau", @"Grolleau gris", @"Pineau d'Aunis", @"Trousseau", @"Poulsard",@"Clairette", @"Bourboulenc", @"Grenache gris", @"Tourbat", @"Muscadelle", @"Gros manseng", @"Petit manseng", @"Raffiat de Moncade", @"Tannat", @"Brachet", @"Roussane", @"Spagnol", @"Sauvignon gris", @"Carménère", @"Petit verdot", @"César", @"Sacy", @"Mondeuse noire", @"Marsanne", @"Viognier", @"Muscardin", @"Counoise", @"Picpoul blanc", @"Picpoul noir", @"Picpoul gris", @"Terret noir", @"Brun argenté", @"Lledoner pelut", @"Romorantin", @"Arbois", @"Mauzac", @"Tibouren", @"Aubin blanc", @"Len-de-l'el", @"Mauzac rose", @"Duras", @"Fer", @"Marselan", @"Courbu blanc", @"Petit Courbu", @"Prunelard", @"Rivairenc", @"Muscat à petits grains rouge", @"Téoulier", @"Pinot liébault", @"Altesse", @"Molette", @"Clairette rose", @"Calitor", @"Persan", @"Etraire de l'Aduï", @"Jacquère", @"Veltiner rouge précoce", @"Gringet", @"Servanin", @"Joubertin",@"Mondeuse blanche", @"Roussette d'Ayze", @"Verdesse",@"Shiraz",@"Zinfandel"];
    if (!_VarietalsNames)
    {
        // _countryNames = [[[[self countryNamesByCode] allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
        _VarietalsNames = [[VarietalsList sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
    }
    return _VarietalsNames;
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

-(id)initWithVarietal:(NSString *)Varietal
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self setSelectedVarietalsName:Varietal];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

- (void)setSelectedVarietalsName:(NSString *)VarietalsName animated:(BOOL)animated
{
    NSInteger index = [[self VarietalsNames] indexOfObject:VarietalsName];
    if (index != NSNotFound)
    {
        [self selectRow:(index+1) inComponent:0 animated:animated];
    }
}

- (void)setSelectedVarietalsName:(NSString *)VarietalsName
{
    [self setSelectedVarietalsName:VarietalsName animated:NO];
}

- (NSString *)selectedVarietalsName
{
    if ([self selectedRowInComponent:0] > 0)
    {
    NSInteger index = [self selectedRowInComponent:0]-1;
    return [self VarietalsNames][index];
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
    return [[self VarietalsNames] count]+1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 90.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    
    if(row != 0)
    {
        label.text = [self VarietalsNames][row-1];
    }
    else
    {
        label.text = @"Pick a varietal";
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
        [Varietalsdelegate VarietalsPicker:self didSelectVarietalsWithName:self.selectedVarietalsName];
    }
    else
    {
        [Varietalsdelegate VarietalsPicker:self didSelectVarietalsWithName:@""];
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
