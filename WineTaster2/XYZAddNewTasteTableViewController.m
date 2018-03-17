//
//  XYZAddNewTasteTableViewController.m
//  WineTaster2
//
//  Created by François Schapiro on 23/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZAddNewTasteTableViewController.h"
#import "XYZYearPicker.h"
#import "XYZYearPickerTableCell.h"
#import "XYZAddNewTasteWineNameTableCell.h"
#import "XYZCountryPicker.h"
#import "XYZCountryPickerTableCell.h"
#import "XYZRegionPicker.h"
#import "XYZRegionPickerTableCell.h"
#import "XYZVarietalsPicker.h"
#import "XYZVarietalsPickerTableCell.h"
#import "XYZColorPicker.h"
#import "XYZColorPickerTableCell.h"
#import "XYZAddTasteInfoViewController.h"

#define kTitleKey       @"title"   // key for obtaining the data source item's title
#define kDatePickerTag              99     // view tag identifiying the date picker view
#define kCountryPickerTag 98
#define kRegionPickerTag 97
#define kVarietalsPickerTag 96
#define kColorPickerTag 95
#define kDateYearRow     1
#define kDatePickerRowWhenDisplayed 2
#define kCountryPickerRowWhenDisplayed 3
#define kRegionPickerRowWhenDiplayed 4
#define kVarietalsPickerRowWhenDiplayed 5
#define kColorPickerRowWhenDiplayed 6

static NSString *kWineNameCellID = @"WineNameCell"; //the cell with the wine name
static NSString *kDateCellID = @"WineYear";     // the cell with the year
static NSString *kDatePickerID = @"WineDatePicker"; // the cell containing the date picker
static NSString *kOtherCell = @"ListNewTasteInfo";     // the remaining cells at the end
static NSString *kWineCountryCellID = @"WineCountry"; // the cell with the country
static NSString *kCountryPickerCellID = @"CountryPicker";
static NSString *kWineRegionCellID = @"WineRegion"; // the cell with the region
static NSString *kRegionPickerCellID = @"RegionPicker";
static NSString *kWineVarietalsCellID = @"WineVarietals"; // the cell with the varietals
static NSString *kVarietalsPickerCellID = @"VarietalsPicker";
static NSString *kWineColorCellID = @"WineColor"; // the cell with the Color
static NSString *kColorPickerCellID = @"ColorPicker";
static NSString *kWineTasteInfoCellID = @"WineTasteInfo";

@interface XYZAddNewTasteTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

// keep track which indexPath points to the cell with YearPicker
@property (nonatomic, strong) NSIndexPath *datePickerIndexPath;
@property (nonatomic, strong) NSIndexPath *CountryPickerIndexPath;
@property (nonatomic, strong) NSIndexPath *RegionPickerIndexPath;
@property (nonatomic, strong) NSIndexPath *VarietalsPickerIndexPath;
@property (nonatomic, strong) NSIndexPath *ColorPickerIndexPath;
@property (nonatomic, strong) NSIndexPath *YearCellIndexPath;
@property (nonatomic, strong) NSIndexPath *NameCellIndexPath;
@property (nonatomic, strong) NSIndexPath *CountryCellIndexPath;
@property (nonatomic, strong) NSIndexPath *RegionCellIndexPath;
@property (nonatomic, strong) NSIndexPath *VarietalsCellIndexPath;
@property (nonatomic, strong) NSIndexPath *ColorCellIndexPath;
@property (nonatomic, strong) NSIndexPath *TasteInfoCellIndexPath;

@property (assign) NSInteger pickerCellRowHeight;

@property (nonatomic, strong) NSString *Year;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Country;
@property (nonatomic, strong) NSString *Region;
@property (nonatomic, strong) NSString *Varietals;
@property (nonatomic, strong) NSString *Color;
@property (nonatomic, strong) NSMutableArray *TasteInfo;

@property BOOL RegionReset;

- (IBAction)unwindToTaste:(UIStoryboardSegue *)segue;
- (IBAction)unwindToTasteAddingInfo:(UIStoryboardSegue *)segue;

@end

@implementation XYZAddNewTasteTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.doneButton setEnabled:NO];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // setup our data source
    NSMutableDictionary *itemOne = [@{ kTitleKey : @"Wine Name" } mutableCopy];
    NSMutableDictionary *itemTwo = [@{ kTitleKey : @"Wine Year" } mutableCopy];
    NSMutableDictionary *itemThree = [@{ kTitleKey : @"Wine Country" } mutableCopy];
    NSMutableDictionary *itemFour = [@{ kTitleKey : @"Wine Region" } mutableCopy];
    NSMutableDictionary *itemFive = [@{ kTitleKey : @"Wine Varietals" } mutableCopy];
    NSMutableDictionary *itemSix = [@{ kTitleKey : @"Wine Color" } mutableCopy];
    NSMutableDictionary *itemSeven = [@{ kTitleKey : @"Tasted..." } mutableCopy];
    self.dataArray = @[itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix, itemSeven];
    
    if (self.EditTaste)
    {
        self.title = @"Modify Wine";
        
        self.Name = self.EditTaste.Name;
        self.Year = self.EditTaste.Year;
        self.Country = self.EditTaste.Country;
        self.Region = self.EditTaste.AOC;
        self.Varietals = self.EditTaste.Varietal;
        self.Color = self.EditTaste.Color;
        if (self.EditTaste.TasteInfo)
        {
            self.TasteInfo = [[NSMutableArray alloc] init];
            [self.TasteInfo setArray:self.EditTaste.TasteInfo];
        }
    }
    
    // obtain the picker view cell's height, works because the cell was pre-defined in our storyboard
    XYZYearPickerTableCell *pickerViewCellToCheck = [self.tableView dequeueReusableCellWithIdentifier:kDatePickerID];
    self.pickerCellRowHeight = pickerViewCellToCheck.frame.size.height;
    
    [self.doneButton setEnabled:NO];
    self.navigationController.toolbarHidden = YES;

}

