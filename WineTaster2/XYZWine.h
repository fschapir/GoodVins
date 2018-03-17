//
//  XYZWine.h
//  WineTaster2
//
//  Created by François Schapiro on 13/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZWine : NSObject <NSCoding>

@property NSString *Name;
@property NSString *Year;
@property NSString *Country;
@property NSString *AOC;
@property NSString *Varietal;
@property NSString *Color;
@property NSMutableArray *TasteInfo;

@end
