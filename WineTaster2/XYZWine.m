//
//  XYZWine.m
//  WineTaster2
//
//  Created by François Schapiro on 13/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import "XYZWine.h"

@implementation XYZWine

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.Name = [decoder decodeObjectForKey:@"Name"];
    self.Year = [decoder decodeObjectForKey:@"Year"];
    self.Country = [decoder decodeObjectForKey:@"Country"];
    self.AOC = [decoder decodeObjectForKey:@"AOC"];
    self.Varietal = [decoder decodeObjectForKey:@"Varietal"];
    self.Color = [decoder decodeObjectForKey:@"Color"];
    self.TasteInfo = [decoder decodeObjectForKey:@"TasteInfo"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Year forKey:@"Year"];
    [encoder encodeObject:self.Country forKey:@"Country"];
    [encoder encodeObject:self.AOC forKey:@"AOC"];
    [encoder encodeObject:self.Varietal forKey:@"Varietal"];
    [encoder encodeObject:self.Color forKey:@"Color"];
    [encoder encodeObject:self.TasteInfo forKey:@"TasteInfo"];
}

@end