- (NSString *) GetCountryFromRegion:(NSString *) Region
{
    NSDictionary *RegionsInfos = [NSDictionary dictionaryWithObjectsAndKeys:@"Algeria",@"Mascara",	@"Algeria",@"Tlemcen",	@"Algeria",@"D'hara",	@"Algeria",@"Aïn Bessem Bouira",	@"Algeria",@"Medea",	@"Algeria",@"Zaccar",	@"Algeria",@"Tessalah",	@"Cape Verde",@"Chã das Caldeiras",	@"Morocco",@"Atlas Mountains",	@"South Africa",@"Elim",	@"South Africa",@"Stellenbosch",	@"South Africa",@"Paarl",	@"South Africa",@"Franschhoek",	@"South Africa",@"Constantia",	@"South Africa",@"Robertson",	@"South Africa",@"Swartland",	@"South Africa",@"Durbanville",	@"South Africa",@"Olifants River",	@"South Africa",@"Piketberg",	@"South Africa",@"Elgin",	@"South Africa",@"Breede River Valley",	@"South Africa",@"Klein Karoo",	@"South Africa",@"Orange River Valley",	@"South Africa",@"Tulbagh",	@"South Africa",@"Overberg",	@"South Africa",@"KwaZulu-Natal",	@"Tunisia",@"Grand Cru Mornag",	@"Tunisia",@"Mornag",	@"Tunisia",@"Thibar",	@"Tunisia",@"Coteaux d'Utique",	@"Tunisia",@"Tébourba",	@"Tunisia",@"Sidi Salem",	@"Tunisia",@"Kélibia",	@"Argentina",@"Mendoza",	@"Argentina",@"San Juan",	@"Argentina",@"Médanos",	@"Argentina",@"Buenos Aires",	@"Argentina",@"Río Negro",	@"Argentina",@"Neuquén",	@"Argentina",@"Salta",	@"Argentina",@"La Rioja",	@"Argentina",@"Catamarca",	@"Argentina",@"La Pampa",	@"Argentina",@"Tucumán",	@"Bolivia",@"Tarija Department",	@"Brazil",@"Rio Grande do Sul",	@"Brazil",@"Bento Gonçalves",	@"Brazil",@"Caxias do Sul",	@"Brazil",@"Garibaldi",	@"Brazil",@"Cotiporã",	@"Brazil",@"Paraná",	@"Brazil",@"Marialva",	@"Brazil",@"Maringá",	@"Brazil",@"Rosário do Avaí",	@"Brazil",@"Bandeirantes",	@"Brazil",@"Santa Catarina",	@"Brazil",@"São Joaquim",	@"Brazil",@"Pinheiro Preto",	@"Brazil",@"Tangará",	@"Brazil",@"Mato Grosso",	@"Brazil",@"Nova Mutum",	@"Brazil",@"Minas Gerais",	@"Brazil",@"Pirapora",	@"Brazil",@"Andradas",	@"Brazil",@"Caldas",	@"Brazil",@"Santa Rita de Caldas",	@"Brazil",@"Bahia",	@"Brazil",@"Juazeiro",	@"Brazil",@"Curaçá",	@"Brazil",@"Irecê",	@"Brazil",@"Pernambuco ",	@"Brazil",@"Petrolina",	@"Brazil",@"Casa Nova",	@"Brazil",@"Santa Maria da Boa Vista",	@"Brazil",@"São Paulo",	@"Brazil",@"Jundiaí",	@"Brazil",@"São Roque",	@"Canada",@"British Columbia",	@"Canada",@"Fraser Valley",	@"Canada",@"Gulf Islands",	@"Canada",@"Okanagan Valley",	@"Canada",@"Similkameen Valley",	@"Canada",@"Vancouver Island",	@"Canada",@"Nova Scotia",	@"Canada",@"Annapolis Valley",	@"Canada",@"Ontario",	@"Canada",@"Niagara Peninsula",	@"Canada",@"Lake Erie North Shore and Pelee Island",	@"Canada",@"Prince Edward County",	@"Canada",@"Toronto",	@"Canada",@"Quebec",	@"Canada",@"Eastern Townships",	@"Chile",@"Aconcagua Valley",	@"Chile",@"Casablanca Valley",	@"Chile",@"Atacama",	@"Chile",@"Copiapó Valley",	@"Chile",@"Huasco Valley",	@"Chile",@"Central Valley",	@"Chile",@"Cachapoal Valley",	@"Chile",@"Maipo Valley",	@"Chile",@"Mataquito Valley",	@"Chile",@"Maule Valley",	@"Chile",@"Coquimbo",	@"Chile",@"Choapa Valley",	@"Chile",@"Elqui Valley",	@"Chile",@"Limarí",	@"Chile",@"Pica",	@"Chile",@"Zona Sur",	@"Chile",@"Bío-Bío Valley",	@"Chile",@"Itata Valley",	@"Chile",@"Malleco Valley",	@"Mexico",@"Aguascalientes Valley",	@"Mexico",@"Baja California",	@"Mexico",@"Valle de Guadalupe",	@"Mexico",@"Valle de Calafia",	@"Mexico",@"Valle de Mexicali",	@"Mexico",@"Valle de San Vicente",	@"Mexico",@"Valle de Santo Tomás",	@"Mexico",@"Zona Tecate",	@"Mexico",@"Coahuila",	@"Mexico",@"Durango",	@"Mexico",@"La Laguna",	@"Mexico",@"Valle de Parras",	@"Mexico",@"San Miguel de Allende",	@"Mexico",@"Dolores Hidalgo",	@"Mexico",@"Hidalgo",	@"Mexico",@"Guanajuato",	@"Mexico",@"Nuevo León",	@"Mexico",@"Valle de Las Maravillas",	@"Mexico",@"Querétaro",	@"Mexico",@"Valle de Tequisquiapan",	@"Mexico",@"Sonora",	@"Mexico",@"Caborca",	@"Mexico",@"Hermosillo",	@"Mexico",@"Zacatecas",	@"Mexico",@"Valle de las Arcinas",	@"Peru",@"Huaral District",	@"Peru",@"Cañete Province",	@"Peru",@"Ica Region",	@"Peru",@"Arequipa region",	@"United States",@"Sonoita",	@"United States",@"Arkansas Mountain",	@"United States",@"Ozark Mountain",	@"United States",@"Altus",	@"United States",@"Central Coast",	@"United States",@"Ben Lomond Mountain",	@"United States",@"Arroyo Grande Valley",	@"United States",@"Arroyo Seco",	@"United States",@"Carmel Valley",	@"United States",@"Chalone",	@"United States",@"Cienega Valley",	@"United States",@"Edna Valley",	@"United States",@"Hames Valley",	@"United States",@"Happy Canyon of Santa Barbara",	@"United States",@"Lime Kiln Valley",	@"United States",@"Livermore Valley",	@"United States",@"Monterey",	@"United States",@"Mt. Harlan",	@"United States",@"Pacheco Pass",	@"United States",@"Paicines",	@"United States",@"Paso Robles",	@"United States",@"San Antonio Valley",	@"United States",@"San Benito",	@"United States",@"San Bernabe",	@"United States",@"San Francisco Bay",	@"United States",@"San Lucas",	@"United States",@"San Ysidro District",	@"United States",@"Santa Clara Valley",	@"United States",@"Santa Cruz Mountains",	@"United States",@"Santa Lucia Highlands",	@"United States",@"Santa Maria Valley",	@"United States",@"Sta. Rita Hills",	@"United States",@"Santa Ynez Valley",	@"United States",@"York Mountain",	@"United States",@"Alta Mesa",	@"United States",@"Borden Ranch",	@"United States",@"Capay Valley",	@"United States",@"Clarksburg",	@"United States",@"Clements Hills",	@"United States",@"Cosumnes River",	@"United States",@"Diablo Grande",	@"United States",@"Dunnigan Hills",	@"United States",@"Jahant",	@"United States",@"Lodi",	@"United States",@"Madera",	@"United States",@"Merritt Island",	@"United States",@"Mokelumne River",	@"United States",@"River Junction",	@"United States",@"Salado Creek",	@"United States",@"Sloughhouse",	@"United States",@"Tracy Hills",	@"United States",@"Seiad Valley",	@"United States",@"Trinity Lakes",	@"United States",@"Willow Creek",	@"United States",@"North Coast",	@"United States",@"Alexander Valley",	@"United States",@"Anderson Valley",	@"United States",@"Atlas Peak",	@"United States",@"Bennett Valley",	@"United States",@"Benmore Valley",	@"United States",@"Calistoga",	@"United States",@"Chalk Hill",	@"United States",@"Chiles Valley",	@"United States",@"Clear Lake",	@"United States",@"Cole Ranch",	@"United States",@"Coombsville",	@"United States",@"Covelo",	@"United States",@"Diamond Mountain District",	@"United States",@"Dos Rios",	@"United States",@"Dry Creek Valley",	@"United States",@"Fort Ross-Seaview",	@"United States",@"Green Valley of Russian River Valley",	@"United States",@"Guenoc Valley",	@"United States",@"High Valley",	@"United States",@"Howell Mountain",	@"United States",@"Knights Valley",	@"United States",@"Los Carneros",	@"United States",@"McDowell Valley",	@"United States",@"Mendocino",	@"United States",@"Mendocino Ridge",	@"United States",@"Mt. Veeder",	@"United States",@"Napa Valley",	@"United States",@"Northern Sonoma",	@"United States",@"Oak Knoll District of Napa Valley",	@"United States",@"Oakville",	@"United States",@"Pine Mountain-Cloverdale",	@"United States",@"Potter Valley",	@"United States",@"Red Hills Lake County",	@"United States",@"Redwood Valley",	@"United States",@"Rockpile",	@"United States",@"Russian River Valley",	@"United States",@"Rutherford",	@"United States",@"Solano County Green Valley",	@"United States",@"Sonoma Coast",	@"United States",@"Sonoma Mountain",	@"United States",@"Sonoma Valley",	@"United States",@"Spring Mountain District",	@"United States",@"St. Helena",	@"United States",@"Stags Leap District",	@"United States",@"Suisun Valley",	@"United States",@"Wild Horse Valley",	@"United States",@"Yorkville Highlands",	@"United States",@"Yountville",	@"United States",@"California Shenandoah Valley",	@"United States",@"El Dorado",	@"United States",@"Fair Play",	@"United States",@"Fiddletown",	@"United States",@"North Yuba",	@"United States",@"Sierra Foothills",	@"United States",@"Antelope Valley of the California High Desert",	@"United States",@"Cucamonga Valley",	@"United States",@"Leona Valley",	@"United States",@"Malibu-Newton Canyon",	@"United States",@"Ramona Valley",	@"United States",@"Saddle Rock-Malibu",	@"United States",@"San Pasqual Valley",	@"United States",@"Sierra Pelona Valley",	@"United States",@"South Coast",	@"United States",@"Temecula Valley",	@"United States",@"West Elks",	@"United States",@"Grand Valley",	@"United States",@"Southeastern New England",	@"United States",@"Western Connecticut Highlands",	@"United States",@"Snake River Valley",	@"United States",@"Shawnee Hills",	@"United States",@"Upper Mississippi River Valley",	@"United States",@"Ohio River Valley",	@"United States",@"Mississippi Delta",	@"United States",@"Catoctin",	@"United States",@"Cumberland Valley",	@"United States",@"Linganore",	@"United States",@"Martha's Vineyard",	@"United States",@"Fennville",	@"United States",@"Lake Michigan Shore",	@"United States",@"Leelanau Peninsula",	@"United States",@"Old Mission Peninsula",	@"United States",@"Alexandria Lakes",	@"United States",@"Augusta",	@"United States",@"Hermann",	@"United States",@"Ozark Highlands",	@"United States",@"Central Delaware Valley",	@"United States",@"Outer Coastal Plain",	@"United States",@"Warren Hills",	@"United States",@"Mesilla Valley",	@"United States",@"Middle Rio Grande Valley",	@"United States",@"Mimbres Valley",	@"United States",@"Cayuga Lake",	@"United States",@"Finger Lakes",	@"United States",@"Hudson River Region",	@"United States",@"Lake Erie",	@"United States",@"Long Island",	@"United States",@"Niagara Escarpment",	@"United States",@"North Fork of Long Island",	@"United States",@"Seneca Lake",@"United States",@"The Hamptons	Long Island",@"United States",@"Haw River Valley",	@"United States",@"Swan Creek",	@"United States",@"Yadkin Valley",	@"United States",@"Grand River Valley",	@"United States",@"Isle St. George",	@"United States",@"Loramie Creek",	@"United States",@"Applegate Valley",	@"United States",@"Chehalem Mountains",	@"United States",@"Columbia Gorge",	@"United States",@"Columbia Valley",	@"United States",@"Dundee Hills",	@"United States",@"Eola-Amity Hills",	@"United States",@"McMinnville",	@"United States",@"Red Hill Douglas County Oregon",@"United States",@"Ribbon Ridge",	@"United States",@"Rogue Valley",	@"United States",@"Southern Oregon",	@"United States",@"Umpqua Valley",	@"United States",@"Walla Walla Valley",	@"United States",@"Willamette Valley",	@"United States",@"Yamhill-Carlton District",	@"United States",@"Lancaster Valley",	@"United States",@"Lehigh Valley",	@"United States",@"Bell Mountain",	@"United States",@"Escondido Valley",	@"United States",@"Fredericksburg in the Texas Hill Country",	@"United States",@"Texas Davis Mountains",	@"United States",@"Texas High Plains",	@"United States",@"Texas Hill Country",	@"United States",@"Texoma",	@"United States",@"Middleburg",	@"United States",@"Monticello",	@"United States",@"North Fork of Roanoke",	@"United States",@"Northern Neck George Washington Birthplace",	@"United States",@"Rocky Knob",	@"United States",@"Shenandoah Valley",	@"United States",@"Virginia's Eastern Shore",	@"United States",@"Ancient Lakes",	@"United States",@"Horse Heaven Hills",	@"United States",@"Lake Chelan",	@"United States",@"Naches Heights",	@"United States",@"Puget Sound",	@"United States",@"Rattlesnake Hills",	@"United States",@"Red Mountain",	@"United States",@"Snipes Mountain",	@"United States",@"Wahluke Slope",	@"United States",@"Yakima Valley",	@"United States",@"Kanawha River Valley",	@"United States",@"Lake Wisconsin",	@"United States",@"Wisconsin Ledge",	@"Uruguay",@"Dpto. Canelones",	@"Venezuela",@"Carora",	@"Venezuela",@"Lara State",	@"Albania",@"Shkoder",	@"Albania",@"Lezhë",	@"Albania",@"Berat",	@"Albania",@"Korça",	@"Albania",@"Përmet",	@"Albania",@"Leskovik",	@"Albania",@"Tirana County",	@"Austria",@"Burgenland",	@"Austria",@"Wagram",	@"Austria",@"Weinviertel",	@"Austria",@"Wachau",	@"Austria",@"Southern Styria",	@"Austria",@"Vienna",	@"Armenia",@"Areni",	@"Armenia",@"Ijevan",	@"Armenia",@"Ararat Valley",	@"Azerbaijan",@"Ganja",	@"Azerbaijan",@"Tovuz",	@"Azerbaijan",@"Shamkir",	@"Azerbaijan",@"Madrasa",	@"Azerbaijan",@"Baku",	@"Belgium",@"Hageland",	@"Belgium",@"Haspengouw",	@"Belgium",@"Heuvelland",	@"Belgium",@"Côtes de Sambre et Meuse",	@"Bulgaria",@"Danubian Plain",	@"Bulgaria",@"Black Sea",	@"Bulgaria",@"Rose Valley",	@"Bulgaria",@"Thracian Lowland ",	@"Bulgaria",@"Struma River Valley",	@"Croatia",@"Moslavina",	@"Croatia",@"Plešivica",	@"Croatia",@"Podunavlje",	@"Croatia",@"Pokuplje",	@"Croatia",@"Prigorje - Bilogora",	@"Croatia",@"Slavonija",	@"Croatia",@"Zagorje - Međimurje",	@"Croatia",@"Northern Dalmatia",	@"Croatia",@"Croatian Coast",	@"Croatia",@"Istra, Croatia",@"Croatia",@"Northern Dalmatia",	@"Croatia",@"Dalmatian Interior",	@"Cyprus",@"Commandaria",	@"Czech Republic",@"Moravia",	@"Czech Republic",@"Mikulovska",	@"Czech Republic",@"Znojemská",	@"Czech Republic",@"Slovácko",	@"Czech Republic",@"Velkopavlovická",	@"Czech Republic",@"Bohemia",	@"Czech Republic",@"Litoměřická",	@"Czech Republic",@"Mělnická",	@"Denmark",@"Jutland",	@"Denmark",@"Lolland",	@"Denmark",@"Funen",	@"Denmark",@"Northern Zealand",	@"Georgia",@"Kakheti",	@"Georgia",@"Kartli",	@"Georgia",@"Imereti",	@"Georgia",@"Racha-Lechkhumi and Kvemo Svaneti",	@"Georgia",@"Abkhazia",	@"Georgia",@"Ajara",	@"Germany",@"Ahr",	@"Germany",@"Baden",	@"Germany",@"Franconia",	@"Germany",@"Hessische Bergstraße",	@"Germany",@"Mittelrhein",	@"Germany",@"Mosel",	@"Germany",@"Nahe",	@"Germany",@"Palatinate",	@"Germany",@"Rheingau",	@"Germany",@"Rheinhessen",	@"Germany",@"Saale-Unstrut",	@"Germany",@"Saxony",	@"Germany",@"Württemberg",	@"Greece",@"Aegean islands",	@"Greece",@"Crete",	@"Greece",@"Limnos",	@"Greece",@"Paros",	@"Greece",@"Rhodes",	@"Greece",@"Samos",	@"Greece",@"Santorini",	@"Greece",@"Central Greece",	@"Greece",@"Attica",	@"Greece",@"Epirus",	@"Greece",@"Zitsa",	@"Greece",@"Thessaly",	@"Greece",@"Rapsani",	@"Greece",@"Ankhialos",	@"Greece",@"Ionian Islands",	@"Greece",@"Kefalonia",	@"Greece",@"Macedonia",	@"Greece",@"Amyntaion",	@"Greece",@"Goumenissa",@"Greece",@"Naousa Imathia",@"Greece",@"Peloponnesus",	@"Greece",@"Mantineia",	@"Greece",@"Nemea",	@"Greece",@"Patras",	@"Hungary",@"Balaton",	@"Hungary",@"Badacsony",	@"Hungary",@"Balatonboglár",	@"Hungary",@"Balaton-felvidék",	@"Hungary",@"Balatonfüred-Csopak",	@"Hungary",@"Nagy-Somló",	@"Hungary",@"Zala",	@"Hungary",@"Duna",	@"Hungary",@"Csongrád",	@"Hungary",@"Hajós-Baja",	@"Hungary",@"Kunság",	@"Hungary",@"Eger",	@"Hungary",@"Bükk",	@"Hungary",@"Mátra",	@"Hungary",@"Észak-Dunántúl",	@"Hungary",@"Neszmély",	@"Hungary",@"Etyek-Buda",	@"Hungary",@"Mór",	@"Hungary",@"Pannonhalma",	@"Hungary",@"Pannon",	@"Hungary",@"Pécs",	@"Hungary",@"Szekszárd",	@"Hungary",@"Tolna",	@"Hungary",@"Villány",	@"Hungary",@"Sopron",	@"Hungary",@"Tokaj, Hungary",@"Ireland",@"Cork",	@"Latvia",@"Sabile",	@"Luxembourg",@"Moselle Valley",	@"Macedonia",@"Povardarie",	@"Macedonia",@"Tikveš",	@"Macedonia",@"Pcinja-Osogovo",	@"Macedonia",@"Pelagonija-Polog",	@"Moldova",@"Cricova",	@"Moldova",@"Bardar",	@"Moldova",@"Codri",	@"Moldova",@"Hînceşti",	@"Moldova",@"Purcari",	@"Montenegro",@"Plantaže",	@"Montenegro",@"Crmnica",	@"Netherlands",@"Gelderland",	@"Netherlands",@"Limburg",	@"Netherlands",@"North Brabant",	@"Netherlands",@"North Holland",	@"Netherlands",@"Zeeland",	@"Netherlands",@"Drenthe",	@"Netherlands",@"Overijssel",	@"Netherlands",@"Groningen",	@"Poland",@"Warka",	@"Poland",@"Zielona Góra",	@"Portugal",@"Alenquer",	@"Portugal",@"Alentejo",	@"Portugal",@"Arruda",	@"Portugal",@"Bairrada",	@"Portugal",@"Beira Interior",	@"Portugal",@"Bucelas",	@"Portugal",@"Carcavelos",	@"Portugal",@"Colares",	@"Portugal",@"Dão",	@"Portugal",@"Douro",	@"Portugal",@"Encostas d'Aire",	@"Portugal",@"Lagoa",	@"Portugal",@"Lagos",	@"Portugal",@"Madeira",	@"Portugal",@"Madeirense",	@"Portugal",@"Óbidos",	@"Portugal",@"Palmela",	@"Portugal",@"Porto",	@"Portugal",@"Portimão",	@"Portugal",@"Tejo",	@"Portugal",@"Setúbal",	@"Portugal",@"Tavira",	@"Portugal",@"Távora-Varosa",	@"Portugal",@"Torres Vedras",	@"Portugal",@"Trás-os-Montes",	@"Portugal",@"Vinho Verde",	@"Portugal",@"Biscoitos",	@"Portugal",@"Graciosa",	@"Portugal",@"Lafões",	@"Portugal",@"Pico",	@"Portugal",@"Açores",	@"Portugal",@"Alentejano",	@"Portugal",@"Algarve",	@"Portugal",@"Beiras",	@"Portugal",@"Duriense",	@"Portugal",@"Lisboa",	@"Portugal",@"Minho",	@"Portugal",@"Península de Setúbal",	@"Portugal",@"Terras Madeirenses",	@"Portugal",@"Transmontano",	@"Russia",@"Caucasus",	@"Russia",@"Krasnodar",	@"Russia",@"Stavropol",	@"Russia",@"Dagestan",	@"Russia",@"Rostov",	@"Serbia",@"Timok",	@"Serbia",@"Nišava–South Morava",	@"Serbia",@"West Morava",	@"Serbia",@"Šumadija–Great Morava",	@"Serbia",@"Pocerina",	@"Serbia",@"Srem",	@"Serbia",@"Banat",	@"Serbia",@"Subotica–Horgoš",	@"Kosovo",@"Kosovo",	@"Slovakia",@"Malokarpatská",	@"Slovakia",@"Južnoslovenská",	@"Slovakia",@"Nitrianska",	@"Slovakia",@"Stredoslovenská",	@"Slovakia",@"Východoslovenská",@"Slovakia",@"Tokaj, Slovakia", @"Slovenia",@"Goriška Brda",	@"Slovenia",@"Vipavska dolina",	@"Slovenia",@"Kras",@"Slovenia",@"Istra, Slovenia", @"Slovenia",@"Bela krajina",	@"Slovenia",@"Dolenjska",	@"Slovenia",@"Bizeljsko",	@"Slovenia",@"Štajerska",	@"Slovenia",@"Prekmurje",	@"Sweden",@"Gotland",	@"Sweden",@"Södermanland County",	@"Sweden",@"Scania",	@"Switzerland",@"Geneva",	@"Switzerland",@"Grisons",	@"Switzerland",@"Neuchâtel",	@"Switzerland",@"St. Gallen",	@"Switzerland",@"Ticino",	@"Switzerland",@"Valais",	@"Switzerland",@"Vaud",	@"Switzerland",@"Lavaux",	@"Switzerland",@"La Côte",	@"Switzerland",@"Zürich",	@"Turkey",@"Cappadocia",	@"Turkey",@"Tokat",	@"Turkey",@"Central Anatolia",	@"Turkey",@"Ankara",	@"Turkey",@"İzmir",	@"Turkey",@"Aegean",	@"Turkey",@"Thracian",	@"Turkey",@"Marmara",	@"Turkey",@"Bozcaada",	@"Turkey",@"Bilecik",	@"Turkey",@"Southeastern Anatolia",	@"Turkey",@"Elazığ",	@"Turkey",@"Diyarbakır",	@"Turkey",@"Kırklareli",	@"Turkey",@"Çal",	@"Turkey",@"Denizli",	@"Turkey",@"Çanakkale",	@"Turkey",@"Eastern Aegean",	@"Turkey",@"Tekirdağ",	@"Turkey",@"Avşa Island",	@"Ukraine",@"Carpathian Ruthenia",	@"Ukraine",@"Odesa",	@"Ukraine",@"Mykolaiv",	@"Ukraine",@"Kherson",	@"Ukraine",@"Crimea ",	@"Ukraine",@"Balaklava",	@"Ukraine",@"Zaporizhia",	@"United Kingdom",@"Hampshire",	@"United Kingdom",@"Kent",	@"United Kingdom",@"Surrey",	@"United Kingdom",@"Sussex",	@"China",@"Yantai-Penglai",	@"China",@"Chang'an",	@"China",@"Qiuci",	@"China",@"Gaochang",	@"China",@"Luoyang",@"China",@"Yantai	 Shandong",@"China",@"Zhangjiakou Hebei",@"China",@"Dalian Liaoning",@"China",@"Tonghua	Jilin",@"China",@"Yibin Sichuan",@"India",@"Bangalore Karnataka",@"India",@"Nashik	 Maharashtra",@"India",@"Sangli Maharashtra",@"India",@"Narayangaon",@"India",@"Pune Maharashtra",@"India",@"Bijapur	 Karnataka",@"Indonesia",@"",	@"Iran",@"Shiraz",	@"Iran",@"Quchan",	@"Iran",@"Qazvin",	@"Iran",@"Urmia",	@"Iran",@"Malayer",	@"Iran",@"Takestan",	@"Israel",@"Bet Shemesh",	@"Israel",@"Galilee",	@"Israel",@"Golan Heights",	@"Israel",@"Jerusalem",	@"Israel",@"Judean Hills",	@"Israel",@"Latrun",	@"Israel",@"Mount Carmel",	@"Israel",@"Rishon LeZion",	@"Japan",@"Nagano",	@"Japan",@"Yamanashi",	@"Japan",@"Hokkaidō",	@"Japan",@"Yamagata",	@"Japan",@"Niigata",	@"Japan",@"Shiga",	@"Japan",@"Tochigi",	@"Japan",@"Kyoto",	@"Japan",@"Osaka",	@"Japan",@"Hyōgo",	@"Japan",@"Miyazaki",	@"Kazakhstan",@"Issyk",	@"Kazakhstan",@"Zailiyskiy",@"Republic of Korea",@"Anseong	 Gyeonggi-do",@"Republic of Korea",@"Gimcheong Gyeongsangbuk-do",@"Republic of Korea",@"Gyeongsan Gyeongsangbuk-do",@"Republic of Korea",@"Yeongcheon Gyeongsangbuk-do",@"Republic of Korea",@"Yeongdong Chungcheongbuk-do",@"Lebanon",@"Bekaa Valley",	@"Lebanon",@"Mount Lebanon",	@"Lebanon",@"North Governorate",	@"Lebanon",@"South Governorate",	@"Burma",@"Shan State",	@"Palestinian territories",@"Beit Jala",	@"Palestinian territories",@"Hebron",	@"Syria",@"Jabal el Druze",	@"Syria",@"Homs District",	@"Vietnam",@"Da Lat",	@"New Zealand",@"Bay of Plenty",	@"New Zealand",@"Central Otago",	@"New Zealand",@"Canterbury",	@"New Zealand",@"Waipara",	@"New Zealand",@"Hawke's Bay",	@"New Zealand",@"Gisborne",	@"New Zealand",@"Marlborough",	@"New Zealand",@"Nelson",	@"New Zealand",@"Northland",	@"New Zealand",@"Waikato",	@"New Zealand",@"Wairarapa",	@"New Zealand",@"Auckland",	@"New Zealand",@"Waitaki",	@"Australia",@"New South Wales",	@"Australia",@"Big Rivers",	@"Australia",@"Murray Darling",	@"Australia",@"Perricoota",	@"Australia",@"Riverina",	@"Australia",@"Swan Hill",	@"Australia",@"Central Ranges",	@"Australia",@"Cowra",	@"Australia",@"Mudgee",	@"Australia",@"Orange",	@"Australia",@"Hunter Region",	@"Australia",@"Hunter wine region",	@"Australia",@"Broke Fordwich",	@"Australia",@"Northern Rivers",	@"Australia",@"Hastings River",	@"Australia",@"Northern Slopes",	@"Australia",@"South Coast",	@"Australia",@"Shoalhaven Coast",	@"Australia",@"Southern Highlands",	@"Australia",@"Southern New South Wales",	@"Australia",@"Canberra District",	@"Australia",@"Gundagai",	@"Australia",@"Hilltops",	@"Australia",@"Tumbarumba",	@"Australia",@"Queensland",	@"Australia",@"Granite Belt",	@"Australia",@"South Burnett",	@"Australia",@"South Australia",	@"Australia",@"Barossa",	@"Australia",@"Barossa Valley",	@"Australia",@"Eden Valley",	@"Australia",@"High Eden",	@"Australia",@"Far North",	@"Australia",@"Southern Flinders Ranges",	@"Australia",@"Fleurieu",	@"Australia",@"Currency Creek",	@"Australia",@"Kangaroo Island",	@"Australia",@"Langhorne Creek",	@"Australia",@"McLaren Vale",	@"Australia",@"Southern Fleurieu",	@"Australia",@"Limestone Coast",	@"Australia",@"Coonawarra",	@"Australia",@"Mount Benson",	@"Australia",@"Padthaway",	@"Australia",@"Wrattonbully",	@"Australia",@"Robe",	@"Australia",@"Bordertown",	@"Australia",@"Lower Murray",	@"Australia",@"Riverland",	@"Australia",@"Mount Lofty Ranges",	@"Australia",@"Adelaide Hills",	@"Australia",@"Lenswood",	@"Australia",@"Piccadilly Valley",	@"Australia",@"Adelaide Plains",	@"Australia",@"Clare Valley",	@"Australia",@"The Peninsulas",	@"Australia",@"Tasmanian wine",	@"Australia",@"North West",	@"Australia",@"Tamar Valley",	@"Australia",@"Pipers River",	@"Australia",@"East Coast",	@"Australia",@"Coal River",	@"Australia",@"Derwent Valley",	@"Australia",@"Southern",	@"Australia",@"Victoria",	@"Australia",@"Central Victoria",	@"Australia",@"Bendigo",	@"Australia",@"Goulburn Valley",	@"Australia",@"Nagambie Lakes",	@"Australia",@"Heathcote",	@"Australia",@"Strathbogie Ranges",	@"Australia",@"Upper Goulburn",	@"Australia",@"Gippsland",	@"Australia",@"North East Victoria",	@"Australia",@"Alpine Valleys",	@"Australia",@"Beechworth",	@"Australia",@"Glenrowan",	@"Australia",@"Rutherglen",	@"Australia",@"North West Victoria",	@"Australia",@"Murray Darling",	@"Australia",@"Swan Hill",	@"Australia",@"Port Phillip",	@"Australia",@"Geelong",	@"Australia",@"Macedon Ranges",	@"Australia",@"Mornington Peninsula",	@"Australia",@"Sunbury",	@"Australia",@"Yarra Valley",	@"Australia",@"Western Victoria",	@"Australia",@"Grampians",	@"Australia",@"Henty",	@"Australia",@"Pyrenees",	@"Australia",@"Western Australia",	@"Australia",@"Greater Perth",	@"Australia",@"Peel",	@"Australia",@"Perth Hills",	@"Australia",@"Swan Valley",	@"Australia",@"South Western Australia",	@"Australia",@"Blackwood Valley",	@"Australia",@"Geographe",	@"Australia",@"Great Southern",	@"Australia",@"Albany",	@"Australia",@"Denmark",	@"Australia",@"Frankland River",	@"Australia",@"Mount Barker",	@"Australia",@"Porongurup",	@"Australia",@"Manjimup",	@"Australia",@"Margaret River",	@"Australia",@"Pemberton",	@"Italy",@"Albana di Romagna",	@"Italy",@"Colli Bolognesi",	@"Italy",@"Ramandolo",	@"Italy",@"Colli Orientali del Friuli Picolit",	@"Italy",@"Rosazzo",	@"Italy",@"Franciacorta",	@"Italy",@"Oltrepo Pavese Metodo Classico",	@"Italy",@"Moscato di Scanzo",	@"Italy",@"Sforzato di Valtellina",	@"Italy",@"Valtellina Superiore",	@"Italy",@"Asti",	@"Italy",@"Barbaresco",	@"Italy",@"Barbera d'Asti",	@"Italy",@"Barbera d'Asti Nista",	@"Italy",@"Barbera d'Asti Tinella",	@"Italy",@"Barbera d'Asti Colli Astiani",	@"Italy",@"Barbera del Monferrato Superiore",	@"Italy",@"Barolo",	@"Italy",@"Acqui",	@"Italy",@"Dogliani",	@"Italy",@"Ovada",	@"Italy",@"Gattinara",	@"Italy",@"Gavi",	@"Italy",@"Ghemme",	@"Italy",@"Roero",	@"Italy",@"Caluso",	@"Italy",@"Diano d'Alba",	@"Italy",@"Ruché di Castagnole Monferrato",	@"Italy",@"Alta Langa",	@"Italy",@"Amarone della Valpolicella",	@"Italy",@"Bardolino Superiore ",	@"Italy",@"Colli di Conegliano",	@"Italy",@"Colli Euganei Fior d'Arancio",	@"Italy",@"Colli Asolani Prosecco",	@"Italy",@"Conegliano Valdobbiadene",	@"Italy",@"Lison-Pramaggiore",	@"Italy",@"Malanotte Raboso Superiore",	@"Italy",@"Montello",	@"Italy",@"Recioto di Soave",	@"Italy",@"Soave Superiore ",	@"Italy",@"Recioto di Gambellara",	@"Italy",@"Recioto della Valpolicella",	@"Italy",@"Prosecco",	@"Italy",@"Montepulciano d'Abruzzo",	@"Italy",@"Cannellino di Frascati",	@"Italy",@"Cesanese del Piglio",	@"Italy",@"Frascati Superiore",	@"Italy",@"Castelli di Jesi Verdicchio Riserva",	@"Italy",@"Conero",	@"Italy",@"Offida",	@"Italy",@"Vernaccia di Serrapetrona",	@"Italy",@"Verdicchio di Matelica Riserva",	@"Italy",@"Brunello di Montalcino",	@"Italy",@"Carmignano",	@"Italy",@"Chianti",	@"Italy",@"Chianti Classico",	@"Italy",@"Chianti Colli Aretini",	@"Italy",@"Chianti Colli Senesi ",	@"Italy",@"Chianti Colli Fiorentini",	@"Italy",@"Chianti Colline Pisane",	@"Italy",@"Chianti Montalbano",	@"Italy",@"Chianti Montespertoli",	@"Italy",@"Chianti Rufina",	@"Italy",@"Chianti Superiore",	@"Italy",@"Montecucco",	@"Italy",@"Morellino di Scansano",	@"Italy",@"Suvereto",	@"Italy",@"Val di Cornia",	@"Italy",@"Vernaccia di San Gimignano",	@"Italy",@"Vino Nobile di Montepulciano",	@"Italy",@"Sagrantino di Montefalco",	@"Italy",@"Torgiano Rosso Riserva",	@"Italy",@"Aglianico del Vulture Superiore",	@"Italy",@"Aglianico del Taburno",	@"Italy",@"Fiano di Avellino",	@"Italy",@"Greco di Tufo",	@"Italy",@"Taurasi ",	@"Italy",@"Castel del Monte Bombino Nero",	@"Italy",@"Castel del Monte Nero di Troia Reserva",	@"Italy",@"Castel del Monte Rosso Riserva",	@"Italy",@"Primitivo di Manduria Dolce Naturale",	@"Italy",@"Vermentino di Gallura",	@"Italy",@"Cerasuolo di Vittoria",	@"Italy",@"Abruzzo",	@"Italy",@"Cerasuolo d'Abruzzo",	@"Italy",@"Controguerra",	@"Italy",@"Montepulciano d'Abruzzo",	@"Italy",@"Terre Tollesi",	@"Italy",@"Tullum",	@"Italy",@"Trebbiano d'Abruzzo",	@"Italy",@"Villamagna",	@"Italy",@"Aglianico del Vulture",	@"Italy",@"Matera",	@"Italy",@"Terre dell'Alta Val d'Agri",	@"Italy",@"Bivongi",	@"Italy",@"Cirò",	@"Italy",@"Donnici",	@"Italy",@"Greco di Bianco",	@"Italy",@"Lamezia",	@"Italy",@"Melissa",	@"Italy",@"Pollino",	@"Italy",@"Sant'Anna di Isola Capo Rizzuto",	@"Italy",@"San Vito di Luzzi",	@"Italy",@"Savuto",	@"Italy",@"Scavigna",	@"Italy",@"Verbicaro",	@"Italy",@"Aglianico del Taburno",	@"Italy",@"Aversa Asprinio",	@"Italy",@"Campi Flegrei",	@"Italy",@"Capri",	@"Italy",@"Castel San Lorenzo",	@"Italy",@"Cilento",	@"Italy",@"Costa d'Amalfi",	@"Italy",@"Falerno del Massico",	@"Italy",@"Falanghina del Sannio",	@"Italy",@"Galluccio",	@"Italy",@"Guardiolo",	@"Italy",@"Irpina",	@"Italy",@"Ischia",	@"Italy",@"Penisola Sorrentina",	@"Italy",@"Sannio",	@"Italy",@"Sant'Agata dei Goti",	@"Italy",@"Solopaca",	@"Italy",@"Taburno",	@"Italy",@"Vesuvio",	@"Italy",@"Bosco Eliceo",	@"Italy",@"Cagnina di Romagna",	@"Italy",@"Colli Bolognesi",	@"Italy",@"Colli Bolognesi Classico Pignoletto",	@"Italy",@"Colli di Faenza",	@"Italy",@"Colli di Imola",	@"Italy",@"Colli di Parma",	@"Italy",@"Colli di Rimini",	@"Italy",@"Colli di Scandiano e di Canossa",	@"Italy",@"Colli Piacentini",	@"Italy",@"Colli Romagna Centrale",	@"Italy",@"Gutturnio",	@"Italy",@"Lambrusco di Sorbara",	@"Italy",@"Lambrusco Grasparossa di Castelvetro",	@"Italy",@"Lambrusco Salamino di Santacroce",	@"Italy",@"Modena",	@"Italy",@"Ortrugo",	@"Italy",@"Pagadebit di Romagna",	@"Italy",@"Reggiano",	@"Italy",@"Reno",	@"Italy",@"Romagna Albana Spumante",	@"Italy",@"Sangiovese di Romagna",	@"Italy",@"Trebbiano di Romagna",	@"Italy",@"Carso",	@"Italy",@"Colli Orientali del Friuli",	@"Italy",@"Colli Orientali del Friuli Cialla",	@"Italy",@"Colli Orientali del Friuli Rosazzo",	@"Italy",@"Collio Goriziano",	@"Italy",@"Friuli Annia",	@"Italy",@"Friuli Aquileia",	@"Italy",@"Friuli Grave",	@"Italy",@"Friuli Isonzo",	@"Italy",@"Friuli Latisana",	@"Italy",@"Lison Pramaggiore",	@"Italy",@"Aleatico di Gradoli",	@"Italy",@"Aprilia",	@"Italy",@"Atina",	@"Italy",@"Bianco Capena",	@"Italy",@"Castelli Romani",	@"Italy",@"Cerveteri",	@"Italy",@"Piglio",	@"Italy",@"Cesanese di Affile",	@"Italy",@"Cesanese di Olevano Romano",	@"Italy",@"Circeo",	@"Italy",@"Colli Albani",	@"Italy",@"Colli della Sabina",	@"Italy",@"Colli Etruschi Viterbesi",	@"Italy",@"Colli Lanuvini",	@"Italy",@"Cori",	@"Italy",@"Est! Est!! Est!!! di Montefiascone",	@"Italy",@"Frascati",	@"Italy",@"Genazzano",	@"Italy",@"Marino",	@"Italy",@"Montecompatri Colonna",	@"Italy",@"Nettuno",	@"Italy",@"Orvieto",	@"Italy",@"Roma",	@"Italy",@"Tarquinia",	@"Italy",@"Terracina",	@"Italy",@"Velletri",	@"Italy",@"Vignanello",	@"Italy",@"Zagarolo",	@"Italy",@"Cinque Terre",	@"Italy",@"Cinque Terre Sciacchetrà",	@"Italy",@"Colli di Luni",	@"Italy",@"Colline di Levanto",	@"Italy",@"Golfo del Tigullio",	@"Italy",@"Riviera Ligure di Ponente",	@"Italy",@"Rossese di Dolceacqua",	@"Italy",@"Val Polcevera",	@"Italy",@"Pornassio",	@"Italy",@"Botticino",	@"Italy",@"Bonarda dell'Otrepo Pavese",	@"Italy",@"Buttafuoco dell'Oltrepo Pavese",	@"Italy",@"Casteggio",	@"Italy",@"Capriano del Colle",	@"Italy",@"Cellatica",	@"Italy",@"Garda",	@"Italy",@"Garda Colli Mantovani",	@"Italy",@"Lambrusco Mantovano",	@"Italy",@"Lugana",	@"Italy",@"Oltrepò Pavese",	@"Italy",@"Riviera del Garda Bresciano",	@"Italy",@"San Colombano al Lambro",	@"Italy",@"San Martino della Battaglia",	@"Italy",@"Scanzo",	@"Italy",@"Terre di Franciacorta",	@"Italy",@"Valcalepio",	@"Italy",@"Valtellina Rosso",	@"Italy",@"Valtenesi",	@"Italy",@"Bianchello del Metauro",	@"Italy",@"Colli Maceratesi",	@"Italy",@"Colli Pesaresi",	@"Italy",@"Esino",	@"Italy",@"Falerio dei Colli Ascolani",	@"Italy",@"Lacrima di Morro d'Alba",	@"Italy",@"Offida",	@"Italy",@"Pergola",	@"Italy",@"Rosso Conero",	@"Italy",@"Rosso Piceno",	@"Italy",@"Verdicchio dei Castelli di Jesi",	@"Italy",@"Verdicchio di Matelica",	@"Italy",@"Biferno",	@"Italy",@"Molise",	@"Italy",@"Pentro di Isernia",	@"Italy",@"Tintilia",	@"Italy",@"Albugnano ",	@"Italy",@"Alta Langa",	@"Italy",@"Barbera d'Alba",	@"Italy",@"Barbera d'Asti ",	@"Italy",@"Barbera del Monferrato",	@"Italy",@"Boca",	@"Italy",@"Bramaterra ",	@"Italy",@"Calosso",	@"Italy",@"Canavese",	@"Italy",@"Carema",	@"Italy",@"Cisterna d'Asti",	@"Italy",@"Colli Tortonesi",	@"Italy",@"Collina Torinese",	@"Italy",@"Colline Novaresi",	@"Italy",@"Colline Saluzzesi",	@"Italy",@"Cortese dell'Alto Monferrato",	@"Italy",@"Coste della Sesia",	@"Italy",@"Dolcetto d'Acqui",	@"Italy",@"Dolcetto d'Alba",	@"Italy",@"Dolcetto d'Asti",	@"Italy",@"Dolcetto delle Langhe Monregalesi",	@"Italy",@"Dolcetto di Diano d'Alba",	@"Italy",@"Dolcetto di Dogliani",	@"Italy",@"Dolcetto di Ovada",	@"Italy",@"Erbaluce di Caluso",	@"Italy",@"Fara",	@"Italy",@"Freisa d'Asti",	@"Italy",@"Freisa di Chieri",	@"Italy",@"Gabiano",	@"Italy",@"Grignolino d'Asti",	@"Italy",@"Grignolino del Monferrato Casalese",	@"Italy",@"Langhe",	@"Italy",@"Lessona",	@"Italy",@"Loazzolo",	@"Italy",@"Malvasia di Casorzo d'Asti",	@"Italy",@"Malvasia di Castelnuovo Don Bosco",	@"Italy",@"Monferrato",	@"Italy",@"Nebbiolo d'Alba",	@"Italy",@"Piemonte",	@"Italy",@"Pinerolese",	@"Italy",@"Rubino di Cantavenna",	@"Italy",@"Ruché di Castagnole Monferrato",	@"Italy",@"Sizzano",	@"Italy",@"Valsusa",	@"Italy",@"Verduno Pelaverga",	@"Italy",@"Aleatico di Puglia",	@"Italy",@"Alezio",	@"Italy",@"Barletta",	@"Italy",@"Brindisi",	@"Italy",@"Cacc'e mmitte di Lucera",	@"Italy",@"Castel del Monte",	@"Italy",@"Colline Joniche Taratine",	@"Italy",@"Copertino",	@"Italy",@"Galatina",	@"Italy",@"Gioia del Colle",	@"Italy",@"Gravina",	@"Italy",@"Leverano",	@"Italy",@"Lizzano",	@"Italy",@"Locorotondo",	@"Italy",@"Martina",	@"Italy",@"Matino",	@"Italy",@"Moscato di Trani",	@"Italy",@"Nardò",	@"Italy",@"Negroamaro di Terra d'Otranto",	@"Italy",@"Orta Nova",	@"Italy",@"Ostuni",	@"Italy",@"Primitivo di Manduria",	@"Italy",@"Rosso Barletta ",	@"Italy",@"Rosso Canosa",	@"Italy",@"Rosso di Cerignola",	@"Italy",@"Salice Salentino",	@"Italy",@"San Severo",	@"Italy",@"Squinzano",	@"Italy",@"Tavoliere delle Puglie",	@"Italy",@"Terra d'Otranto",	@"Italy",@"Alghero",	@"Italy",@"Arborea",	@"Italy",@"Campidano di Terralba",	@"Italy",@"Cannonau di Sardegna",	@"Italy",@"Carignano del Sulcis",	@"Italy",@"Girò di Cagliari",	@"Italy",@"Malvasia di Bosa",	@"Italy",@"Malvasia di Cagliari",	@"Italy",@"Mandrolisai",	@"Italy",@"Monica di Cagliari",	@"Italy",@"Monica di Sardegna",	@"Italy",@"Moscato di Cagliari",	@"Italy",@"Moscato di Sardegna",	@"Italy",@"Moscato di Sorso Sennori",	@"Italy",@"Nasco di Cagliari",	@"Italy",@"Nuragus di Cagliari",	@"Italy",@"Sardegna Semidano",	@"Italy",@"Vermentino di Sardegna",	@"Italy",@"Vernaccia di Oristano",	@"Italy",@"Alcamo",	@"Italy",@"Contea di Sclafani",	@"Italy",@"Contessa Entellina",	@"Italy",@"Delia Nivolelli Nero d'Avola",	@"Italy",@"Eloro",	@"Italy",@"Erice",	@"Italy",@"Etna",	@"Italy",@"Faro",	@"Italy",@"Malvasia delle Lipari",	@"Italy",@"Mamertino di Milazzo",	@"Italy",@"Marsala",	@"Italy",@"Menfi",	@"Italy",@"Monreale",	@"Italy",@"Noto",	@"Italy",@"Moscato di Pantelleria",	@"Italy",@"Moscato di Siracusa",	@"Italy",@"Riesi",	@"Italy",@"Salaparuta",	@"Italy",@"Sambuca di Sicilia",	@"Italy",@"Santa Margherita di Belice",	@"Italy",@"Sciacca",	@"Italy",@"Siracusa",	@"Italy",@"Vittoria",	@"Italy",@"Ansonica Costa dell'Argentario",	@"Italy",@"Barco Reale di Carmignano",	@"Italy",@"Bianco della Valdinievole",	@"Italy",@"Bianco dell'Empolese",	@"Italy",@"Bianco di Pitigliano",	@"Italy",@"Bianco Pisano di San Torpè",	@"Italy",@"Bianco Vergine della Valdichiana",	@"Italy",@"Bolgheri",	@"Italy",@"Candia dei Colli Apuani",	@"Italy",@"Capalbio",	@"Italy",@"Colli dell'Etruria Centrale",	@"Italy",@"Colli di Luni",	@"Italy",@"Colline Lucchesi",	@"Italy",@"Cortona",	@"Italy",@"Elba",	@"Italy",@"Maremma Toscana",	@"Italy",@"Montecarlo",	@"Italy",@"Montecucco",	@"Italy",@"Monteregio di Massa Marittima",	@"Italy",@"Montescudaio",	@"Italy",@"Moscadello di Montalcino",	@"Italy",@"Orcia",	@"Italy",@"Parrina",	@"Italy",@"Pomino",	@"Italy",@"Rosso di Montalcino",	@"Italy",@"Rosso di Montepulciano",	@"Italy",@"San Gimignano",	@"Italy",@"Sant'Antimo",	@"Italy",@"Sovana",	@"Italy",@"Val d'Arbia",	@"Italy",@"Vin Santo del Chianti",	@"Italy",@"Vin Santo del Chianti Classico",	@"Italy",@"Vin Santo di Montepulciano",	@"Italy",@"Südtirol",	@"Italy",@"Kalterersee",	@"Italy",@"Valdadige",	@"Italy",@"Santa Maddalena",	@"Italy",@"Casteller",	@"Italy",@"Teroldego Rotaliano",	@"Italy",@"Trentino",	@"Italy",@"Trento",	@"Italy",@"Lago di Caldaro",	@"Italy",@"Valdadige",	@"Italy",@"Amelia",	@"Italy",@"Assisi",	@"Italy",@"Colli Altotiberini",	@"Italy",@"Colli Amerini",	@"Italy",@"Colli del Trasimeno",	@"Italy",@"Colli Martani",	@"Italy",@"Colli Perugini",	@"Italy",@"Lago di Corbara",	@"Italy",@"Montefalco",	@"Italy",@"Orvieto",	@"Italy",@"Rosso Orvietano",	@"Italy",@"Spoleto",	@"Italy",@"Todi",	@"Italy",@"Torgiano",	@"Italy",@"Valle d'Aosta",	@"Italy",@"Arcole",	@"Italy",@"Bagnoli di Sopra",	@"Italy",@"Bardolino",	@"Italy",@"Bianco di Custoza",	@"Italy",@"Breganze",	@"Italy",@"Colli Berici",	@"Italy",@"Colli di Conegliano",	@"Italy",@"Colli Euganei",	@"Italy",@"Corti Benedettine del Padovano",	@"Italy",@"Gambellara",	@"Italy",@"Garda",	@"Italy",@"Lison Pramaggiore",	@"Italy",@"Lugana",	@"Italy",@"Merlara",	@"Italy",@"Montello e Colli Asolani",	@"Italy",@"Monti Lessini",	@"Italy",@"Piave",	@"Italy",@"Prosecco",	@"Italy",@"Riviera del Brenta",	@"Italy",@"San Martino della Battaglia",	@"Italy",@"Soave",	@"Italy",@"Valdadige",	@"Italy",@"Valpolicella",	@"Italy",@"Valpolicella Ripasso",	@"Italy",@"Venezia",	@"Italy",@"Vicenza",	@"Italy",@"Vin Santo di Gambellara",	@"Romania",@"Moldavia",	@"Romania",@"Muntenia",	@"Romania",@"Oltenia",	@"Romania",@"Transylvania",	@"Romania",@"Crişana",	@"Romania",@"Banat",	@"Romania",@"Dobrogea",	@"Romania",@"Cotnari",	@"Romania",@"Dealu Mare",	@"Romania",@"Jidvei",	@"Romania",@"Murfatlar",	@"Romania",@"Panciu",	@"Romania",@"Odobeşti",	@"Romania",@"Cotești",	@"Romania",@"Recaș",	@"Romania",@"Târnave",	@"Romania",@"Vânju Mare",	@"Romania",@"Bucium",	@"Romania",@"Dragasani",	@"Romania",@"Colinele Tutovei",	@"Romania",@"Vaslui",	@"Romania",@"Cucuteni",	@"Romania",@"Hârlău",	@"Romania",@"Târgu Frumos",	@"Romania",@"Covurlui",	@"Romania",@"Dealul Bujorului",	@"Romania",@"Bereşti",	@"Romania",@"Huşi",	@"Romania",@"Bohotin",	@"Romania",@"Iaşi",	@"Romania",@"Tomeşti",	@"Romania",@"Comarna",	@"Romania",@"Copou",	@"Romania",@"Probota",	@"Romania",@"Iveşti",	@"Romania",@"Corod",	@"Romania",@"Tecuci",	@"Romania",@"Nicoreşti",	@"Romania",@"Jariştea",	@"Romania",@"Panciu",	@"Romania",@"Păuneşti",	@"Romania",@"Ţifeşti",	@"Romania",@"Zeletin",	@"Romania",@"Dealu Morii",	@"Romania",@"Tănăsoaia",	@"Romania",@"Zeletin",	@"Romania",@"Hlipicani",	@"Romania",@"Nămoloasa",	@"Romania",@"Sercaia",	@"Romania",@"Breaza",	@"Romania",@"Seciu",	@"Romania",@"Cricov",	@"Romania",@"Pietroasa",	@"Romania",@"Tohani",	@"Romania",@"Urlaţi - Ceptura",	@"Romania",@"Valea Călugărească",	@"Romania",@"Zoreşti",	@"Romania",@"Dealurile Buzăului",	@"Romania",@"Râmnicu Sărat",	@"Romania",@"Zărneşti",	@"Romania",@"Ştefăneşti",	@"Romania",@"Topoloveni",	@"Romania",@"Valea Mare",	@"Romania",@"Calafat",	@"Romania",@"Cetate",	@"Romania",@"Poiana Mare",	@"Romania",@"Dealurile Craiovei",	@"Romania",@"Banu Mărăcine",	@"Romania",@"Drăgăşani",	@"Romania",@"Iancu Jianu",	@"Romania",@"Greaca",	@"Romania",@"Zimnicea",	@"Romania",@"Plaiurile Drâncei",	@"Romania",@"Golul Drincei",	@"Romania",@"Oreviţa",	@"Romania",@"Pleniţa",	@"Romania",@"Podgoria Dacilor",	@"Romania",@"Izvoarele",	@"Romania",@"Podgoria Severinului",	@"Romania",@"Corcova",	@"Romania",@"Segarcea",	@"Romania",@"Dealul Viilor",	@"Romania",@"Sadova-Corabia",	@"Romania",@"Dăbuleni",	@"Romania",@"Potelu",	@"Romania",@"Tâmbureşti",	@"Romania",@"Sâmbureşti",	@"Romania",@"Blaj",	@"Romania",@"Jidvei",	@"Romania",@"Mediaş",	@"Romania",@"Târnăveni",	@"Romania",@"Valea Nirajului",	@"Romania",@"Lechinta",	@"Romania",@"Bistriţa",	@"Romania",@"Teaca",	@"Romania",@"Şamşud",	@"Romania",@"Şimleul Silvaniei",	@"Romania",@"Aiud",	@"Romania",@"Triteni",	@"Romania",@"Alba Iulia",	@"Romania",@"Ighiu",	@"Romania",@"Sebeş-Apold",	@"Romania",@"Diosig",	@"Romania",@"Săcuieni",	@"Romania",@"Sâniob",	@"Romania",@"Sanislău",	@"Romania",@"Valea lui Mihai",	@"Romania",@"Arad",	@"Romania",@"Jamu Mare",	@"Romania",@"Moldova Nouă",	@"Romania",@"Silagiu",	@"Romania",@"Teremia",	@"Romania",@"Tirol",	@"Romania",@"Măderat",	@"Romania",@"Miniş",	@"Romania",@"Babadag",	@"Romania",@"Istria",	@"Romania",@"Valea Nucarilor",	@"Romania",@"Cernavodă",	@"Romania",@"Medgidia",	@"Romania",@"Valu lui Traian",	@"Romania",@"Poarta Albă",	@"Romania",@"Simioc",	@"Romania",@"Valea Dacilor",@"Romania",@"Ostrov Constanţa",@"Romania",@"Aliman",	@"Romania",@"Băneasa",@"Romania",@"OstrovTulcea",@"Romania",@"Oltina",	@"Romania",@"Sarica-Niculiţel",	@"Romania",@"Măcin",	@"Romania",@"Tulcea",	@"Romania",@"Adamclisi",	@"Romania",@"Chirnogeni",	@"Romania",@"Dăeni",	@"Romania",@"Hârşova",	@"France",@"Corse",	@"France",@"Ajaccio",	@"France",@"Bourgogne",	@"France",@"Côte de Beaune",	@"France",@"Côte chalonnaise",	@"France",@"Bordeaux",	@"France",@"Sauternais",	@"France",@"Graves",	@"France",@"Médoc",	@"France",@"Aloxe-corton",	@"France",@"Alsace",	@"France",@"Alsace grand cru",	@"France",@"Anjou",	@"France",@"Vallée de la Loire",	@"France",@"Anjou-coteaux-de-la-loire",	@"France",@"Anjou villages",	@"France",@"Anjou villages Brissac",	@"France",@"Arbois",	@"France",@"Jura",	@"France",@"Auxey-duresses",	@"France",@"Bandol",	@"France",@"Banyuls",	@"France",@"Banyuls grand cru",	@"France",@"Barsac",	@"France",@"Bâtard-Montrachet",	@"France",@"Béarn",	@"France",@"Beaujolais",	@"France",@"Beaujolais-villages",	@"France",@"Beaumes-de-venise",	@"France",@"Beaune",	@"France",@"Bellet",	@"France",@"Bergerac",	@"France",@"Bienvenues-Bâtard-Montrachet",	@"France",@"Blagny",	@"France",@"Blaye",	@"France",@"Bonnes-mares",	@"France",@"Bonnezeaux",	@"France",@"Bordeaux supérieur",	@"France",@"Bourgogne aligoté",	@"France",@"Bourgogne ordinaire",	@"France",@"Bourgogne grand ordinaire",	@"France",@"Bourgogne mousseux",	@"France",@"Bourgogne passe-tout-grains",	@"France",@"Bourgueil",	@"France",@"Bouzeron",	@"France",@"Brouilly",	@"France",@"Bugey",	@"France",@"Buzet",	@"France",@"Cabardès",	@"France",@"Cabernet d'Anjou",	@"France",@"Cabernet de Saumur",	@"France",@"Cadillac",	@"France",@"Cahors",	@"France",@"Canon-Fronsac",	@"France",@"Cassis",	@"France",@"Cérons",	@"France",@"Chablis",	@"France",@"Chablis grand cru",	@"France",@"Chambertin",	@"France",@"Chambertin-clos-de-bèze",	@"France",@"Chambolle-Musigny",	@"France",@"Champagne",	@"France",@"Chapelle-Chambertin",	@"France",@"Charlemagne",	@"France",@"Charmes-Chambertin",	@"France",@"Chassagne-Montrachet",	@"France",@"Château-Chalon",	@"France",@"Château-Grillet",	@"France",@"Châteaumeillant",	@"France",@"Châteauneuf-du-pape",	@"France",@"Châtillon-en-Diois",	@"France",@"Chénas",	@"France",@"Chevalier-Montrachet",	@"France",@"Cheverny",	@"France",@"Chinon",	@"France",@"Chiroubles",	@"France",@"Chorey-lès-Beaune",	@"France",@"Clairette de Bellegarde",	@"France",@"Clairette de Die",	@"France",@"Clairette du Languedoc",	@"France",@"Clos de la Roche",	@"France",@"Clos de Tart",	@"France",@"Clos de Vougeot",	@"France",@"Clos des Lambrays",	@"France",@"Clos Saint Denis",	@"France",@"Collioure",	@"France",@"Condrieu",	@"France",@"Corbières",	@"France",@"Corbières-Boutenac",	@"France",@"Cornas",	@"France",@"Corton",	@"France",@"Corton-Charlemagne",	@"France",@"Costières de Nîmes",	@"France",@"Côte-de-Beaune villages",	@"France",@"Côte de Nuits villages",	@"France",@"Côte de Brouilly",	@"France",@"Côte roannaise",	@"France",@"Côte rôtie",	@"France",@"Coteaux champenois",	@"France",@"Coteaux d'Aix-en-Provence",	@"France",@"Coteaux de Die",	@"France",@"Coteaux de l'Aubance",	@"France",@"Coteaux de Saumur",	@"France",@"Coteaux du Giennois",	@"France",@"Coteaux du Layon",	@"France",@"Coteaux du Loir",	@"France",@"Coteaux du lyonnais",	@"France",@"Coteaux du vendômois",	@"France",@"Coteaux varois en Provence",	@"France",@"Côtes de Bergerac",	@"France",@"Côtes de Blaye",	@"France",@"Côtes de Bordeaux",	@"France",@"Côtes de Bordeaux - Saint Macaire",	@"France",@"Côtes de Bourg",	@"France",@"Côtes de Duras",	@"France",@"Côtes de Montravel",	@"France",@"Côtes de Provence",	@"France",@"Côtes de Toul",	@"France",@"Côtes du Forez",	@"France",@"Côtes du Jura",	@"France",@"Côtes du Marmandais",	@"France",@"Côtes du Rhône",	@"France",@"Côtes du Rhône villages",	@"France",@"Côtes du Roussillon",	@"France",@"Côtes du Roussillon villages",	@"France",@"Côtes du Vivarais",	@"France",@"Cour-Cheverny",	@"France",@"Crémant d'Alsace",	@"France",@"Crémant de Bordeaux",	@"France",@"Crémant de Bourgogne",	@"France",@"Crémant de Die",	@"France",@"Crémant de Limoux",	@"France",@"Crémant de Loire",	@"France",@"Crémant du Jura",	@"France",@"Criots-Bâtard-Montrachet",	@"France",@"Crozes-Hermitage",	@"France",@"Echezeaux",	@"France",@"Entre-deux-mers",	@"France",@"Faugères",	@"France",@"Fiefs-vendéens",	@"France",@"Fitou",	@"France",@"Fixin",	@"France",@"Fleurie",	@"France",@"Fronsac",	@"France",@"Fronton",	@"France",@"Gaillac",	@"France",@"Gaillac-premières-côtes",	@"France",@"Gevrey-Chambertin",	@"France",@"Gigondas",	@"France",@"Givry",	@"France",@"Grands-Echezeaux",	@"France",@"Graves-de-Vayres",	@"France",@"Graves-Supérieures",	@"France",@"Grignan-les-Adhémar",	@"France",@"Griotte-Chambertin",	@"France",@"Haut-Médoc",	@"France",@"Haut-Montravel",	@"France",@"Haut-Poitou",	@"France",@"Hermitage",	@"France",@"Irancy",	@"France",@"Irouléguy",	@"France",@"Jasnières",	@"France",@"Juliénas",	@"France",@"jurançon",	@"France",@"L'Etoile",	@"France",@"La-Grande Rue",	@"France",@"La Romanée",	@"France",@"La Tâche",	@"France",@"Ladoix",	@"France",@"Lalande de Pomerol",	@"France",@"Languedoc",	@"France",@"Latricières-Chambertin",	@"France",@"Les baux de Provence",	@"France",@"Limoux",	@"France",@"Lirac",	@"France",@"Listrac-Médoc",	@"France",@"Loupiac",	@"France",@"Luberon",	@"France",@"Lussac-Saint Emilion",	@"France",@"Mâcon",	@"France",@"Madiran",	@"France",@"Malepère",	@"France",@"Maranges",	@"France",@"Marcillac",	@"France",@"Margaux",	@"France",@"Marsannay",	@"France",@"Maury",	@"France",@"Mazis-Chambertin",	@"France",@"Mazoyères-Chambertin",	@"France",@"Menetou-Salon",	@"France",@"Mercurey",	@"France",@"Meursault",	@"France",@"Minervois",	@"France",@"Minervois-la-Livinière",	@"France",@"Monbazillac",	@"France",@"Montagne Saint Emilion",	@"France",@"Montagny",	@"France",@"Monthélie",	@"France",@"Montlouis-sur-Loire",	@"France",@"Montrachet",	@"France",@"Montravel",	@"France",@"Morey-Saint-Denis",	@"France",@"Morgon",	@"France",@"Moselle",	@"France",@"Moulin-à-vent",	@"France",@"Moulis",	@"France",@"Muscadet",	@"France",@"Muscadet-Coteaux-de-la-Loire",	@"France",@"Muscadet-Côtes-de-Grandlieu",	@"France",@"Muscadet-Sèvre-et-Maine",	@"France",@"Muscat de Beaumes-de-Venise",	@"France",@"Muscat de Frontignan",	@"France",@"Muscat de Lunel",	@"France",@"Muscat de Mireval",	@"France",@"Muscat de Rivesaltes",	@"France",@"Muscat de Saint-Jean-de-Minervois",	@"France",@"Muscat du Cap-Corse",	@"France",@"Musigny",	@"France",@"Néac",	@"France",@"Nuits-Saint-Georges",	@"France",@"Orléans",	@"France",@"Orléans-Cléry",	@"France",@"Pacherenc-du-Vic-Bilh",	@"France",@"Palette",	@"France",@"Patrimonio",	@"France",@"Pauillac",	@"France",@"Pécharmant",	@"France",@"Pernand-Vergelesses",	@"France",@"Pessac-Léognan",	@"France",@"Petit-Chablis",	@"France",@"Pierrevert",	@"France",@"Pomerol",	@"France",@"Pommard",	@"France",@"Pouilly-fuissé",	@"France",@"Pouilly-fumé",	@"France",@"Blanc-fumé de Pouilly",	@"France",@"Pouilly-Loché",	@"France",@"Pouilly-sur-Loire",	@"France",@"Pouilly-Vinzelles",	@"France",@"Premières Côtes de Bordeaux",	@"France",@"Puisseguin-Saint Emilion",	@"France",@"Puligny-Montrachet",	@"France",@"Quarts-de-Chaume",	@"France",@"Quincy",	@"France",@"Rasteau",	@"France",@"Régnié",	@"France",@"Reuilly",	@"France",@"Richebourg",	@"France",@"Rivesaltes",	@"France",@"Romanée-Conti",	@"France",@"Romanée-Saint Vivant",	@"France",@"Rosé d'Anjou",	@"France",@"Rosé de Loire",	@"France",@"Rosé des Riceys",	@"France",@"Rosette",	@"France",@"Roussette de Savoie",	@"France",@"Roussette du Bugey",	@"France",@"Ruchottes-Chambertin",	@"France",@"Rully",	@"France",@"Saint Amour",	@"France",@"Saint Aubin",	@"France",@"Saint Bris",	@"France",@"Saint Chinian",	@"France",@"Saint Emilion",	@"France",@"Saint Emilion grand cru",	@"France",@"Saint Estèphe",	@"France",@"Saint Georges-Saint Emilion",	@"France",@"Saint Joseph",	@"France",@"Saint Julien",	@"France",@"Saint Nicolas de Bourgueil",	@"France",@"Saint Péray",	@"France",@"Saint Pourçain",	@"France",@"Saint Romain",	@"France",@"Saint Véran",	@"France",@"Sainte Croix du Mont",	@"France",@"Sainte Foy-Bordeaux",	@"France",@"Sancerre",	@"France",@"Santenay",	@"France",@"Saumur",	@"France",@"Saumur-Champigny",	@"France",@"Saussignac",	@"France",@"Sauternes",	@"France",@"Savennières",	@"France",@"Savigny-lès-Beaune",	@"France",@"Seyssel",	@"France",@"Tavel",	@"France",@"Touraine",	@"France",@"Touraine-Noble-Joué",	@"France",@"Vacqueyras",	@"France",@"Valençay",	@"France",@"Ventoux",	@"France",@"Savoie",	@"France",@"Vinsobres",	@"France",@"Viré-Clessé",	@"France",@"Volnay",	@"France",@"Vosne-Romanée",	@"France",@"Vougeot",	@"France",@"Vouvray",	@"France",@"Coteaux d'Ancenis",	@"France",@"Coteaux du Quercy",	@"France",@"Côtes de Millau",	@"France",@"Côtes de Saint Mont",	@"France",@"Tursan",	@"France",@"Entraygues et du Fel",	@"France",@"Estaing",	@"France",@"Saint Sardos",	@"France",@"Gros plant du pays nantais",	@"France",@"Côtes du Brulhois",	@"France",@"Haut-Poitou",	@"France",@"Côtes d'auvergne",	@"France",@"Vin du Thouarsais",	@"France",@"Lavilledieu",	@"Spain",@"Condado de Huelva",	@"Spain",@"Jerez-Xeres-Sherry",	@"Spain",@"Manzanilla de Sanlúcar de Barrameda",	@"Spain",@"Montilla-Moriles",	@"Spain",@"Málaga and Sierras de Málaga",	@"Spain",@"Calatayud",	@"Spain",@"Campo de Borja",	@"Spain",@"Campo de Cariñena",	@"Spain",@"Somontano",	@"Spain",@"Cava",	@"Spain",@"Bierzo",	@"Spain",@"Cigales",	@"Spain",@"Ribera del Duero",	@"Spain",@"Rueda",	@"Spain",@"Toro",	@"Spain",@"Almansa",	@"Spain",@"Dominio de Valdepusa",	@"Spain",@"La Mancha",	@"Spain",@"Manchuela",	@"Spain",@"Méntrida",	@"Spain",@"Mondéjar",	@"Spain",@"Guijoso",	@"Spain",@"Ribera del Júcar",	@"Spain",@"Valdepeñas",	@"Spain",@"Jumilla",	@"Spain",@"Alella",	@"Spain",@"Empordà",	@"Spain",@"Catalunya",	@"Spain",@"Conca de Barberà",	@"Spain",@"Costers del Segre",	@"Spain",@"Montsant",	@"Spain",@"Penedès",	@"Spain",@"Pla de Bages",	@"Spain",@"Priorat",	@"Spain",@"Tarragona",	@"Spain",@"Terra Alta",	@"Spain",@"Vinos de Madrid",	@"Spain",@"Alicante",	@"Spain",@"Utiel-Requena",	@"Spain",@"Valencia",	@"Spain",@"Ribera del Guadiana",	@"Spain",@"Monterrey",	@"Spain",@"Rías Bajas",	@"Spain",@"Ribeira Sacra",	@"Spain",@"Ribeiro",	@"Spain",@"Valdeorras",	@"Spain",@"Binissalem-Mallorca",	@"Spain",@"Plà i Llevant",@"Spain", @"Abona",@"Spain",@"La Gomera",	@"Spain",@"Gran Canaria",	@"Spain",@"El Hierro",	@"Spain",@"La Palma",	@"Spain",@"Lanzarote",	@"Spain",@"Tacoronte-Acentejo",	@"Spain",@"Valle de Güímar",	@"Spain",@"Valle de la Orotava",	@"Spain",@"Ycoden-Daute-Isora",	@"Spain",@"Navarra",	@"Spain",@"Rioja",	@"Spain",@"Alavan Txakoli",	@"Spain",@"Biscayan Txakoli",@"Spain",@"Getaria Txakoli",	@"Spain",@"Rioja (Alavesa)",	@"Spain",@"Bullas",	@"Spain",@"Yecla",@"Spain",@"Jumilla",nil];
    
    return [RegionsInfos objectForKey:Region];
    
}


