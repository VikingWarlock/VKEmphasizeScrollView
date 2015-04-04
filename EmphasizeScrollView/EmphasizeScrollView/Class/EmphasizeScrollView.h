//
//  EmphasizeScrollView.h
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/4/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmphasizeScrollView;

typedef NS_ENUM(NSInteger, EmphasizeScrollViewType)
{
    EmphasizeScrollViewImageOnly=1,
    EmphasizeScrollViewCustomView
};


@protocol EmphasizeScrollDelegate <NSObject>

@optional
-(void)Emphasize:(EmphasizeScrollView*)EmphasizeScroll DidEmphasizeTo:(NSUInteger)index;


@end

@interface EmphasizeScrollView : UIScrollView


@property(nonatomic,assign)NSArray *data;
/**
 *Default is 1
 */
@property(nonatomic,assign)NSUInteger OptionsCount;
/**
 *Default is 0.8f
 *Shouldn't greater than 0.8f
 */
@property(nonatomic,assign)CGFloat EmphasizeRate;
/**
 *Default is 0.1f
 *
 */
@property(nonatomic,assign)CGFloat NormalRate;
@property(nonatomic,readonly)NSUInteger CurrentEmphasizeIndex;
@property(nonatomic,weak)id<EmphasizeScrollDelegate> VKDelegate;
@property(nonatomic,assign)BOOL EnableCircle;
/**
 *Default is NO
 */
@property(nonatomic,assign)BOOL AutoCenter;

/**
 *The array can contain UIImage,UIView and its subclass
 */
-(void)setData:(NSArray *)data;

/**
 *EmphasizeRate should greater than 1.f otherwise it will
 *be smaller when selected
 */
-(void)setEmphasizeRate:(CGFloat)EmphasizeRate;

/**
 *When rounded views are needed, enable this
 *Default is YES
 */
-(void)setEnableCircle:(BOOL)EnableCircle;

-(UIControl *)ControlAtIndex:(NSUInteger)index;

/**
 *If every element is ImageView it will return the imageview,
 *otherwise nil
 */
-(UIImageView *)ImageViewAtIndex:(NSUInteger)index;

-(void)ScrollToIndex:(NSUInteger)index;

@end
