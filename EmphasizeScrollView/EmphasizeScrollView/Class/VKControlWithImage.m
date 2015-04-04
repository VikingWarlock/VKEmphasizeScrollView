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
}
@end

@implementation VKControlWithImage

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageview=[[UIImageView alloc]init];
        [self addSubview:self.imageview];
        self.imageview.layer.masksToBounds=YES;
        self.layer.masksToBounds=YES;
    }
    return self;
}

-(void)setupTitleWithNo:(NSInteger)No
{
    if (!label) {
        label=[[UILabel alloc]init];
        [self addSubview:label];
        label.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor=[UIColor yellowColor];
        label.textColor=[UIColor blueColor];
        label.layer.masksToBounds=YES;
    }
    label.text=[NSString stringWithFormat:@"%d",No];
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (label) {
        label.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        label.layer.cornerRadius=frame.size.width/2.f;
    
    }
    
    self.imageview.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