- (NSArray *) CalculateTasteInfoLines
{
    NSString *TitleLine = @"Tasted good...";
    NSString *SubtitleLine = [[NSString alloc] init];
    
    BOOL Hasinfo = NO;
    BOOL IsFirst = YES;
    if (self.TasteInfo)
    {
    if ([self.TasteInfo[0] isEqual:@YES])
    {
        SubtitleLine = @"with everything";
        return @[TitleLine,SubtitleLine];
    }
    if ([self.TasteInfo[6] isEqual:@YES])
    {
        TitleLine = @"Tasted bad";
        SubtitleLine = @"overall";
        return @[TitleLine,SubtitleLine];
    }
    if ([self.TasteInfo[1] isEqual:@YES])
    {
        Hasinfo = YES;
        SubtitleLine = @"for a drink";
        if (IsFirst)
            IsFirst = NO;
    }
    if ([self.TasteInfo[2] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with meat";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with meat"];
    }
    if ([self.TasteInfo[3] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with fish";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with fish"];
    }
    if ([self.TasteInfo[4] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with cheese";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with cheese"];
    }
    if ([self.TasteInfo[5] isEqual:@YES])
    {
        Hasinfo = YES;
        if (IsFirst)
        {
            IsFirst = NO;
            SubtitleLine = @"with dessert";
        }
        else
            SubtitleLine = [SubtitleLine stringByAppendingString:@", with dessert"];
    }
    }
    if (!Hasinfo)
    {
        TitleLine = @"No info on your taste";
        SubtitleLine = @"Select to precise your taste";
    }
    
    return @[TitleLine,SubtitleLine];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*! Determines if the given indexPath has a cell below it with a YearPicker.
 
 @param indexPath The indexPath to check if its cell has a YearPicker below it.
 */
- (BOOL)hasPickerForIndexPath:(NSIndexPath *)indexPath
{
    //BOOL hasDatePicker = NO;
    BOOL hasPicker = NO;
    
    NSInteger targetedRow = indexPath.row;
    targetedRow++;
    
    UITableViewCell *checkYearPickerCell =
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:targetedRow inSection:0]];
    XYZYearPicker *checkDatePicker = (XYZYearPicker *)[checkYearPickerCell viewWithTag:kDatePickerTag];
    
    XYZCountryPicker *checkCountryPicker = (XYZCountryPicker *) [checkYearPickerCell viewWithTag:kCountryPickerTag];
    
    XYZRegionPicker *checkRegionPicker = (XYZRegionPicker *) [checkYearPickerCell viewWithTag:kRegionPickerTag];
    
    XYZVarietalsPicker *checkVarietalsPicker = (XYZVarietalsPicker *) [checkYearPickerCell viewWithTag:kVarietalsPickerTag];
    
    XYZColorPicker *checkColorPicker = (XYZColorPicker *) [checkYearPickerCell viewWithTag:kColorPickerTag];
    
    //hasDatePicker = (checkDatePicker != nil);
    //return hasDatePicker;
    hasPicker = ((checkDatePicker != nil)||(checkCountryPicker != nil)||(checkRegionPicker !=nil)||(checkVarietalsPicker !=nil)||(checkColorPicker !=nil));
    return hasPicker;
}

