//
//  EmphasizeScrollView.m
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/4/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import "EmphasizeScrollView.h"
#import "VKControlWithImage.h"
#import "VKControlWithView.h"


@interface EmphasizeScrollView()<UIScrollViewDelegate>
{
    NSMutableArray *ViewStack;
    NSUInteger CurrentIndex;
    CGSize ItemSize;
    CGAffineTransform OriginalTransform;
    CGFloat GapLength;
    BOOL needReloadTransform;
}
@end

@implementation EmphasizeScrollView

-(instancetype)init
{
    self=[super init];
    if (self) {
        self.delegate=self;
        [self Setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate=self;
        [self Setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        [self Setup];
    }
    return self;
}

#pragma Private Setup

-(void)Setup
{
    ViewStack=[NSMutableArray array];
    CurrentIndex=0;
    self.EmphasizeRate=0.95f;
    self.NormalRate=0.2f;
    self.EnableCircle=YES;
    self.AutoCenter=NO;
    self.bounces=NO;
    OriginalTransform=CGAffineTransformMake(1, 0, 0, 1, 0, 0);
}

-(void)reloadLayouts
{
/*
    if (ViewStack.count>0) {
        UIControl *item=ViewStack[CurrentIndex];
        item.center=CGPointMake(self.contentOffset.x+self.frame.size.width/2.f, self.frame.size.height/2.f);
    }
 */
    NSInteger count=0;
    for(VKControlWithImage *item in ViewStack)
    {
        item.frame=CGRectMake(self.frame.size.width/2.f-ItemSize.width/2.f+count*ItemSize.width, (self.frame.size.height-ItemSize.height)/2.f, ItemSize.width, ItemSize.height);
        
        if (count==CurrentIndex) {
            item.transform=CGAffineTransformScale(OriginalTransform, self.EmphasizeRate, self.EmphasizeRate);
        }else
        {
            item.transform=CGAffineTransformScale(OriginalTransform, self.NormalRate, self.NormalRate);
        }
        
        item.imageview.layer.cornerRadius=ItemSize.width/2.f;
        count++;
    }
    
}

#pragma Private Delegate Method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    
    CGPoint offset=scrollView.contentOffset;
    NSInteger Selection = (int)(offset.x/ItemSize.width);

    
    float k1 = (self.EmphasizeRate-self.NormalRate)/ItemSize.width;
    //k1>0;
    float k2 = -k1;
    //k2<0;
    CGFloat insideOffset=offset.x-Selection*ItemSize.width;
    NSUInteger tempCurrent;
    if (insideOffset/ItemSize.width>0.5f && Selection+1<ViewStack.count) {
        tempCurrent=Selection+1;
        if (tempCurrent!=CurrentIndex) {
            if (scrollView.isDragging) {
                if ([self.VKDelegate respondsToSelector:@selector(Emphasize:DidEmphasizeTo:)]) {
                    [self.VKDelegate Emphasize:self DidEmphasizeTo:tempCurrent];
                }
            }
        }
        CurrentIndex=tempCurrent;
    }else
    {
        tempCurrent=Selection;
        if (tempCurrent!=CurrentIndex) {
            if (scrollView.isDragging) {
                if ([self.VKDelegate respondsToSelector:@selector(Emphasize:DidEmphasizeTo:)]) {
                    [self.VKDelegate Emphasize:self DidEmphasizeTo:tempCurrent];
                }
            }
            
        }
        CurrentIndex=tempCurrent;
    
    }
    

    
    
//    NSLog(@"%f",insideOffset);
    
    if (Selection-1>=0) {
        VKControlWithImage *pre=ViewStack[Selection-1];
        pre.transform=CGAffineTransformScale(OriginalTransform, self.NormalRate, self.NormalRate);
    }
    
    if (Selection+1<ViewStack.count) {
        VKControlWithImage *itemBack=ViewStack[Selection+1];
        itemBack.transform=CGAffineTransformScale(OriginalTransform, k1*insideOffset+self.NormalRate,k1*insideOffset+self.NormalRate);
    }
    VKControlWithImage *item=ViewStack[Selection];
    item.transform=CGAffineTransformScale(OriginalTransform, k2*insideOffset+self.EmphasizeRate,k2*insideOffset+self.EmphasizeRate);
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"stop1");

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"stop2");
    
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"stop3");
    NSInteger Selection = CurrentIndex;
    if (Selection>0) {
        [scrollView scrollRectToVisible:CGRectMake(Selection*ItemSize.width, (self.frame.size.height-ItemSize.height)/2.f, self.frame.size.width/2.f-ItemSize.width/2.f, ItemSize.height) animated:YES];
        [scrollView scrollRectToVisible:CGRectMake(self.frame.size.width/2.f+ItemSize.width/2.f+Selection*ItemSize.width, (self.frame.size.height-ItemSize.height)/2.f, self.frame.size.width/2.f-ItemSize.width/2.f, ItemSize.height) animated:YES];
    }else
    {
        [scrollView scrollRectToVisible:CGRectMake(0, 0, self.frame.size.width/2.f, 10.f) animated:YES];
    }
}

#pragma Public Method
-(NSUInteger)CurrentEmphasizeIndex
{
    return CurrentIndex;
}
-(void)setData:(NSArray *)data
{
    if (ViewStack.count<data.count) {
        for(NSInteger count=ViewStack.count;count<data.count;count++)
        {
            VKControlWithImage *item = [[VKControlWithImage alloc]init];
            [ViewStack addObject:item];
            [self addSubview:item];
        }
    }
    
    NSInteger count2=0;
    for(VKControlWithImage *item in ViewStack)
    {
        [item setupTitleWithNo:count2];
        count2++;
    }
    
    self.contentSize=CGSizeMake(ItemSize.width*data.count+self.frame.size.width-ItemSize.width, self.frame.size.height);
    [self reloadLayouts];
}

-(void)setEmphasizeRate:(CGFloat)EmphasizeRate
{
    _EmphasizeRate=EmphasizeRate;
}

-(void)setNormalRate:(CGFloat)NormalRate
{
    _NormalRate=NormalRate;
}

-(void)setAutoCenter:(BOOL)AutoCenter
{

}
-(void)setEnableCircle:(BOOL)EnableCircle
{

}
-(void)setOptionsCount:(NSUInteger)OptionsCount
{
    if (OptionsCount<=0) {
        self.OptionsCount=1;
        return;
    }
    
    GapLength=self.frame.size.width/(2*OptionsCount+1);
    ItemSize=GapLength > self.frame.size.height?CGSizeMake(self.frame.size.height, self.frame.size.height):CGSizeMake(GapLength, GapLength);
    [self reloadLayouts];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
