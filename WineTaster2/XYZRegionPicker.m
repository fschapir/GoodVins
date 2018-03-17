//
//  XYZRegionPicker.m
//  WineTaster2
//
//  Created by François Schapiro on 14/12/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZRegionPicker.h"

@interface XYZRegionPicker()

@property NSString *Country;

@end

@implementation XYZRegionPicker

@synthesize Regiondelegate;

- (NSArray *)RegionNames:(NSString *) Country
{
    NSMutableArray *_RegionNames = nil;
    int i = 0;
    NSMutableArray *RegionsByCountry = [NSMutableArray arrayWithObjects:@[@"Algeria",@[@"Mascara",@"Tlemcen",@"D'hara",@"Aïn Bessem Bouira",@"Medea",@"Zaccar",@"Tessalah"]],
                                        @[@"Cape Verde",@[@"Chã das Caldeiras"]],
                                        @[@"Morocco",@[@"Atlas Mountains"]],
                                        @[@"South Africa",@[@"Elim",@"Stellenbosch",@"Paarl",@"Franschhoek",@"Constantia",@"Robertson",@"Swartland",@"Durbanville",@"Olifants River",@"Piketberg", @"Elgin",@"Breede River Valley",@"Klein Karoo",@"Orange River Valley",@"Tulbagh",@"Overberg",@"KwaZulu-Natal"]],
                                        @[@"Tunisia",@[@"Grand Cru Mornag",@"Mornag",@"Thibar",@"Coteaux d'Utique",@"Tébourba",@"Sidi Salem",@"Kélibia"]],
                                        @[@"Argentina",@[@"Mendoza",@"San Juan",@"Médanos",@"Buenos Aires",@"Río Negro",@"Neuquén",@"Salta",@"La Rioja",@"Catamarca",@"La Pampa",@"Tucumán"]],
                                        @[@"Bolivia",@[@"Tarija Department"]],
                                        @[@"Brazil",@[@"Rio Grande do Sul",@"Bento Gonçalves",@"Caxias do Sul",@"Garibaldi",@"Cotiporã",@"Paraná",@"Marialva",@"Maringá",@"Rosário do Avaí",@"Bandeirantes",@"Santa Catarina",@"São Joaquim",@"Pinheiro Preto",@"Tangará",@"Mato Grosso",@"Nova Mutum",@"Minas Gerais",@"Pirapora",@"Andradas",@"Caldas",@"Santa Rita de Caldas",@"Bahia",@"Juazeiro",@"Curaçá",@"Irecê",@"Pernambuco ",@"Petrolina",@"Casa Nova",@"Santa Maria da Boa Vista",@"São Paulo",@"Jundiaí",@"São Roque"]],
                                        @[@"Canada",@[@"British Columbia",@"Fraser Valley",@"Gulf Islands",@"Okanagan Valley",@"Similkameen Valley",@"Vancouver Island",@"Nova Scotia",@"Annapolis Valley",@"Ontario",@"Niagara Peninsula",@"Lake Erie North Shore and Pelee Island",@"Prince Edward County",@"Toronto",@"Quebec",@"Eastern Townships"]],
                                        @[@"Chile",@[@"Aconcagua Valley",@"Casablanca Valley",@"Atacama",@"Copiapó Valley",@"Huasco Valley",@"Central Valley",@"Cachapoal Valley",@"Maipo Valley",@"Mataquito Valley",@"Maule Valley",@"Coquimbo",@"Choapa Valley",@"Elqui Valley",@"Limarí",@"Pica",@"Zona Sur",@"Bío-Bío Valley",@"Itata Valley",@"Malleco Valley"]],
                                        @[@"Mexico",@[@"Aguascalientes Valley",@"Baja California",@"Valle de Guadalupe",@"Valle de Calafia",@"Valle de Mexicali",@"Valle de San Vicente",@"Valle de Santo Tomás",@"Zona Tecate",@"Coahuila",@"Durango",@"La Laguna",@"Valle de Parras",@"San Miguel de Allende",@"Dolores Hidalgo",@"Hidalgo",@"Guanajuato",@"Nuevo León",@"Valle de Las Maravillas",@"Querétaro",@"Valle de Tequisquiapan",@"Sonora",@"Caborca",@"Hermosillo",@"Zacatecas",@"Valle de las Arcinas"]],
                                        @[@"Peru",@[@"Huaral District",@"Cañete Province",@"Ica Region",@"Arequipa region"]],
                                        @[@"United States",@[@"Sonoita",@"Arkansas Mountain", @"Ozark Mountain", @"Altus",@"Central Coast",@"Ben Lomond Mountain", @"Arroyo Grande Valley",@"Arroyo Seco",@"Carmel Valley",@"Chalone",@"Cienega Valley",@"Edna Valley",@"Hames Valley",@"Happy Canyon of Santa Barbara",@"Lime Kiln Valley",@"Livermore Valley",@"Monterey",@"Mt. Harlan",@"Pacheco Pass",@"Paicines",@"Paso Robles",@"San Antonio Valley",@"San Benito",@"San Bernabe",@"San Francisco Bay",@"San Lucas",@"San Ysidro District",@"Santa Clara Valley",@"Santa Cruz Mountains",@"Santa Lucia Highlands",@"Santa Maria Valley",@"Sta. Rita Hills",@"Santa Ynez Valley",@"York Mountain",@"Alta Mesa",@"Borden Ranch",@"Capay Valley",@"Clarksburg",@"Clements Hills",@"Cosumnes River",@"Diablo Grande",@"Dunnigan Hills",@"Jahant",@"Lodi",@"Madera",@"Merritt Island",@"Mokelumne River",@"River Junction",@"Salado Creek",@"Sloughhouse",@"Tracy Hills",@"Seiad Valley",@"Trinity Lakes",@"Willow Creek",@"North Coast",@"Alexander Valley",@"Anderson Valley",@"Atlas Peak",@"Bennett Valley",@"Benmore Valley",@"Calistoga",@"Chalk Hill",@"Chiles Valley",@"Clear Lake",@"Cole Ranch",@"Coombsville",@"Covelo",@"Diamond Mountain District",@"Dos Rios",@"Dry Creek Valley",@"Fort Ross-Seaview",@"Green Valley of Russian River Valley",@"Guenoc Valley",@"High Valley",@"Howell Mountain",@"Knights Valley",@"Los Carneros",@"McDowell Valley",@"Mendocino",@"Mendocino Ridge",@"Mt. Veeder",@"Napa Valley",@"Northern Sonoma",@"Oak Knoll District of Napa Valley",@"Oakville",@"Pine Mountain-Cloverdale",@"Potter Valley",@"Red Hills Lake County",@"Redwood Valley",@"Rockpile",@"Russian River Valley",@"Rutherford",@"Solano County Green Valley",@"Sonoma Coast",@"Sonoma Mountain",@"Sonoma Valley",@"Spring Mountain District",@"St. Helena",@"Stags Leap District",@"Suisun Valley",@"Wild Horse Valley",@"Yorkville Highlands",@"Yountville",@"California Shenandoah Valley",@"El Dorado",@"Fair Play",@"Fiddletown",@"North Yuba",@"Sierra Foothills",@"Antelope Valley of the California High Desert",@"Cucamonga Valley",@"Leona Valley",@"Malibu-Newton Canyon",@"Ramona Valley",@"Saddle Rock-Malibu",@"San Pasqual Valley",@"Sierra Pelona Valley",@"South Coast",@"Temecula Valley",@"West Elks",@"Grand Valley",@"Southeastern New England",@"Western Connecticut Highlands",@"Snake River Valley",@"Shawnee Hills",@"Upper Mississippi River Valley",
                                            @"Ohio River Valley",@"Mississippi Delta",@"Catoctin",@"Cumberland Valley",@"Linganore",@"Martha's Vineyard",@"Fennville",@"Lake Michigan Shore",@"Leelanau Peninsula",@"Old Mission Peninsula",@"Alexandria Lakes",@"Augusta",@"Hermann",@"Ozark Highlands",@"Central Delaware Valley",@"Outer Coastal Plain",@"Warren Hills",@"Mesilla Valley",@"Middle Rio Grande Valley",@"Mimbres Valley",@"Cayuga Lake",@"Finger Lakes",@"Hudson River Region",@"Lake Erie",@"Long Island",@"Niagara Escarpment",@"North Fork of Long Island",@"Seneca Lake",@"The Hamptons, Long Island",@"Haw River Valley",@"Swan Creek",@"Yadkin Valley",@"Grand River Valley",@"Isle St. George",@"Loramie Creek",@"Applegate Valley",@"Chehalem Mountains",@"Columbia Gorge",@"Columbia Valley",@"Dundee Hills",@"Eola-Amity Hills",@"McMinnville",@"Red Hill Douglas County, Oregon",@"Ribbon Ridge",@"Rogue Valley",@"Southern Oregon",@"Umpqua Valley",@"Walla Walla Valley",@"Willamette Valley",@"Yamhill-Carlton District",@"Lancaster Valley",@"Lehigh Valley",@"Bell Mountain",@"Escondido Valley",@"Fredericksburg in the Texas Hill Country",@"Texas Davis Mountains",@"Texas High Plains",@"Texas Hill Country",@"Texoma",@"Middleburg",@"Monticello",@"North Fork of Roanoke",@"Northern Neck George Washington Birthplace",@"Rocky Knob",@"Shenandoah Valley",@"Virginia's Eastern Shore",@"Ancient Lakes",@"Horse Heaven Hills",@"Lake Chelan",@"Naches Heights",@"Puget Sound",@"Rattlesnake Hills",@"Red Mountain",@"Snipes Mountain",@"Wahluke Slope",@"Yakima Valley",@"Kanawha River Valley",@"Lake Wisconsin",@"Wisconsin Ledge"]],
                                        @[@"Uruguay",@[@"Dpto. Canelones"]],
                                        @[@"Venezuela",@[@"Carora",@"Lara State"]],
                                    @[@"Albania",@[@"Shkoder",@"Lezhë",@"Berat",@"Korça",@"Përmet",@"Leskovik",@"Tirana County"]],
                                        @[@"Austria",@[@"Burgenland",@"Wagram",@"Weinviertel",@"Wachau",@"Southern Styria",@"Vienna"]],
                                        @[@"Armenia",@[@"Areni",@"Ijevan",@"Ararat Valley"]],
                                        @[@"Azerbaijan",@[@"Ganja",@"Tovuz",@"Shamkir",@"Madrasa",@"Baku"]],
                                        @[@"Belgium",@[@"Hageland",@"Haspengouw",@"Heuvelland",@"Côtes de Sambre et Meuse"]],
                                        @[@"Bulgaria",@[@"Danubian Plain",@"Black Sea",@"Rose Valley",@"Thracian Lowland ",@"Struma River Valley"]],
                                        @[@"Croatia",@[@"Moslavina",@"Plešivica",@"Podunavlje",@"Pokuplje",@"Prigorje - Bilogora",@"Slavonija",@"Zagorje - Međimurje",@"Northern Dalmatia",@"Croatian Coast",@"Istra, Croatia",@"Northern Dalmatia",@"Dalmatian Interior"]],
                                        @[@"Cyprus",@[@"Commandaria"]],
                                        @[@"Czech Republic",@[@"Moravia",@"Mikulovska",@"Znojemská",@"Slovácko",@"Velkopavlovická",@"Bohemia",@"Litoměřická",@"Mělnická"]],
                                        @[@"Denmark",@[@"Jutland",@"Lolland",@"Funen",@"Northern Zealand"]],
                                        @[@"Georgia",@[@"Kakheti",@"Kartli",@"Imereti",@"Racha-Lechkhumi and Kvemo Svaneti",@"Abkhazia",@"Ajara"]],
                                        @[@"Germany",@[@"Ahr",@"Baden",@"Franconia",@"Hessische Bergstraße",@"Mittelrhein",@"Mosel",@"Nahe",@"Palatinate",@"Rheingau",@"Rheinhessen",@"Saale-Unstrut",@"Saxony",@"Württemberg"]],
                                        @[@"Greece",@[@"Aegean islands",@"Crete",@"Limnos",@"Paros",@"Rhodes",@"Samos",@"Santorini",@"Central Greece",@"Attica",@"Epirus",@"Zitsa",@"Thessaly",@"Rapsani",@"Ankhialos",@"Ionian Islands", @"Kefalonia",@"Macedonia",@"Amyntaion",@"Goumenissa",@"Naousa, Imathia",@"Peloponnesus",@"Mantineia",@"Nemea",@"Patras"]],
                                        @[@"Hungary",@[@"Balaton",@"Badacsony",@"Balatonboglár",@"Balaton-felvidék",@"Balatonfüred-Csopak",@"Nagy-Somló",@"Zala",@"Duna",@"Csongrád",@"Hajós-Baja",@"Kunság",@"Eger",@"Bükk",@"Mátra",@"Észak-Dunántúl",@"Neszmély",@"Etyek-Buda",@"Mór",@"Pannonhalma",@"Pannon",@"Pécs",@"Szekszárd",@"Tolna",@"Villány",@"Sopron",@"Tokaj, Hungary"]],
                                        @[@"Ireland",@[@"Cork"]],
                                        @[@"Latvia",@[@"Sabile"]],
                                        @[@"Luxembourg",@[@"Moselle Valley"]],
                                        @[@"Macedonia",@[@"Povardarie",@"Tikveš",@"Pcinja-Osogovo",@"Pelagonija-Polog"]],
                                        @[@"Moldova",@[@"Cricova",@"Bardar",@"Codri",@"Hînceşti",@"Purcari"]],
                                        @[@"Montenegro",@[@"Plantaže",@"Crmnica"]],
                                        @[@"Netherlands",@[@"Gelderland",@"Limburg",@"North Brabant",@"North Holland",@"Zeeland",@"Drenthe",@"Overijssel",@"Groningen"]],
                                        @[@"Poland",@[@"Warka",@"Zielona Góra"]],
                                        @[@"Portugal",@[@"Alenquer",@"Alentejo",@"Arruda",@"Bairrada",@"Beira Interior",@"Bucelas",@"Carcavelos",@"Colares",@"Dão",@"Douro",@"Encostas d'Aire",@"Lagoa",@"Lagos",@"Madeira",@"Madeirense",@"Óbidos",@"Palmela",@"Porto",@"Portimão",@"Tejo",@"Setúbal",@"Tavira",@"Távora-Varosa",@"Torres Vedras",@"Trás-os-Montes",@"Vinho Verde",@"Biscoitos",@"Graciosa",@"Lafões",@"Pico",@"Açores",@"Alentejano",@"Algarve",@"Beiras",@"Duriense",@"Lisboa",@"Minho", @"Península de Setúbal",@"Terras Madeirenses",@"Transmontano"]],
                                        @[@"Russia",@[@"Caucasus",@"Krasnodar",@"Stavropol",@"Dagestan",@"Rostov"]],
                                        @[@"Serbia",@[@"Timok",@"Nišava–South Morava",@"West Morava",@"Šumadija–Great Morava",@"Pocerina",@"Srem",@"Banat",@"Subotica–Horgoš"]],
                                        @[@"Kosovo",@[@"Kosovo"]],
                                        @[@"Slovakia",@[@"Malokarpatská",@"Južnoslovenská",@"Nitrianska",@"Stredoslovenská",@"Východoslovenská",@"Tokaj, Slovakia"]],
                                        @[@"Slovenia",@[@"Goriška Brda",@"Vipavska dolina",@"Kras",@"Istra, Slovenia",@"Bela krajina",@"Dolenjska",@"Bizeljsko",@"Štajerska",@"Prekmurje"]],
                                        @[@"Sweden",@[@"Gotland",@"Södermanland County",@"Scania"]],
                                        @[@"Switzerland",@[@"Geneva",@"Grisons",@"Neuchâtel",@"St. Gallen",@"Ticino",@"Valais",@"Vaud",@"Lavaux",@"La Côte",@"Zürich"]],
                                        @[@"Turkey",@[@"Cappadocia",@"Tokat",@"Central Anatolia",@"Ankara",@"İzmir",@"Aegean",@"Thracian",@"Marmara",@"Bozcaada",@"Bilecik",@"Southeastern Anatolia",@"Elazığ",@"Diyarbakır",@"Kırklareli",@"Çal",@"Denizli",@"Çanakkale",@"Eastern Aegean",@"Tekirdağ",@"Avşa Island"]],
                                        @[@"Ukraine",@[@"Carpathian Ruthenia",@"Odesa",@"Mykolaiv",@"Kherson",@"Crimea ",@"Balaklava",@"Zaporizhia"]],
                                        @[@"United Kingdom",@[@"Hampshire",@"Kent",@"Surrey",@"Sussex"]],
                                        @[@"China",@[@"Yantai-Penglai",@"Chang'an",@"Qiuci",@"Gaochang",@"Luoyang",@"Yantai, Shandong",@"Zhangjiakou, Hebei",@"Dalian, Liaoning",@"Tonghua, Jilin",@"Yibin, Sichuan"]],
                                        @[@"India",@[@"Bangalore, Karnataka",@"Nashik, Maharashtra",@"Sangli, Maharashtra",@"Narayangaon",@"Pune, Maharashtra",@"Bijapur, Karnataka"]],
                                        @[@"Indonesia",@[@"Bali"]],
                                        @[@"Iran",@[@"Shiraz",@"Quchan",@"Qazvin",@"Urmia",@"Malayer",@"Takestan"]],
                                        @[@"Israel",@[@"Bet Shemesh",@"Galilee",@"Golan Heights",@"Jerusalem",@"Judean Hills",@"Latrun",@"Mount Carmel",@"Rishon LeZion"]],
                                        @[@"Japan",@[@"Nagano",@"Yamanashi",@"Hokkaidō",@"Yamagata",@"Niigata",@"Shiga",@"Tochigi",@"Kyoto",@"Osaka",@"Hyōgo",@"Miyazaki"]],
                                        @[@"Kazakhstan",@[@"Issyk",@"Zailiyskiy"]],
                                        @[@"Republic of Korea",@[@"Anseong, Gyeonggi-do",@"Gimcheong, Gyeongsangbuk-do",@"Gyeongsan, Gyeongsangbuk-do",@"Yeongcheon, Gyeongsangbuk-do",@"Yeongdong, Chungcheongbuk-do"]],
                                        @[@"Lebanon",@[@"Bekaa Valley",@"Mount Lebanon",@"North Governorate",@"South Governorate"]],
                                        @[@"Burma",@[@"Shan State"]],
                                        @[@"Palestinian territories",@[@"Beit Jala",@"Hebron"]],
                                        @[@"Syria",@[@"Jabal el Druze",@"Homs District"]],
                                        @[@"Vietnam",@[@"Da Lat"]],
                                        @[@"New Zealand",@[@"Bay of Plenty",@"Central Otago",@"Canterbury",@"Waipara",@"Hawke's Bay",@"Gisborne",@"Marlborough",@"Nelson",@"Northland",@"Waikato",@"Wairarapa",@"Auckland",@"Waitaki"]],
                                        @[@"Australia",@[@"New South Wales",@"Big Rivers",@"Murray Darling",@"Perricoota",@"Riverina",@"Swan Hill",@"Central Ranges",@"Cowra",@"Mudgee",@"Orange",@"Hunter Region",@"Hunter wine region",@"Broke Fordwich",@"Northern Rivers",@"Hastings River",@"Northern Slopes",@"South Coast",@"Shoalhaven Coast",@"Southern Highlands",@"Southern New South Wales",@"Canberra District",@"Gundagai",@"Hilltops",@"Tumbarumba",@"Queensland",@"Granite Belt",@"South Burnett",@"South Australia",@"Barossa",@"Barossa Valley",@"Eden Valley",@"High Eden",@"Far North",@"Southern Flinders Ranges",@"Fleurieu",@"Currency Creek",@"Kangaroo Island",@"Langhorne Creek",@"McLaren Vale",@"Southern Fleurieu",@"Limestone Coast",@"Coonawarra",@"Mount Benson",@"Padthaway",@"Wrattonbully",@"Robe",@"Bordertown",@"Lower Murray",@"Riverland",@"Mount Lofty Ranges",@"Adelaide Hills",@"Lenswood",@"Piccadilly Valley",@"Adelaide Plains",@"Clare Valley",@"The Peninsulas",@"Tasmanian wine",@"North West",@"Tamar Valley",@"Pipers River",@"East Coast",@"Coal River",@"Derwent Valley",@"Southern",@"Victoria",@"Central Victoria",@"Bendigo",@"Goulburn Valley",@"Nagambie Lakes",@"Heathcote",@"Strathbogie Ranges",@"Upper Goulburn",@"Gippsland",@"North East Victoria",@"Alpine Valleys",@"Beechworth",@"Glenrowan",@"Rutherglen",@"North West Victoria",@"Murray Darling",@"Swan Hill",@"Port Phillip",@"Geelong",@"Macedon Ranges",@"Mornington Peninsula",@"Sunbury",@"Yarra Valley",@"Western Victoria",@"Grampians",@"Henty",@"Pyrenees",@"Western Australia",@"Greater Perth",@"Peel",@"Perth Hills",@"Swan Valley",@"South Western Australia",@"Blackwood Valley",@"Geographe",@"Great Southern",@"Albany",@"Denmark",@"Frankland River",@"Mount Barker",@"Porongurup",@"Manjimup",@"Margaret River",@"Pemberton"]],
                                        @[@"Italy",@[@"Albana di Romagna",@"Colli Bolognesi",@"Ramandolo",@"Colli Orientali del Friuli Picolit",@"Rosazzo",@"Franciacorta",@"Oltrepo Pavese Metodo Classico",@"Moscato di Scanzo",@"Sforzato di Valtellina",@"Valtellina Superiore",@"Asti",@"Barbaresco",@"Barbera d'Asti",@"Barbera d'Asti Nista",@"Barbera d'Asti Tinella",@"Barbera d'Asti Colli Astiani",@"Barbera del Monferrato Superiore",@"Barolo",@"Acqui",@"Dogliani",@"Ovada",@"Gattinara",@"Gavi",@"Ghemme",@"Roero",@"Caluso",@"Diano d'Alba",@"Ruché di Castagnole Monferrato",@"Alta Langa",@"Amarone della Valpolicella",@"Bardolino Superiore ",@"Colli di Conegliano",@"Colli Euganei Fior d'Arancio",@"Colli Asolani Prosecco",@"Conegliano Valdobbiadene",@"Lison-Pramaggiore",@"Malanotte Raboso Superiore",@"Montello",@"Recioto di Soave",@"Soave Superiore ",@"Recioto di Gambellara",@"Recioto della Valpolicella",@"Prosecco",@"Montepulciano d'Abruzzo",@"Cannellino di Frascati",@"Cesanese del Piglio",@"Frascati Superiore",@"Castelli di Jesi Verdicchio Riserva",@"Conero",@"Offida",@"Vernaccia di Serrapetrona",@"Verdicchio di Matelica Riserva",@"Brunello di Montalcino",@"Carmignano",@"Chianti",@"Chianti Classico",@"Chianti Colli Aretini",@"Chianti Colli Senesi ",@"Chianti Colli Fiorentini",@"Chianti Colline Pisane",@"Chianti Montalbano",@"Chianti Montespertoli",@"Chianti Rufina",@"Chianti Superiore",@"Montecucco",@"Morellino di Scansano",@"Suvereto",@"Val di Cornia",@"Vernaccia di San Gimignano",@"Vino Nobile di Montepulciano",@"Sagrantino di Montefalco",@"Torgiano Rosso Riserva",@"Aglianico del Vulture Superiore",@"Aglianico del Taburno",@"Fiano di Avellino",@"Greco di Tufo",@"Taurasi ",@"Castel del Monte Bombino Nero",@"Castel del Monte Nero di Troia Reserva",@"Castel del Monte Rosso Riserva",@"Primitivo di Manduria Dolce Naturale",@"Vermentino di Gallura",@"Cerasuolo di Vittoria",@"Abruzzo",@"Cerasuolo d'Abruzzo",@"Controguerra",@"Montepulciano d'Abruzzo",@"Terre Tollesi",@"Tullum",@"Trebbiano d'Abruzzo",@"Villamagna",@"Aglianico del Vulture",@"Matera",@"Terre dell'Alta Val d'Agri",@"Bivongi",@"Cirò",@"Donnici",@"Greco di Bianco",@"Lamezia",@"Melissa",@"Pollino",@"Sant'Anna di Isola Capo Rizzuto",@"San Vito di Luzzi",@"Savuto",@"Scavigna",@"Verbicaro",@"Aglianico del Taburno",@"Aversa Asprinio",@"Campi Flegrei",@"Capri",@"Castel San Lorenzo",@"Cilento",@"Costa d'Amalfi",@"Falerno del Massico",@"Falanghina del Sannio",@"Galluccio",@"Guardiolo",@"Irpina",@"Ischia",@"Penisola Sorrentina",@"Sannio",@"Sant'Agata dei Goti",@"Solopaca",@"Taburno",@"Vesuvio",@"Bosco Eliceo",@"Cagnina di Romagna",@"Colli Bolognesi",@"Colli Bolognesi Classico Pignoletto",@"Colli di Faenza",@"Colli di Imola",@"Colli di Parma",@"Colli di Rimini",@"Colli di Scandiano e di Canossa",@"Colli Piacentini",@"Colli Romagna Centrale",@"Gutturnio",@"Lambrusco di Sorbara",@"Lambrusco Grasparossa di Castelvetro",@"Lambrusco Salamino di Santacroce",@"Modena",@"Ortrugo",@"Pagadebit di Romagna",@"Reggiano",@"Reno",@"Romagna Albana Spumante",@"Sangiovese di Romagna",@"Trebbiano di Romagna",@"Carso",@"Colli Orientali del Friuli",@"Colli Orientali del Friuli Cialla",@"Colli Orientali del Friuli Rosazzo",@"Collio Goriziano",@"Friuli Annia",@"Friuli Aquileia",@"Friuli Grave",@"Friuli Isonzo",@"Friuli Latisana",@"Lison Pramaggiore",@"Aleatico di Gradoli",@"Aprilia",@"Atina",@"Bianco Capena",@"Castelli Romani",@"Cerveteri",@"Piglio",@"Cesanese di Affile",@"Cesanese di Olevano Romano",@"Circeo",@"Colli Albani",@"Colli della Sabina",@"Colli Etruschi Viterbesi",@"Colli Lanuvini",@"Cori",@"Est! Est!! Est!!! di Montefiascone",@"Frascati",@"Genazzano",@"Marino",@"Montecompatri Colonna",@"Nettuno",@"Orvieto",@"Roma",@"Tarquinia",@"Terracina",@"Velletri",@"Vignanello",@"Zagarolo",@"Cinque Terre",@"Cinque Terre Sciacchetrà",@"Colli di Luni",@"Colline di Levanto",@"Golfo del Tigullio",@"Riviera Ligure di Ponente",@"Rossese di Dolceacqua",@"Val Polcevera",@"Pornassio",@"Botticino",@"Bonarda dell'Otrepo Pavese",@"Buttafuoco dell'Oltrepo Pavese",@"Casteggio",@"Capriano del Colle",@"Cellatica",@"Garda",@"Garda Colli Mantovani",@"Lambrusco Mantovano",@"Lugana",@"Oltrepò Pavese",@"Riviera del Garda Bresciano",@"San Colombano al Lambro",@"San Martino della Battaglia",@"Scanzo",@"Terre di Franciacorta",@"Valcalepio",@"Valtellina Rosso",@"Valtenesi",@"Bianchello del Metauro",@"Colli Maceratesi",@"Colli Pesaresi",@"Esino",@"Falerio dei Colli Ascolani",@"Lacrima di Morro d'Alba",@"Offida",@"Pergola",@"Rosso Conero",@"Rosso Piceno",@"Verdicchio dei Castelli di Jesi",@"Verdicchio di Matelica",@"Biferno",@"Molise",@"Pentro di Isernia",@"Tintilia",@"Albugnano ",@"Alta Langa",@"Barbera d'Alba",@"Barbera d'Asti ",@"Barbera del Monferrato",@"Boca",@"Bramaterra ",@"Calosso",@"Canavese",@"Carema",@"Cisterna d'Asti",@"Colli Tortonesi",@"Collina Torinese",@"Colline Novaresi",@"Colline Saluzzesi",@"Cortese dell'Alto Monferrato",@"Coste della Sesia",@"Dolcetto d'Acqui",@"Dolcetto d'Alba",@"Dolcetto d'Asti",@"Dolcetto delle Langhe Monregalesi",@"Dolcetto di Diano d'Alba",@"Dolcetto di Dogliani",@"Dolcetto di Ovada",@"Erbaluce di Caluso",@"Fara",@"Freisa d'Asti",@"Freisa di Chieri",@"Gabiano",@"Grignolino d'Asti",@"Grignolino del Monferrato Casalese",@"Langhe",@"Lessona",@"Loazzolo",@"Malvasia di Casorzo d'Asti",@"Malvasia di Castelnuovo Don Bosco",@"Monferrato",@"Nebbiolo d'Alba",@"Piemonte",@"Pinerolese",@"Rubino di Cantavenna",@"Ruché di Castagnole Monferrato",@"Sizzano",@"Valsusa",@"Verduno Pelaverga",@"Aleatico di Puglia",@"Alezio",@"Barletta",@"Brindisi",@"Cacc'e mmitte di Lucera",@"Castel del Monte",@"Colline Joniche Taratine",@"Copertino",@"Galatina",@"Gioia del Colle",@"Gravina",@"Leverano",@"Lizzano",@"Locorotondo",@"Martina",@"Matino",@"Moscato di Trani",@"Nardò",@"Negroamaro di Terra d'Otranto",@"Orta Nova",@"Ostuni",@"Primitivo di Manduria",@"Rosso Barletta ",@"Rosso Canosa",@"Rosso di Cerignola",@"Salice Salentino",@"San Severo",@"Squinzano",@"Tavoliere delle Puglie",@"Terra d'Otranto",@"Alghero",@"Arborea",@"Campidano di Terralba",@"Cannonau di Sardegna",@"Carignano del Sulcis",@"Girò di Cagliari",@"Malvasia di Bosa",@"Malvasia di Cagliari",@"Mandrolisai",@"Monica di Cagliari",@"Monica di Sardegna",@"Moscato di Cagliari",@"Moscato di Sardegna",@"Moscato di Sorso Sennori",@"Nasco di Cagliari",@"Nuragus di Cagliari",@"Sardegna Semidano",@"Vermentino di Sardegna",@"Vernaccia di Oristano",@"Alcamo",@"Contea di Sclafani",@"Contessa Entellina",@"Delia Nivolelli Nero d'Avola",@"Eloro",@"Erice",@"Etna",@"Faro",@"Malvasia delle Lipari",@"Mamertino di Milazzo",@"Marsala",@"Menfi",@"Monreale",@"Noto",@"Moscato di Pantelleria",@"Moscato di Siracusa",@"Riesi",@"Salaparuta",@"Sambuca di Sicilia",@"Santa Margherita di Belice",@"Sciacca",@"Siracusa",@"Vittoria",@"Ansonica Costa dell'Argentario",@"Barco Reale di Carmignano",@"Bianco della Valdinievole",@"Bianco dell'Empolese",@"Bianco di Pitigliano",@"Bianco Pisano di San Torpè",@"Bianco Vergine della Valdichiana",@"Bolgheri",@"Candia dei Colli Apuani",@"Capalbio",@"Colli dell'Etruria Centrale",@"Colli di Luni",@"Colline Lucchesi",@"Cortona",@"Elba",@"Maremma Toscana",@"Montecarlo",@"Montecucco",@"Monteregio di Massa Marittima",@"Montescudaio",@"Moscadello di Montalcino",@"Orcia",@"Parrina",@"Pomino",@"Rosso di Montalcino",@"Rosso di Montepulciano",@"San Gimignano",@"Sant'Antimo",@"Sovana",@"Val d'Arbia",@"Vin Santo del Chianti",@"Vin Santo del Chianti Classico",@"Vin Santo di Montepulciano",@"Südtirol",@"Kalterersee",@"Valdadige",@"Santa Maddalena",@"Casteller",@"Teroldego Rotaliano",@"Trentino",@"Trento",@"Lago di Caldaro",@"Valdadige",@"Amelia",@"Assisi",@"Colli Altotiberini",@"Colli Amerini",@"Colli del Trasimeno",@"Colli Martani",@"Colli Perugini",@"Lago di Corbara",@"Montefalco",@"Orvieto",@"Rosso Orvietano",@"Spoleto",@"Todi",@"Torgiano",@"Valle d'Aosta",@"Arcole",@"Bagnoli di Sopra",@"Bardolino",@"Bianco di Custoza",@"Breganze",@"Colli Berici",@"Colli di Conegliano",@"Colli Euganei",@"Corti Benedettine del Padovano",@"Gambellara",@"Garda",@"Lison Pramaggiore",@"Lugana",@"Merlara",@"Montello e Colli Asolani",@"Monti Lessini",@"Piave",@"Prosecco",@"Riviera del Brenta",@"San Martino della Battaglia",@"Soave",@"Valdadige",@"Valpolicella",@"Valpolicella Ripasso",@"Venezia",@"Vicenza",@"Vin Santo di Gambellara"]],
                                        @[@"Romania",@[@"Moldavia",@"Muntenia",@"Oltenia",@"Transylvania",@"Crişana",@"Banat",@"Dobrogea",@"Cotnari",@"Dealu Mare",@"Jidvei",@"Murfatlar",@"Panciu",@"Odobeşti",@"Cotești",@"Recaș",@"Târnave",@"Vânju Mare",@"Bucium",@"Dragasani",@"Colinele Tutovei",@"Vaslui",@"Cucuteni",@"Hârlău",@"Târgu Frumos",@"Covurlui",@"Dealul Bujorului",@"Bereşti",@"Huşi",@"Bohotin",@"Iaşi",@"Tomeşti",@"Comarna",@"Copou",@"Probota",@"Iveşti",@"Corod",@"Tecuci",@"Nicoreşti",@"Jariştea",@"Panciu",@"Păuneşti",@"Ţifeşti",@"Zeletin",@"Dealu Morii",@"Tănăsoaia",@"Zeletin",@"Hlipicani",@"Nămoloasa",@"Sercaia",@"Breaza",@"Seciu",@"Cricov",@"Pietroasa",@"Tohani",@"Urlaţi - Ceptura",@"Valea Călugărească",@"Zoreşti",@"Dealurile Buzăului",@"Râmnicu Sărat",@"Zărneşti",@"Ştefăneşti",@"Topoloveni",@"Valea Mare",@"Calafat",@"Cetate",@"Poiana Mare",@"Dealurile Craiovei",@"Banu Mărăcine",@"Drăgăşani",@"Iancu Jianu",@"Greaca",@"Zimnicea",@"Plaiurile Drâncei",@"Golul Drincei",@"Oreviţa",@"Pleniţa",@"Podgoria Dacilor",@"Izvoarele",@"Podgoria Severinului",@"Corcova",@"Segarcea",@"Dealul Viilor",@"Sadova-Corabia",@"Dăbuleni",@"Potelu",@"Tâmbureşti",@"Sâmbureşti",@"Blaj",@"Jidvei",@"Mediaş",@"Târnăveni",@"Valea Nirajului",@"Lechinta",@"Bistriţa",@"Teaca",@"Şamşud",@"Şimleul Silvaniei",@"Aiud",@"Triteni",@"Alba Iulia",@"Ighiu",@"Sebeş-Apold",@"Diosig",@"Săcuieni",@"Sâniob",@"Sanislău",@"Valea lui Mihai",@"Arad",@"Jamu Mare",@"Moldova Nouă",@"Silagiu",@"Teremia",@"Tirol",@"Măderat",@"Miniş",@"Babadag",@"Istria",@"Valea Nucarilor",@"Cernavodă",@"Medgidia",@"Valu lui Traian",@"Poarta Albă",@"Simioc",@"Valea Dacilor",@"Ostrov, Constanţa",@"Aliman",@"Băneasa",@"Ostrov, Tulcea",@"Oltina",@"Sarica-Niculiţel",@"Măcin",@"Tulcea",@"Adamclisi",@"Chirnogeni",@"Dăeni",@"Hârşova"]],
                                        @[@"France",@[@"Corse",@"Ajaccio",@"Bourgogne",@"Côte de Beaune",@"Côte chalonnaise",@"Bordeaux",@"Sauternais",@"Graves",@"Médoc",@"Aloxe-corton",@"Alsace",@"Alsace grand cru",@"Anjou",@"Vallée de la Loire",@"Anjou-coteaux-de-la-loire",@"Anjou villages",@"Anjou villages Brissac",@"Arbois",@"Jura",@"Auxey-duresses",@"Bandol",@"Banyuls",@"Banyuls grand cru",@"Barsac",@"Bâtard-Montrachet",@"Béarn",@"Beaujolais",@"Beaujolais-villages",@"Beaumes-de-venise",@"Beaune",@"Bellet",@"Bergerac",@"Bienvenues-Bâtard-Montrachet",@"Blagny",@"Blaye",@"Bonnes-mares",@"Bonnezeaux",@"Bordeaux supérieur",@"Bourgogne aligoté",@"Bourgogne ordinaire",@"Bourgogne grand ordinaire",@"Bourgogne mousseux",@"Bourgogne passe-tout-grains",@"Bourgueil",@"Bouzeron",@"Brouilly",@"Bugey",@"Buzet",@"Cabardès",@"Cabernet d'Anjou",@"Cabernet de Saumur",@"Cadillac",@"Cahors",@"Canon-Fronsac",@"Cassis",@"Cérons",@"Chablis",@"Chablis grand cru",@"Chambertin",@"Chambertin-clos-de-bèze",@"Chambolle-Musigny",@"Champagne",@"Chapelle-Chambertin",@"Charlemagne",@"Charmes-Chambertin",@"Chassagne-Montrachet",@"Château-Chalon",@"Château-Grillet",@"Châteaumeillant",@"Châteauneuf-du-pape",@"Châtillon-en-Diois",@"Chénas",@"Chevalier-Montrachet",@"Cheverny",@"Chinon",@"Chiroubles",@"Chorey-lès-Beaune",@"Clairette de Bellegarde",@"Clairette de Die",@"Clairette du Languedoc",@"Clos de la Roche",@"Clos de Tart",@"Clos de Vougeot",@"Clos des Lambrays",@"Clos Saint Denis",@"Collioure",@"Condrieu",@"Corbières",@"Corbières-Boutenac",@"Cornas",@"Corton",@"Corton-Charlemagne",@"Costières de Nîmes",@"Côte-de-Beaune villages",@"Côte de Nuits villages",@"Côte de Brouilly",@"Côte roannaise",@"Côte rôtie",@"Coteaux champenois",@"Coteaux d'Aix-en-Provence",@"Coteaux de Die",@"Coteaux de l'Aubance",@"Coteaux de Saumur",@"Coteaux du Giennois",@"Coteaux du Layon",@"Coteaux du Loir",@"Coteaux du lyonnais",@"Coteaux du vendômois",@"Coteaux varois en Provence",@"Côtes de Bergerac",@"Côtes de Blaye",@"Côtes de Bordeaux",@"Côtes de Bordeaux - Saint Macaire",@"Côtes de Bourg",@"Côtes de Duras",@"Côtes de Montravel",@"Côtes de Provence",@"Côtes de Toul",@"Côtes du Forez",@"Côtes du Jura",@"Côtes du Marmandais",@"Côtes du Rhône",@"Côtes du Rhône villages",@"Côtes du Roussillon",@"Côtes du Roussillon villages",@"Côtes du Vivarais",@"Cour-Cheverny",@"Crémant d'Alsace",@"Crémant de Bordeaux",@"Crémant de Bourgogne",@"Crémant de Die",@"Crémant de Limoux",@"Crémant de Loire",@"Crémant du Jura",@"Criots-Bâtard-Montrachet",@"Crozes-Hermitage",@"Echezeaux",@"Entre-deux-mers",@"Faugères",@"Fiefs-vendéens",@"Fitou",@"Fixin",@"Fleurie",@"Fronsac",@"Fronton",@"Gaillac",@"Gaillac-premières-côtes",@"Gevrey-Chambertin",@"Gigondas",@"Givry",@"Grands-Echezeaux",@"Graves-de-Vayres",@"Graves-Supérieures",@"Grignan-les-Adhémar",@"Griotte-Chambertin",@"Haut-Médoc",@"Haut-Montravel",@"Haut-Poitou",@"Hermitage",@"Irancy",@"Irouléguy",@"Jasnières",@"Juliénas",@"jurançon",@"L'Etoile",@"La-Grande Rue",@"La Romanée",@"La Tâche",@"Ladoix",@"Lalande de Pomerol",@"Languedoc",@"Latricières-Chambertin",@"Les baux de Provence",@"Limoux",@"Lirac",@"Listrac-Médoc",@"Loupiac",@"Luberon",@"Lussac-Saint Emilion",@"Mâcon",@"Madiran",@"Malepère",@"Maranges",@"Marcillac",@"Margaux",@"Marsannay",@"Maury",@"Mazis-Chambertin",@"Mazoyères-Chambertin",@"Menetou-Salon",@"Mercurey",@"Meursault",@"Minervois",@"Minervois-la-Livinière",@"Monbazillac",@"Montagne Saint Emilion",@"Montagny",@"Monthélie",@"Montlouis-sur-Loire",@"Montrachet",@"Montravel",@"Morey-Saint-Denis",@"Morgon",@"Moselle",@"Moulin-à-vent",@"Moulis",@"Muscadet",@"Muscadet-Coteaux-de-la-Loire",@"Muscadet-Côtes-de-Grandlieu",@"Muscadet-Sèvre-et-Maine",@"Muscat de Beaumes-de-Venise",@"Muscat de Frontignan",@"Muscat de Lunel",@"Muscat de Mireval",@"Muscat de Rivesaltes",@"Muscat de Saint-Jean-de-Minervois",@"Muscat du Cap-Corse",@"Musigny",@"Néac",@"Nuits-Saint-Georges",@"Orléans",@"Orléans-Cléry",@"Pacherenc-du-Vic-Bilh",@"Palette",@"Patrimonio",@"Pauillac",@"Pécharmant",@"Pernand-Vergelesses",@"Pessac-Léognan",@"Petit-Chablis",@"Pierrevert",@"Pomerol",@"Pommard",@"Pouilly-fuissé",@"Pouilly-fumé",@"Blanc-fumé de Pouilly",@"Pouilly-Loché",@"Pouilly-sur-Loire",@"Pouilly-Vinzelles",@"Premières Côtes de Bordeaux",@"Puisseguin-Saint Emilion",@"Puligny-Montrachet",@"Quarts-de-Chaume",@"Quincy",@"Rasteau",@"Régnié",@"Reuilly",@"Richebourg",@"Rivesaltes",@"Romanée-Conti",@"Romanée-Saint Vivant",@"Rosé d'Anjou",@"Rosé de Loire",@"Rosé des Riceys",@"Rosette",@"Roussette de Savoie",@"Roussette du Bugey",@"Ruchottes-Chambertin",@"Rully",@"Saint Amour",@"Saint Aubin",@"Saint Bris",@"Saint Chinian",@"Saint Emilion",@"Saint Emilion grand cru",@"Saint Estèphe",@"Saint Georges-Saint Emilion",@"Saint Joseph",@"Saint Julien",@"Saint Nicolas de Bourgueil",@"Saint Péray",@"Saint Pourçain",@"Saint Romain",@"Saint Véran",@"Sainte Croix du Mont",@"Sainte Foy-Bordeaux",@"Sancerre",@"Santenay",@"Saumur",@"Saumur-Champigny",@"Saussignac",@"Sauternes",@"Savennières",@"Savigny-lès-Beaune",@"Seyssel",@"Tavel",@"Touraine",@"Touraine-Noble-Joué",@"Vacqueyras",@"Valençay",@"Ventoux",@"Savoie",@"Vinsobres",@"Viré-Clessé",@"Volnay",@"Vosne-Romanée",@"Vougeot",@"Vouvray",@"Coteaux d'Ancenis",@"Coteaux du Quercy",@"Côtes de Millau",@"Côtes de Saint Mont",@"Tursan",@"Entraygues et du Fel",@"Estaing",@"Saint Sardos",@"Gros plant du pays nantais",@"Côtes du Brulhois",@"Haut-Poitou",@"Côtes d'auvergne",@"Vin du Thouarsais",@"Lavilledieu"]],
                                        @[@"Spain",@[@"Condado de Huelva",@"Jerez-Xeres-Sherry",@"Manzanilla de Sanlúcar de Barrameda",@"Montilla-Moriles",@"Málaga and Sierras de Málaga",@"Calatayud",@"Campo de Borja",@"Campo de Cariñena",@"Somontano",@"Cava",@"Bierzo",@"Cigales",@"Ribera del Duero",@"Rueda",@"Toro",@"Almansa",@"Dominio de Valdepusa",@"La Mancha",@"Manchuela",@"Méntrida",@"Mondéjar",@"Guijoso",@"Ribera del Júcar",@"Valdepeñas",@"Jumilla",@"Alella",@"Empordà",@"Catalunya",@"Conca de Barberà",@"Costers del Segre",@"Montsant",@"Penedès",@"Pla de Bages",@"Priorat",@"Tarragona",@"Terra Alta",@"Vinos de Madrid",@"Alicante",@"Utiel-Requena",@"Valencia",@"Ribera del Guadiana",@"Monterrey",@"Rías Bajas",@"Ribeira Sacra",@"Ribeiro",@"Valdeorras",@"Binissalem-Mallorca",@"Plà i Llevant",@"Abona",@"La Gomera",@"Gran Canaria",@"El Hierro",@"La Palma",@"Lanzarote",@"Tacoronte-Acentejo",@"Valle de Güímar",@"Valle de la Orotava",@"Ycoden-Daute-Isora",@"Navarra",@"Rioja",@"Alavan Txakoli",@"Biscayan Txakoli",@"Getaria Txakoli",@"Rioja (Alavesa)",@"Bullas",@"Yecla",@"Jumilla"]],
                                        nil];

    if (!Country)
    {
        while (i < [RegionsByCountry count])
        {
            if (i==0)
            {
                _RegionNames = [[NSMutableArray alloc] init];
                [_RegionNames addObjectsFromArray:RegionsByCountry[i][1]];
            }
            else
            {
                [_RegionNames addObjectsFromArray:RegionsByCountry[i][1]];
            }
            i=i+1;
        }
    }
    else
    {
        while ((i < [RegionsByCountry count]) && (![RegionsByCountry[i][0] isEqualToString:Country]))
        {
            i=i+1;
        }
        if (i < [RegionsByCountry count])
        {
            _RegionNames = RegionsByCountry[i][1];
        }
        else
        {
            _RegionNames = [NSMutableArray arrayWithObjects:@"No region found", nil];
        }
    }
    i=0;
    return [_RegionNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
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
    }
    return self;
}