/*! Determines if the UITableViewController has a YearPicker in any of its cells.
 */
- (BOOL)hasInlineDatePicker
{
    return (self.datePickerIndexPath != nil);
}

-(BOOL)hasInLineCountryPicker
{
    return (self.CountryPickerIndexPath != nil);
}

-(BOOL)hasInLineRegionPicker
{
    return (self.RegionPickerIndexPath != nil);
}

-(BOOL)hasInLineVarietalsPicker
{
    return (self.VarietalsPickerIndexPath != nil);
}

-(BOOL)hasInLineColorPicker
{
    return (self.ColorPickerIndexPath != nil);
}

/*! Determines if the given indexPath points to a cell that contains the YearPicker.
 
 @param indexPath The indexPath to check if it represents a cell with the YearPicker.
 */
- (BOOL)indexPathHasYearPicker:(NSIndexPath *)indexPath
{
    return ([self hasInlineDatePicker] && (self.datePickerIndexPath.row == indexPath.row));
}

- (BOOL)indexPathHasCountryPicker:(NSIndexPath *)indexPath
{
    return ([self hasInLineCountryPicker] && (self.CountryPickerIndexPath.row == indexPath.row));
}

- (BOOL)indexPathHasRegionPicker:(NSIndexPath *)indexPath
{
    return ([self hasInLineRegionPicker] && (self.RegionPickerIndexPath.row == indexPath.row));
}

