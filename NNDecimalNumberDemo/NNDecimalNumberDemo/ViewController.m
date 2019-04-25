//
//  ViewController.m
//  NNDecimalNumberDemo
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "ViewController.h"
#import <NNDecimalNumber/NNDecimalNumber.h>
#import "TESTDecimalNumberBehaviors.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
    NSString *c0 = @(3).nn_add(@"2").nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2)));
    NSLog(@"%@", c0);
    NSLog(@"%@", c0.nn_formula);
    //( ( ( 3 × 5 + ( 2 × 2 ) ) ÷ 4 ) × 200 )
    NSString *c1 = @"3".nn_mul(@"5").nn_add(@"2".nn_mul(@"2")).nn_div(@(4)).nn_mul(@"200");
    NSLog(@"%@", c1);
    NSLog(@"%@", c1.nn_formula);
    //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
    NSString *c2 = @"2".nn_mul(@"5").nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
    NSLog(@"%@", c2);
    NSLog(@"%@", c2.nn_formula);
    //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
    NSString *c3 = @"2".nn_mul(@"5").nn_add(@"2".nn_mul(@"2")).nn_mulPowerOf10(@(2));
    NSLog(@"%@", c3);
    NSLog(@"%@", c3.nn_formula);
    
    if ([c0 nn_isEqualTo:c1]) {
        NSLog(@"c0 == c1");
    }
    else if ([c0 nn_isGreaterThan:c1]) {
        NSLog(@"c0 > c1");
    }
    else if ([c0 nn_isGreaterThanOrEqualTo:c1]) {
        NSLog(@"c0 >= c1");
    }
    else if ([c0 nn_isLessThan:c1]) {
        NSLog(@"c0 < c1");
    }
 }

@end
