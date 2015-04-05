//
//  VKControlWithImage.m
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/5/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import "VKControlWithImage.h"

@interface VKControlWithImage()
{
    UILabel *label;
    UIView *tint;
}
@end

@implementation VKControlWithImage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageview=[[UIImageView alloc]init];
        [self.MainView addSubview:self.imageview];
        self.imageview.layer.masksToBounds=YES;
        self.layer.masksToBounds=YES;
        
        tint=[[UIView alloc]init];
        [self.MainView addSubview:tint];
        tint.layer.masksToBounds=YES;
        tint.backgroundColor=[UIColor yellowColor];
    }
    return self;
}

-(void)setupTitleWithNo:(NSInteger)No
{
    if (!label) {
        label=[[UILabel alloc]init];
        [self.TipView addSubview:label];
        label.frame=CGRectMake(0, 0, self.frame.size.width, 20.f);
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor blueColor];
        label.layer.masksToBounds=YES;
    }
    label.text=[NSString stringWithFormat:@"%d",No];
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageview.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    label.frame=CGRectMake(0, 0, self.frame.size.width, 20.f);
    tint.frame=CGRectMake(0, 0, self.MainView.frame.size.width, self.MainView.frame.size.height);
    tint.layer.cornerRadius=tint.frame.size.width/2.f;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