- (BOOL)indexPathHasVarietalsPicker:(NSIndexPath *)indexPath
{
    return ([self hasInLineVarietalsPicker] && (self.VarietalsPickerIndexPath.row == indexPath.row));
}

- (BOOL)indexPathHasColorPicker:(NSIndexPath *)indexPath
{
    return ([self hasInLineColorPicker] && (self.ColorPickerIndexPath.row == indexPath.row));
}

/*! Determines if the given indexPath points to a cell that contains the Wine Year.
 
 @param indexPath The indexPath to check if it represents Wine Year cell.
 */
- (BOOL)indexPathHasDate:(NSIndexPath *)indexPath
{
    BOOL hasDate = NO;
    
    if (indexPath.row == kDateYearRow)
    {
        hasDate = YES;
    }
    
    return hasDate;
}

- (BOOL)indexPathHasCountry:(NSIndexPath *)indexPath
{
    BOOL hasCountry = NO;
    
    if ([self hasInlineDatePicker] && (indexPath.row == 3))
    {
        hasCountry = YES;
    }
    else if (indexPath.row == 2)
    {
        hasCountry = YES;
    }
    
    return hasCountry;
}

- (BOOL)indexPathHasRegion:(NSIndexPath *)indexPath
{
    BOOL hasRegion = NO;
    
    if (([self hasInlineDatePicker]||[self hasInLineCountryPicker]) && (indexPath.row == 4))
    {
        hasRegion = YES;
    }
    else if (indexPath.row == 3)
    {
        hasRegion = YES;
    }
    
    return hasRegion;
}

