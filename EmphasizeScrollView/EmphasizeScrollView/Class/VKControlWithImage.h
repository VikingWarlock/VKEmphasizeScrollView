//
//  VKControlWithImage.h
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/5/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKControl.h"

@interface VKControlWithImage : VKControl

@property(nonatomic,strong)UIImageView *imageview;

-(void)setupTitleWithNo:(NSInteger)No;

@end