-(id)initWithCountry:(NSString *) Country
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        self.Country = Country;
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

-(id)initWithRegion:(NSString *) Region withCountry:(NSString *) Country
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        self.Country = Country;
        [self setSelectedRegionName:Region withCountry:Country];
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

- (void)setSelectedRegionName:(NSString *)RegionName withCountry:(NSString*) Country animated:(BOOL)animated
{
    NSInteger index = [[self RegionNames:Country] indexOfObject:RegionName];
    if (index != NSNotFound)
    {
        [self selectRow:(index+1) inComponent:0 animated:animated];
    }
    else
    {
        [self selectRow:0 inComponent:0 animated:animated];
    }
}

- (void)setSelectedRegionName:(NSString *)RegionName withCountry:(NSString*) Country
{
    [self setSelectedRegionName:RegionName withCountry:Country animated:NO];
}

- (NSString *)selectedRegionName:(NSString *) Country
{
    if ([self selectedRowInComponent:0] > 0)
    {
    NSInteger index = [self selectedRowInComponent:0]-1;
    return [self RegionNames:Country][index];
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
    return [[self RegionNames:self.Country] count]+1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 90.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    
    if(row != 0)
    {
    label.text = [self RegionNames:self.Country][row-1];
    }
    else
    {
        label.text = @"Pick a Region";
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
        [Regiondelegate regionPicker:self didSelectRegionWithName:[self selectedRegionName:self.Country]];
    }
    else
    {
        [Regiondelegate regionPicker:self didSelectRegionWithName:@""];
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