- (BOOL)indexPathHasVarietals:(NSIndexPath *)indexPath
{
    BOOL hasRegion = NO;
    
    if (([self hasInlineDatePicker]||[self hasInLineCountryPicker]||[self hasInLineRegionPicker]) && (indexPath.row == 5))
    {
        hasRegion = YES;
    }
    else if (indexPath.row == 4)
    {
        hasRegion = YES;
    }
    
    return hasRegion;
}

- (BOOL)indexPathHasColor:(NSIndexPath *)indexPath
{
    BOOL hasRegion = NO;
    
    if (([self hasInlineDatePicker]||[self hasInLineCountryPicker]||[self hasInLineRegionPicker]||[self hasInLineVarietalsPicker]) && (indexPath.row == 6))
    {
        hasRegion = YES;
    }
    else if (indexPath.row == 5)
    {
        hasRegion = YES;
    }
    
    return hasRegion;
}

- (BOOL)indexPathHasTasteInfo:(NSIndexPath *)indexPath
{
    BOOL hasRegion = NO;
    
    if (([self hasInlineDatePicker]||[self hasInLineCountryPicker]||[self hasInLineRegionPicker]||[self hasInLineVarietalsPicker] || [self hasInLineColorPicker]) && (indexPath.row == 7))
    {
        hasRegion = YES;
    }
    else if (indexPath.row == 6)
    {
        hasRegion = YES;
    }
    
    return hasRegion;
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (([self indexPathHasYearPicker:indexPath] || ([self indexPathHasCountryPicker:indexPath]) || ([self indexPathHasRegionPicker:indexPath]) || ([self indexPathHasVarietalsPicker:indexPath])||([self indexPathHasColorPicker:indexPath]))? self.pickerCellRowHeight : self.tableView.rowHeight);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasInlineDatePicker] ||  [self hasInLineCountryPicker] || [self hasInLineRegionPicker] || [self hasInLineVarietalsPicker] || [self hasInLineColorPicker])
    {
        // we have a date picker, so allow for it in the number of rows in this section
        NSInteger numRows = self.dataArray.count;
        return ++numRows;
    }
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSString *CellIdentifier = @"ListNewTasteInfo";
    
    if (indexPath.row == 0)
    {
        CellIdentifier = kWineNameCellID;
        self.NameCellIndexPath = indexPath;
    }
    else if ([self indexPathHasYearPicker:indexPath])
    {
        // the indexPath is the one containing the inline date picker
        CellIdentifier = kDatePickerID;     // the current/opened date picker cell
    }
    else if ([self indexPathHasCountryPicker:indexPath])
    {
        CellIdentifier = kCountryPickerCellID;
    }
    else if ([self indexPathHasRegionPicker:indexPath])
    {
        CellIdentifier = kRegionPickerCellID;
    }
    else if ([self indexPathHasVarietalsPicker:indexPath])
    {
        CellIdentifier = kVarietalsPickerCellID;
    }
    else if ([self indexPathHasColorPicker:indexPath])
    {
        CellIdentifier = kColorPickerCellID;
    }
    else if ([self indexPathHasDate:indexPath])
    {
        // the indexPath is one that contains the date information
        CellIdentifier = kDateCellID;
        self.YearCellIndexPath = indexPath;
    }
    else if ([self indexPathHasCountry:indexPath])
    {
        // the indexPath is one that contains the country information
        CellIdentifier = kWineCountryCellID;
        self.CountryCellIndexPath = indexPath;
    }
    else if ([self indexPathHasRegion:indexPath])
    {
        // the indexPath is one that contains the country information
        CellIdentifier = kWineRegionCellID;
        self.RegionCellIndexPath = indexPath;
    }
    else if ([self indexPathHasVarietals:indexPath])
    {
        // the indexPath is one that contains the country information
        CellIdentifier = kWineVarietalsCellID;
        self.VarietalsCellIndexPath = indexPath;
    }
    else if ([self indexPathHasColor:indexPath])
    {
        // the indexPath is one that contains the country information
        CellIdentifier = kWineColorCellID;
        self.ColorCellIndexPath = indexPath;
    }
    else if ([self indexPathHasTasteInfo:indexPath])
    {
        // the indexPath is one that contains the country information
        CellIdentifier = kWineTasteInfoCellID;
        self.TasteInfoCellIndexPath = indexPath;
    }
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    // if we have a date picker open whose cell is above the cell we want to update,
    // then we have one more cell than the model allows
    //
    NSInteger modelRow = indexPath.row;
    if (self.datePickerIndexPath != nil && self.datePickerIndexPath.row < indexPath.row)
    {
        modelRow--;
    }
    if (self.CountryPickerIndexPath != nil && self.CountryPickerIndexPath.row < indexPath.row)
    {
        modelRow--;
    }
    if (self.RegionPickerIndexPath != nil && self.RegionPickerIndexPath.row < indexPath.row)
    {
        modelRow--;
    }
    if (self.VarietalsPickerIndexPath != nil && self.VarietalsPickerIndexPath.row < indexPath.row)
    {
        modelRow--;
    }
    if (self.ColorPickerIndexPath != nil && self.ColorPickerIndexPath.row < indexPath.row)
    {
        modelRow--;
    }
    
    NSDictionary *itemData = self.dataArray[modelRow];
    
    // proceed to configure our cell
    if ([CellIdentifier isEqualToString:kDateCellID])
    {
        // we have either start or end date cells, populate their date field
        //
        if (self.Year !=nil)
        {cell.textLabel.text = self.Year;}
        else
        {cell.textLabel.text = [itemData valueForKey:kTitleKey];}
        
    }
    else if ([CellIdentifier isEqualToString:kOtherCell])
    {
        // this cell is a non-date cell, just assign it's text label
        //
        cell.textLabel.text = [itemData valueForKey:kTitleKey];
    }
    else if ([CellIdentifier isEqualToString:kWineNameCellID])
    {
        //this cell is the wine name, if it exist set the wine name else assign the label
        //self.Name = [itemData valueForKey:kTitleKey];
        if ((self.Name !=nil) && (self.EditTaste))
        {
            [(XYZAddNewTasteWineNameTableCell *)cell SetName:self.Name];
        }
        else
        {
            self.Name = [itemData valueForKey:kTitleKey];
        }
    }
    else if ([CellIdentifier isEqualToString:kWineCountryCellID])
    {
        if (self.Country !=nil)
        {cell.textLabel.text = self.Country;}
        else
        {cell.textLabel.text = [itemData valueForKey:kTitleKey];}
    }
    else if ([CellIdentifier isEqualToString:kWineRegionCellID])
    {
        if (self.Region !=nil)
        {cell.textLabel.text = self.Region;}
        else
        {cell.textLabel.text = [itemData valueForKey:kTitleKey];}
    }
    else if ([CellIdentifier isEqualToString:kWineVarietalsCellID])
    {
        if (self.Varietals !=nil)
        {cell.textLabel.text = self.Varietals;}
        else
        {cell.textLabel.text = [itemData valueForKey:kTitleKey];}
    }
    else if ([CellIdentifier isEqualToString:kWineColorCellID])
    {
        if (self.Color !=nil)
        {cell.textLabel.text = self.Color;}
        else
        {cell.textLabel.text = [itemData valueForKey:kTitleKey];}
    }
    else if ([CellIdentifier isEqualToString:kWineTasteInfoCellID])
    {
        if (self.TasteInfo !=nil)
        {
            NSArray *CellLines = [self CalculateTasteInfoLines];
            cell.textLabel.text = CellLines[0];
            cell.detailTextLabel.text = CellLines[1];
        }
        else
        {
            cell.textLabel.text = [itemData valueForKey:kTitleKey];
            cell.detailTextLabel.text = @"Select to precise your taste";
        }
    }
    else if ([CellIdentifier isEqualToString:kRegionPickerCellID])
    {
        [(XYZRegionPickerTableCell *)cell SetRegion:self.Region withCountry:self.Country];
        ((XYZRegionPickerTableCell *)cell).RegionPicker.Regiondelegate = self;
    }
    else if ([CellIdentifier isEqualToString:kCountryPickerCellID])
    {
        [(XYZCountryPickerTableCell *)cell SetCountry:self.Country];
        ((XYZCountryPickerTableCell *)cell).CountryPicker.Countrydelegate = self;
    }
    else if ([CellIdentifier isEqualToString:kColorPickerCellID])
    {
        [(XYZColorPickerTableCell *)cell SetColor:self.Color];
        ((XYZColorPickerTableCell *)cell).ColorPicker.Colordelegate = self;
    }
    else if ([CellIdentifier isEqualToString:kVarietalsPickerCellID])
    {
        [(XYZVarietalsPickerTableCell *)cell SetVarietal:self.Varietals];
        ((XYZVarietalsPickerTableCell *)cell).VarietalsPicker.Varietalsdelegate = self;
    }
    else if ([CellIdentifier isEqualToString:kDatePickerID])
    {
        [(XYZYearPickerTableCell *)cell SetYear:self.Year];
        ((XYZYearPickerTableCell *)cell).yearPicker.Yeardelegate = self;
    }
    
    
    return cell;
}

/*! Adds or removes a YearPicker cell below the given indexPath.
 
 @param indexPath The indexPath to reveal the UIDatePicker.
 */
- (void)toggleDatePickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    [self.tableView endUpdates];
}

- (void)toggleCountryPickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

- (void)toggleRegionPickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

- (void)toggleVarietalsPickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

- (void)toggleColorPickerForSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    [self.tableView beginUpdates];
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    
    // check if 'indexPath' has an attached date picker below it
    if ([self hasPickerForIndexPath:indexPath])
    {
        // found a picker below it, so remove it
        [self.tableView deleteRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        // didn't find a picker below it, so we should insert it
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [self.tableView endUpdates];
}

/*! Reveals the date picker inline for the given indexPath, called by "didSelectRowAtIndexPath".
 
 @param indexPath The indexPath to reveal the UIDatePicker.
 */
- (void)displayInlineDatePickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellYear = [self.tableView cellForRowAtIndexPath:indexPath];
    XYZYearPickerTableCell *PickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
    
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = (self.datePickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    if ([self hasInLineCountryPicker])
    {
        
        XYZCountryPickerTableCell *CountryPickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
        UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        
        if ((CountryPickerCell.Country)&&(![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]]))
        {
            self.Country = CountryPickerCell.Country;
            self.Region = nil;
            self.RegionReset = YES;
        }
        
        if ((self.Country)&&(self.Country.length > 0))
        {cellCountry.textLabel.text = self.Country;}
        else
        {
            cellCountry.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
            self.Country = nil;
        }
        
        cellCountry.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.CountryPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.CountryPickerIndexPath = nil;
    }
    if ([self hasInLineRegionPicker])
    {
        
        XYZRegionPickerTableCell *RegionPickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        
        if ((RegionPickerCell.Region)&&(![self.Region isEqualToString:RegionPickerCell.Region]))
        {
            self.Region = RegionPickerCell.Region;
        }
        
        if ((self.Region)&&(self.Region.length > 0))
        {cellRegion.textLabel.text = self.Region;}
        else
        {
            cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
            self.Region = nil;
        }
        
        if (self.Country == nil)
        {
        
            UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
            
            self.Country = [self GetCountryFromRegion:self.Region];
            
            cellCountry.textLabel.text = self.Country;
        
        }
        
        cellRegion.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.RegionPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.RegionPickerIndexPath = nil;
    }
    if ([self hasInLineVarietalsPicker])
    {
        
        XYZVarietalsPickerTableCell *VarietalsPickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
        UITableViewCell *cellVarietals = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        
        if ((VarietalsPickerCell.Varietals)&&(![self.Varietals isEqualToString:VarietalsPickerCell.Varietals]))
        {
            self.Varietals = VarietalsPickerCell.Varietals;
        }
        
        if ((self.Varietals)&&(self.Varietals.length > 0))
        {cellVarietals.textLabel.text = self.Varietals;}
        else
        {
            cellVarietals.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
            self.Varietals = nil;
        }
        
        cellVarietals.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.VarietalsPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.VarietalsPickerIndexPath = nil;
    }
    if ([self hasInLineColorPicker])
    {
        
        XYZColorPickerTableCell *ColorPickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
        UITableViewCell *cellColor = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        
        if ((ColorPickerCell.Color)&&(![self.Color isEqualToString:ColorPickerCell.Color]))
        {
            self.Color = ColorPickerCell.Color;
        }
        
        if ((self.Color)&&(self.Color.length > 0))
        {cellColor.textLabel.text = self.Color;}
        else
        {
            cellColor.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
            self.Color = nil;
        }
        
        cellColor.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.ColorPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.ColorPickerIndexPath = nil;
    }
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = kDateYearRow; // indexPath.row;
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleDatePickerForSelectedIndexPath:indexPathToReveal];
        
        self.datePickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    if (PickerCell.Year.length > 0)
    {
        self.Year = PickerCell.Year;
        cellYear.textLabel.text = self.Year;
    
    }
    else
    {
        if ((self.Year)&&((PickerCell.Year.length != 0)||(!PickerCell.Year)))
        {
            cellYear.textLabel.text = self.Year;
        }
        else
        {
            NSDictionary *itemData = self.dataArray[1];
            cellYear.textLabel.text = [itemData valueForKey:kTitleKey];
            self.Year = nil;
        }
    }
    
    cellYear.textLabel.textColor = [UIColor blackColor];
    
    // always deselect the row containing the Wine Year date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    if (self.RegionReset)
    {
        [self.tableView beginUpdates];
        
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.RegionCellIndexPath.row+1 inSection:0]];
        cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
        self.RegionReset = NO;
        
        [self.tableView endUpdates];
    }

}


