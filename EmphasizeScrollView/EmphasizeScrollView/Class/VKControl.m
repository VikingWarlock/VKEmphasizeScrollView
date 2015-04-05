//
//  VKControl.m
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/6/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import "VKControl.h"

@implementation VKControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.MainView=[[UIView alloc]init];
        [self addSubview:self.MainView];
        self.TipView=[[UIView alloc]init];
        [self addSubview:self.TipView];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.MainView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.TipView.frame=CGRectMake(0, frame.size.height-18.f, frame.size.width, 18.f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
