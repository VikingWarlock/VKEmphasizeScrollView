//
//  ViewController.m
//  EmphasizeScrollView
//
//  Created by viking warlock on 4/4/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import "ViewController.h"
#import "EmphasizeScrollView.h"

@interface ViewController ()<EmphasizeScrollDelegate>
{
    EmphasizeScrollView *scroll;
    UILabel *data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"ExampleView";
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    data=[[UILabel alloc]init];
    [self.view addSubview:data];
    data.frame=CGRectMake(0, 240.f, self.view.frame.size.width, 100.f);
    data.textColor=[UIColor blackColor];
    
    scroll=[[EmphasizeScrollView alloc]initWithFrame:CGRectMake(0, 80.f, self.view.frame.size.width, 140.f)];
    scroll.backgroundColor=[UIColor greenColor];
    [self.view addSubview:scroll];
    scroll.OptionsCount=2;
    scroll.VKDelegate=self;
//    scroll.delegate=self;
    scroll.data=@[@"",@"",@"",@"",@"",@""];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Emphasize:(EmphasizeScrollView *)EmphasizeScroll DidEmphasizeTo:(NSUInteger)index
{
    data.text=[NSString stringWithFormat:@"Now Selected %d",index];
}

@end