- (void)displayInlineCountryPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:indexPath];
    XYZCountryPickerTableCell *PickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
    
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = (self.CountryPickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        XYZYearPickerTableCell *YearPickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        UITableViewCell *cellYear = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        
        if ((YearPickerCell.Year)&&(![self.Year isEqualToString:YearPickerCell.Year]))
        {
            self.Year = YearPickerCell.Year;
        }
        
        if ((self.Year)&&(self.Year.length > 0))
        {cellYear.textLabel.text = self.Year;}
        else
        {
            cellYear.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
            self.Year = nil;
        }
        
        cellYear.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    if ([self hasInLineRegionPicker])
    {
        
        XYZRegionPickerTableCell *RegionPickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        
        if ((RegionPickerCell.Region)&&(![self.Region isEqualToString:RegionPickerCell.Region]))
        {
            self.Region = RegionPickerCell.Region;
        }
        
        if ((self.Region)&&(self.Region.length > 0))
        {cellRegion.textLabel.text = self.Region;}
        else
        {
            cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
            self.Region = nil;
        }
        
        if (self.Country == nil)
        {
            
            UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
            
            self.Country = [self GetCountryFromRegion:self.Region];
            
            cellCountry.textLabel.text = self.Country;
            
        }
        
        cellRegion.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.RegionPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.RegionPickerIndexPath = nil;
    }
    if ([self hasInLineVarietalsPicker])
    {
        
        XYZVarietalsPickerTableCell *VarietalsPickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
        UITableViewCell *cellVarietals = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        
        if ((VarietalsPickerCell.Varietals)&&(![self.Varietals isEqualToString:VarietalsPickerCell.Varietals]))
        {
            self.Varietals = VarietalsPickerCell.Varietals;
        }
        
        if ((self.Varietals)&&(self.Varietals.length > 0))
        {cellVarietals.textLabel.text = self.Varietals;}
        else
        {
            cellVarietals.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
            self.Varietals = nil;
        }
        
        cellVarietals.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.VarietalsPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.VarietalsPickerIndexPath = nil;
    }
    if ([self hasInLineColorPicker])
    {
        
        XYZColorPickerTableCell *ColorPickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
        UITableViewCell *cellColor = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        
        if ((ColorPickerCell.Color)&&(![self.Color isEqualToString:ColorPickerCell.Color]))
        {
            self.Color = ColorPickerCell.Color;
        }
        
        if ((self.Color)&&(self.Color.length > 0))
        {cellColor.textLabel.text = self.Color;}
        else
        {
            cellColor.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
            self.Color = nil;
        }
        
        cellColor.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.ColorPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.ColorPickerIndexPath = nil;
    }
    if ([self hasInLineCountryPicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.CountryPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.CountryPickerIndexPath = nil;
    }

    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = 2; // indexPath.row;
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleCountryPickerForSelectedIndexPath:indexPathToReveal];
        
        self.CountryPickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    
    if (PickerCell.Country.length > 0)
    {
        if (![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]])
        {
            self.Region = nil;
            self.RegionReset = YES;
        }
        
        self.Country = PickerCell.Country;
        cellCountry.textLabel.text = self.Country;
        
    }
    else
    {
        if ((self.Country)&&((PickerCell.Country.length != 0)||(!PickerCell.Country)))
        {
            cellCountry.textLabel.text = self.Country;
        }
        else
        {
            NSDictionary *itemData = self.dataArray[2];
            cellCountry.textLabel.text = [itemData valueForKey:kTitleKey];
            self.Country = nil;
        }
    }
    
    cellCountry.textLabel.textColor = [UIColor blackColor];
    
    // always deselect the row containing the Wine Year date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    if (self.RegionReset)
    {
        [self.tableView beginUpdates];
        
         UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
        self.RegionReset = NO;
        
        [self.tableView endUpdates];
    }
    
}

- (void)displayInlineRegionPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:indexPath];
    XYZRegionPickerTableCell *PickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
    
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = (self.RegionPickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        XYZYearPickerTableCell *YearPickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        UITableViewCell *cellYear = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        
        if ((YearPickerCell.Year)&&(![self.Year isEqualToString:YearPickerCell.Year]))
        {
            self.Year = YearPickerCell.Year;
        }
        
        if ((self.Year)&&(self.Year.length > 0))
        {cellYear.textLabel.text = self.Year;}
        else
        {
            cellYear.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
            self.Year = nil;
        }
        
        cellYear.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    if ([self hasInLineCountryPicker])
    {
        
        XYZCountryPickerTableCell *CountryPickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
        UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        
        if ((CountryPickerCell.Country)&&(![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]]))
        {
            self.Country = CountryPickerCell.Country;
            self.Region = nil;
            self.RegionReset = YES;
        }
        
        if ((self.Country)&&(self.Country.length > 0))
        {cellCountry.textLabel.text = self.Country;}
        else
        {
            cellCountry.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
            self.Country = nil;
        }
        
        cellCountry.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.CountryPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.CountryPickerIndexPath = nil;
    }
    if ([self hasInLineVarietalsPicker])
    {
        
        XYZVarietalsPickerTableCell *VarietalsPickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
        UITableViewCell *cellVarietals = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        
        if ((VarietalsPickerCell.Varietals)&&(![self.Varietals isEqualToString:VarietalsPickerCell.Varietals]))
        {
            self.Varietals = VarietalsPickerCell.Varietals;
        }
        
        if ((self.Varietals)&&(self.Varietals.length > 0))
        {cellVarietals.textLabel.text = self.Varietals;}
        else
        {
            cellVarietals.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
            self.Varietals = nil;
        }
        
        cellVarietals.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.VarietalsPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.VarietalsPickerIndexPath = nil;
    }
    if ([self hasInLineColorPicker])
    {
        
        XYZColorPickerTableCell *ColorPickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
        UITableViewCell *cellColor = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        
        if ((ColorPickerCell.Color)&&(![self.Color isEqualToString:ColorPickerCell.Color]))
        {
            self.Color = ColorPickerCell.Color;
        }
        
        if ((self.Color)&&(self.Color.length > 0))
        {cellColor.textLabel.text = self.Color;}
        else
        {
            cellColor.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
            self.Color=nil;
        }
        
        cellColor.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.ColorPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.ColorPickerIndexPath = nil;
    }
    if ([self hasInLineRegionPicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.RegionPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.RegionPickerIndexPath = nil;
    }
    
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = 3; // indexPath.row;
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleRegionPickerForSelectedIndexPath:indexPathToReveal];
        
        self.RegionPickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    
    if (PickerCell.Region.length > 0)
    {
        self.Region = PickerCell.Region;
        cellRegion.textLabel.text = self.Region;
        
    }
    else
    {
        if((self.Region)&&((PickerCell.Region.length != 0)||(!PickerCell.Region)))
        {
            cellRegion.textLabel.text = self.Region;
        }
        else
        {
            NSDictionary *itemData = self.dataArray[3];
            cellRegion.textLabel.text = [itemData valueForKey:kTitleKey];
            self.Region = nil;
        }
    }
    
    cellRegion.textLabel.textColor = [UIColor blackColor];
    
    if ((self.Country == nil)&&(self.Region != nil))
    {
        
        UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        
        self.Country = [self GetCountryFromRegion:self.Region];
        
        cellCountry.textLabel.text = self.Country;
        
    }
    
    // always deselect the row containing the Wine Year date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
}

- (void)displayInlineVarietalsPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellVarietals = [self.tableView cellForRowAtIndexPath:indexPath];
    XYZVarietalsPickerTableCell *PickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
    
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = (self.VarietalsPickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        XYZYearPickerTableCell *YearPickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        UITableViewCell *cellYear = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        
        if ((YearPickerCell.Year)&&(![self.Year isEqualToString:YearPickerCell.Year]))
        {
            self.Year = YearPickerCell.Year;
        }
        
        if ((self.Year)&&(self.Year.length > 0))
        {cellYear.textLabel.text = self.Year;}
        else
        {
            cellYear.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
            self.Year = nil;
        }
        
        cellYear.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    if ([self hasInLineCountryPicker])
    {
        
        XYZCountryPickerTableCell *CountryPickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
        UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        
        if ((CountryPickerCell.Country)&&(![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]]))
        {
            self.Country = CountryPickerCell.Country;
            self.Region = nil;
            self.RegionReset = YES;
        }
        
        if ((self.Country)&&(self.Country.length > 0))
        {cellCountry.textLabel.text = self.Country;}
        else
        {
            cellCountry.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
            self.Country = nil;
        }
        
        cellCountry.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.CountryPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.CountryPickerIndexPath = nil;
    }
    if ([self hasInLineRegionPicker])
    {
        
        XYZRegionPickerTableCell *RegionPickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        
        if ((RegionPickerCell.Region)&&(![self.Region isEqualToString:RegionPickerCell.Region]))
        {
            self.Region = RegionPickerCell.Region;
        }
        
        if ((self.Region)&&(self.Region.length > 0))
        {cellRegion.textLabel.text = self.Region;}
        else
        {
            cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
            self.Region = nil;
        }
        
        if (self.Country == nil)
        {
            
            UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
            
            self.Country = [self GetCountryFromRegion:self.Region];
            
            cellCountry.textLabel.text = self.Country;
            
        }
        
        cellRegion.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.RegionPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.RegionPickerIndexPath = nil;
    }
    if ([self hasInLineColorPicker])
    {
        
        XYZColorPickerTableCell *ColorPickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
        UITableViewCell *cellColor = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        
        if ((ColorPickerCell.Color)&&(![self.Color isEqualToString:ColorPickerCell.Color]))
        {
            self.Color = ColorPickerCell.Color;
        }
        
        if ((self.Color)&&(self.Color.length > 0))
        {cellColor.textLabel.text = self.Color;}
        else
        {
            cellColor.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
            self.Color = nil;
        }
        
        cellColor.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.ColorPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.ColorPickerIndexPath = nil;
    }
    if ([self hasInLineVarietalsPicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.VarietalsPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.VarietalsPickerIndexPath = nil;
    }
    
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = 4; // indexPath.row;
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleVarietalsPickerForSelectedIndexPath:indexPathToReveal];
        
        self.VarietalsPickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    
    if (PickerCell.Varietals.length > 0)
    {
        self.Varietals = PickerCell.Varietals;
        cellVarietals.textLabel.text = self.Varietals;
        
    }
    else
    {
        if((self.Varietals)&&((PickerCell.Varietals.length !=0)||(!PickerCell.Varietals)))
        {
            cellVarietals.textLabel.text = self.Varietals;
        }
        else
        {
            NSDictionary *itemData = self.dataArray[4];
            cellVarietals.textLabel.text = [itemData valueForKey:kTitleKey];
            self.Varietals = nil;
        }
    }
    
    cellVarietals.textLabel.textColor = [UIColor blackColor];
    
    // always deselect the row containing the Wine Year date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    if (self.RegionReset)
    {
        [self.tableView beginUpdates];
        
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
        self.RegionReset = NO;
        
        [self.tableView endUpdates];
    }
    
}

