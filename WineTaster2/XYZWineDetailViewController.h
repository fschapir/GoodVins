//
//  XYZWineDetailViewController.h
//  WineTaster2
//
//  Created by François Schapiro on 13/11/2013.
//  Copyright (c) 2013 schapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZWine.h"

@interface XYZWineDetailViewController : UIViewController

@property (nonatomic,strong) XYZWine *WineDetail;
@property (nonatomic,weak) NSNumber *DeletionRequest;
@property NSIndexPath *IndexOfOrigin;

@end