- (void)displayInlineColorPickerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellColor = [self.tableView cellForRowAtIndexPath:indexPath];
    XYZColorPickerTableCell *PickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
    
    // display the date picker inline with the table content
    [self.tableView beginUpdates];
    
    BOOL sameCellClicked = (self.ColorPickerIndexPath.row - 1 == indexPath.row);
    
    // remove any date picker cell if it exists
    if ([self hasInlineDatePicker])
    {
        XYZYearPickerTableCell *YearPickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
        UITableViewCell *cellYear = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        
        if ((YearPickerCell.Year)&&(![self.Year isEqualToString:YearPickerCell.Year]))
        {
            self.Year = YearPickerCell.Year;
        }
        
        if ((self.Year)&&(self.Year.length > 0))
        {cellYear.textLabel.text = self.Year;}
        else
        {
            cellYear.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
            self.Year = nil;
        }
        
        cellYear.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datePickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.datePickerIndexPath = nil;
    }
    if ([self hasInLineCountryPicker])
    {
        
        XYZCountryPickerTableCell *CountryPickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
        UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        
        if ((CountryPickerCell.Country)&&(![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]]))
        {
            self.Country = CountryPickerCell.Country;
            self.Region = nil;
            self.RegionReset = YES;
        }
        
        if ((self.Country)&&(self.Country.length > 0))
        {cellCountry.textLabel.text = self.Country;}
        else
        {
            cellCountry.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
            self.Country = nil;
        }
        
        cellCountry.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.CountryPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.CountryPickerIndexPath = nil;
    }
    if ([self hasInLineRegionPicker])
    {
        
        XYZRegionPickerTableCell *RegionPickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        
        
        if ((RegionPickerCell.Region)&&(![self.Region isEqualToString:RegionPickerCell.Region]))
        {
            self.Region = RegionPickerCell.Region;
        }
        
        if ((self.Region)&&(self.Region.length > 0))
        {cellRegion.textLabel.text = self.Region;}
        else
        {
            cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
            self.Region = nil;
        }
        
        cellRegion.textLabel.textColor = [UIColor blackColor];
        
        if (self.Country == nil)
        {
            
            UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
            
            self.Country = [self GetCountryFromRegion:self.Region];
            
            cellCountry.textLabel.text = self.Country;
        }
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.RegionPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.RegionPickerIndexPath = nil;
    }
    if ([self hasInLineVarietalsPicker])
    {
        
        XYZVarietalsPickerTableCell *VarietalsPickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
        UITableViewCell *cellVarietals = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        
        if ((VarietalsPickerCell.Varietals)&&(![self.Varietals isEqualToString:VarietalsPickerCell.Varietals]))
        {
            self.Varietals = VarietalsPickerCell.Varietals;
        }
        
        if ((self.Varietals)&&(self.Varietals.length > 0))
        {cellVarietals.textLabel.text = self.Varietals;}
        else
        {
            cellVarietals.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
            self.Varietals = nil;
        }
        
        cellVarietals.textLabel.textColor = [UIColor blackColor];
        
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.VarietalsPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.VarietalsPickerIndexPath = nil;
    }
    if ([self hasInLineColorPicker])
    {
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.ColorPickerIndexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        self.ColorPickerIndexPath = nil;
    }
    
    
    if (!sameCellClicked)
    {
        // hide the old date picker and display the new one
        NSInteger rowToReveal = 5; // indexPath.row;
        NSIndexPath *indexPathToReveal = [NSIndexPath indexPathForRow:rowToReveal inSection:0];
        
        [self toggleColorPickerForSelectedIndexPath:indexPathToReveal];
        
        self.ColorPickerIndexPath = [NSIndexPath indexPathForRow:indexPathToReveal.row + 1 inSection:0];
    }
    
    
    if (PickerCell.Color.length > 0)
    {
        self.Color = PickerCell.Color;
        cellColor.textLabel.text = self.Color;
        
    }
    else
    {
        if((self.Color)&&((PickerCell.Color.length != 0)||(!PickerCell.Color)))
        {
            cellColor.textLabel.text = self.Color;
        }
        else
        {
            NSDictionary *itemData = self.dataArray[5];
            cellColor.textLabel.text = [itemData valueForKey:kTitleKey];
            self.Color = nil;
        }
    }
    
    cellColor.textLabel.textColor = [UIColor blackColor];
    
    // always deselect the row containing the Wine Year date
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView endUpdates];
    
    if (self.RegionReset)
    {
        [self.tableView beginUpdates];
        
        UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
        self.RegionReset = NO;
        
        [self.tableView endUpdates];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    XYZAddNewTasteWineNameTableCell *NameCell = (XYZAddNewTasteWineNameTableCell *)[self.tableView cellForRowAtIndexPath:self.NameCellIndexPath];
    
    NameCell.NameEntry.delegate = self;
    
    [NameCell.NameEntry setUserInteractionEnabled:NO];
    
    if (cell.reuseIdentifier != kWineNameCellID)
    {
        if ([self.Name isEqualToString:[self.dataArray[0] valueForKey:kTitleKey]])
        {
            
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
                [self.view endEditing:YES];
                [self.doneButton setTitle:@"Done"];
                [self.doneButton setEnabled:YES];
            }
            else
            {
                [self.view endEditing:YES];
                [self.doneButton setEnabled:NO];
            }
            
        }
        else
        {
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
                [self.view endEditing:YES];
                [self.doneButton setTitle:@"Done"];
                [self.doneButton setEnabled:YES];
            }
            else
            {
                //Wine name has been reset to empty
                self.Name = [self.dataArray[0] valueForKey:kTitleKey];
                [self.view endEditing:YES];
                [self.doneButton setEnabled:NO];
            }
        }
        
    }
    
    if(cell.reuseIdentifier == kWineNameCellID)
    {
        [NameCell.NameEntry setUserInteractionEnabled:YES];
        [NameCell.NameEntry becomeFirstResponder];
    }

    
    if (cell.reuseIdentifier == kDateCellID)
    {
        [self displayInlineDatePickerForRowAtIndexPath:indexPath];
    }
    else if (cell.reuseIdentifier == kWineCountryCellID)
    {
        [self displayInlineCountryPickerForRowAtIndexPath:indexPath];
    }
    else if (cell.reuseIdentifier == kWineRegionCellID)
    {
        [self displayInlineRegionPickerForRowAtIndexPath:indexPath];
    }
    else if (cell.reuseIdentifier == kWineVarietalsCellID)
    {
        [self displayInlineVarietalsPickerForRowAtIndexPath:indexPath];
    }
    else if (cell.reuseIdentifier == kWineColorCellID)
    {
        [self displayInlineColorPickerForRowAtIndexPath:indexPath];
    }
    else
    {
        UITableViewCell *Yearcell = [tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        UITableViewCell *Countrycell = [tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        UITableViewCell *Regioncell = [tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        UITableViewCell *Varietalscell = [tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        UITableViewCell *Colorcell = [tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        
        [self.tableView beginUpdates];
        
        if ([self hasInlineDatePicker])
        {
            XYZYearPickerTableCell *PickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
            
            if ((PickerCell.Year)&&(![self.Year isEqualToString:PickerCell.Year]))
            {
                self.Year = PickerCell.Year;
            }
                
            if ((self.Year)&&(self.Year.length > 0))
            {Yearcell.textLabel.text = self.Year;}
            else
            {
                Yearcell.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
                self.Year = nil;
            }
            
            Yearcell.textLabel.textColor = [UIColor blackColor];
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kDatePickerRowWhenDisplayed inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
            self.datePickerIndexPath = nil;
        }
        
        if ([self hasInLineCountryPicker])
        {
            XYZCountryPickerTableCell *PickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
            
            if ((PickerCell.Country)&&(![self.Country isEqualToString:[self GetCountryFromRegion:self.Region]]))
            {
                self.Country = PickerCell.Country;
                self.Region = nil;
                self.RegionReset = YES;
            }
            
            if ((self.Country)&&(self.Country.length > 0))
            {Countrycell.textLabel.text = self.Country;}
            else
            {
                Countrycell.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
                self.Country = nil;
            }
            
            Countrycell.textLabel.textColor = [UIColor blackColor];
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kCountryPickerRowWhenDisplayed inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
            self.CountryPickerIndexPath = nil;
        }
        if ([self hasInLineRegionPicker])
        {
            XYZRegionPickerTableCell *PickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
            
            if ((PickerCell.Region)&&(![self.Region isEqualToString:PickerCell.Region]))
            {
                self.Region = PickerCell.Region;
            }
            
            if ((self.Region)&&(self.Region.length > 0))
            {Regioncell.textLabel.text = self.Region;}
            else
            {
                Regioncell.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
                self.Region = nil;
            }
            
            Regioncell.textLabel.textColor = [UIColor blackColor];
            
            if (self.Country == nil)
            {
                
                UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
                
                self.Country = [self GetCountryFromRegion:self.Region];
                
                cellCountry.textLabel.text = self.Country;
                
            }
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kRegionPickerRowWhenDiplayed inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
            self.RegionPickerIndexPath = nil;
        }
        
        if ([self hasInLineVarietalsPicker])
        {
            XYZVarietalsPickerTableCell *PickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
            
            if ((PickerCell.Varietals)&&(![self.Varietals isEqualToString:PickerCell.Varietals]))
            {
                self.Varietals = PickerCell.Varietals;
            }
            
            if ((self.Varietals)&&(self.Varietals.length > 0))
            {Varietalscell.textLabel.text = self.Varietals;}
            else
            {
                Varietalscell.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
                self.Varietals = nil;
            }
            
            Varietalscell.textLabel.textColor = [UIColor blackColor];
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kVarietalsPickerRowWhenDiplayed inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
            self.VarietalsPickerIndexPath = nil;
        }
        if ([self hasInLineColorPicker])
        {
            XYZColorPickerTableCell *PickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
            
            if ((PickerCell.Color)&&(![self.Color isEqualToString:PickerCell.Color]))
            {
                self.Color = PickerCell.Color;
            }
            
            if ((self.Color)&&(self.Color.length > 0))
            {Colorcell.textLabel.text = self.Color;}
            else
            {
                Colorcell.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
                self.Color = nil;
            }
            
            Colorcell.textLabel.textColor = [UIColor blackColor];
            
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:kColorPickerRowWhenDiplayed inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
            self.ColorPickerIndexPath = nil;
        }
        if ([self.Name isEqualToString:[self.dataArray[0] valueForKey:kTitleKey]])
        {
            
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
            }
        }
        else
        {
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
            }
            else
            {
                //Wine name has been reset to empty
                self.Name = [self.dataArray[0] valueForKey:kTitleKey];
            }
        }
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.tableView endUpdates];
        
        if (self.RegionReset)
        {
            [self.tableView beginUpdates];
            
            UITableViewCell *cellRegion = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
            cellRegion.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
            self.RegionReset = NO;
            
            [self.tableView endUpdates];
        }
    }
    
}

#pragma mark - Delegates

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *) string
{
    XYZAddNewTasteWineNameTableCell *NameCell = (XYZAddNewTasteWineNameTableCell *)[self.tableView cellForRowAtIndexPath:self.NameCellIndexPath];
    NSUInteger length = NameCell.NameEntry.text.length - range.length + string.length;
    if (length >0)
    {
        self.doneButton.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
    }
    return YES;
}

- (void)YearPicker:(XYZYearPicker *)picker didSelectYear:(NSString *)Year
{
    UITableViewCell *Yearcell = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
    XYZYearPickerTableCell *PickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
    
    self.Year = PickerCell.yearPicker.selectedYear;
    PickerCell.Year = self.Year;
    if ([self.Year isEqualToString:@""])
    {
        Yearcell.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
        Yearcell.textLabel.textColor = [UIColor blackColor];
    }
    else
    {
        Yearcell.textLabel.text = self.Year;
        Yearcell.textLabel.textColor = self.doneButton.tintColor;
    }
}

- (void)ColorPicker:(XYZColorPicker *)picker didSelectColorWithName:(NSString *)name
{
    UITableViewCell *Colorcell = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
    XYZColorPickerTableCell *PickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
    
    self.Color = PickerCell.ColorPicker.selectedColorName;
    PickerCell.Color = self.Color;
    
    if ([self.Color isEqualToString:@""])
    {
        Colorcell.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
        Colorcell.textLabel.textColor = [UIColor blackColor];
    }
    else
    {
        Colorcell.textLabel.text = self.Color;
        Colorcell.textLabel.textColor = self.doneButton.tintColor;
    }

}

- (void)VarietalsPicker:(XYZVarietalsPicker *)picker didSelectVarietalsWithName:(NSString *)name
{
    UITableViewCell *Varietalscell = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
    XYZVarietalsPickerTableCell *PickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
    
    self.Varietals = PickerCell.VarietalsPicker.selectedVarietalsName;
    PickerCell.Varietals = self.Varietals;
    
    if ([self.Varietals isEqualToString:@""])
    {
        Varietalscell.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
        Varietalscell.textLabel.textColor = [UIColor blackColor];
    }
    else
    {
        Varietalscell.textLabel.text = self.Varietals;
        Varietalscell.textLabel.textColor = self.doneButton.tintColor;
    }

}

- (void)countryPicker:(XYZCountryPicker *)picker didSelectCountryWithName:(NSString *)name
{
    UITableViewCell *Countrycell = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
    XYZCountryPickerTableCell *PickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
    
    self.Country = PickerCell.CountryPicker.selectedCountryName;
    PickerCell.Country = self.Country;
    
    if ([self.Country isEqualToString:@""])
    {
        Countrycell.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
        Countrycell.textLabel.textColor = [UIColor blackColor];
    }
    else
    {
        Countrycell.textLabel.text = self.Country;
        Countrycell.textLabel.textColor = self.doneButton.tintColor;
    }
}

- (void)regionPicker:(XYZRegionPicker *)picker didSelectRegionWithName:(NSString *)name
{
    UITableViewCell *Regioncell = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
    XYZRegionPickerTableCell *PickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
    
    self.Region = name;
    PickerCell.Region = self.Region;
    
    if ([self.Region isEqualToString:@""])
    {
        Regioncell.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
        Regioncell.textLabel.textColor = [UIColor blackColor];
    }
    else
    {
        Regioncell.textLabel.text = self.Region;
        Regioncell.textLabel.textColor = self.doneButton.tintColor;
    }
}

#pragma mark - Navigation

- (IBAction)unwindToTaste:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)unwindToTasteAddingInfo:(UIStoryboardSegue *)segue
{
    XYZAddTasteInfoViewController *source = [segue sourceViewController];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.TasteInfoCellIndexPath];
    [self.tableView beginUpdates];
        self.TasteInfo = [source.SelectedTasteInfo copy];
        if (self.TasteInfo !=nil)
        {
            NSArray *CellLines = [self CalculateTasteInfoLines];
            cell.textLabel.text = CellLines[0];
            cell.detailTextLabel.text = CellLines[1];
        }
        else
        {
            cell.textLabel.text = [self.dataArray valueForKey:kTitleKey];
            cell.detailTextLabel.text = @"Select to precise your taste";
        }
    [self.tableView endUpdates];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //if (sender != self.doneButton) return;
    if (sender == self.doneButton)
    {
        UITableViewCell *Yearcell = [self.tableView cellForRowAtIndexPath:self.YearCellIndexPath];
        UITableViewCell *Countrycell = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
        UITableViewCell *Regioncell = [self.tableView cellForRowAtIndexPath:self.RegionCellIndexPath];
        UITableViewCell *Varietalscell = [self.tableView cellForRowAtIndexPath:self.VarietalsCellIndexPath];
        UITableViewCell *Colorcell = [self.tableView cellForRowAtIndexPath:self.ColorCellIndexPath];
        XYZAddNewTasteWineNameTableCell *NameCell = (XYZAddNewTasteWineNameTableCell *)[self.tableView cellForRowAtIndexPath:self.NameCellIndexPath];
        
        if ([self hasInlineDatePicker])
        {
            XYZYearPickerTableCell *PickerCell = (XYZYearPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.datePickerIndexPath];
            
            if ((PickerCell.Year)&&(![self.Year isEqualToString:PickerCell.Year]))
            {
                self.Year = PickerCell.Year;
            }
            
            if ((self.Year)&&(self.Year.length > 0))
            {Yearcell.textLabel.text = self.Year;}
            else
            {
                Yearcell.textLabel.text = [self.dataArray[1] valueForKey:kTitleKey];
                self.Year = nil;
            }
            
            self.datePickerIndexPath = nil;
        }
        
        if ([self hasInLineCountryPicker])
        {
            XYZCountryPickerTableCell *PickerCell = (XYZCountryPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.CountryPickerIndexPath];
            
            if ((PickerCell.Country)&&(![self.Country isEqualToString:PickerCell.Country]))
            {
                self.Country = PickerCell.Country;
                self.Region = nil;
            }
            
            if ((self.Country)&&(self.Country.length > 0))
            {Countrycell.textLabel.text = self.Country;}
            else
            {
                Countrycell.textLabel.text = [self.dataArray[2] valueForKey:kTitleKey];
                self.Country = nil;
            }

            self.CountryPickerIndexPath = nil;
        }
        if ([self hasInLineRegionPicker])
        {
            XYZRegionPickerTableCell *PickerCell = (XYZRegionPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.RegionPickerIndexPath];
            
            if ((PickerCell.Region)&&(![self.Region isEqualToString:PickerCell.Region]))
            {
                self.Region = PickerCell.Region;
            }
            
            if ((self.Region)&&(self.Region.length > 0))
            {Regioncell.textLabel.text = self.Region;}
            else
            {
                Regioncell.textLabel.text = [self.dataArray[3] valueForKey:kTitleKey];
                self.Region = nil;
            }
            
            if (self.Country == nil)
            {
                
                UITableViewCell *cellCountry = [self.tableView cellForRowAtIndexPath:self.CountryCellIndexPath];
                
                self.Country = [self GetCountryFromRegion:self.Region];
                
                cellCountry.textLabel.text = self.Country;
                
            }
            
            self.RegionPickerIndexPath = nil;
        }
        
        if ([self hasInLineVarietalsPicker])
        {
            XYZVarietalsPickerTableCell *PickerCell = (XYZVarietalsPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.VarietalsPickerIndexPath];
            
            if ((PickerCell.Varietals)&&(![self.Varietals isEqualToString:PickerCell.Varietals]))
            {
                self.Varietals = PickerCell.Varietals;
            }
            
            if ((self.Varietals)&&(self.Varietals.length > 0))
            {Varietalscell.textLabel.text = self.Varietals;}
            else
            {
                Varietalscell.textLabel.text = [self.dataArray[4] valueForKey:kTitleKey];
                self.Varietals = nil;
            }
            
            self.VarietalsPickerIndexPath = nil;
        }
        if ([self hasInLineColorPicker])
        {
            XYZColorPickerTableCell *PickerCell = (XYZColorPickerTableCell *)[self.tableView cellForRowAtIndexPath:self.ColorPickerIndexPath];
            
            if ((PickerCell.Color)&&(![self.Color isEqualToString:PickerCell.Color]))
            {
                self.Color = PickerCell.Color;
            }
            
            if ((self.Color)&&(self.Color.length > 0))
            {Colorcell.textLabel.text = self.Color;}
            else
            {
                Colorcell.textLabel.text = [self.dataArray[5] valueForKey:kTitleKey];
                self.Color = nil;
            }
            
            self.ColorPickerIndexPath = nil;
        }
        
        self.Name = NameCell.NameEntry.text;

        
        self.NewTaste = [[XYZWine alloc] init];
    
        if (self.Name.length > 0) {
            self.NewTaste.Name = self.Name;
        }
        self.NewTaste.Year = self.Year;
        self.NewTaste.Country = self.Country;
        self.NewTaste.AOC = self.Region;
        self.NewTaste.Varietal = self.Varietals;
        self.NewTaste.Color = self.Color;
        if (self.TasteInfo)
        {
            self.NewTaste.TasteInfo = [[NSMutableArray alloc] init];
            [self.NewTaste.TasteInfo setArray:self.TasteInfo];
        }
    }
    
    if ([segue.identifier isEqualToString:@"TasteInfoUpdate"])
    {
        XYZAddTasteInfoViewController *source = (XYZAddTasteInfoViewController *) segue.destinationViewController;
        XYZAddNewTasteWineNameTableCell *NameCell = (XYZAddNewTasteWineNameTableCell *)[self.tableView cellForRowAtIndexPath:self.NameCellIndexPath];
        
        if ([self.Name isEqualToString:[self.dataArray[0] valueForKey:kTitleKey]])
        {
            
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
                [self.view endEditing:YES];
                [self.doneButton setTitle:@"Done"];
                [self.doneButton setEnabled:YES];
            }
            else
            {
                [self.view endEditing:YES];
                [self.doneButton setEnabled:NO];
            }
            
        }
        else
        {
            if (NameCell.NameEntry.text.length > 0) {
                self.Name = NameCell.NameEntry.text;
                [self.view endEditing:YES];
                [self.doneButton setTitle:@"Done"];
                [self.doneButton setEnabled:YES];
            }
            else
            {
                //Wine name as be reset to empty
                self.Name = [self.dataArray[0] valueForKey:kTitleKey];
                [self.view endEditing:YES];
                [self.doneButton setEnabled:NO];
            }
        }
        
        if (self.TasteInfo)
        {
            source.SelectedTasteInfo = [self.TasteInfo copy];
        }
    }
    
}


@end
