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
    
    //(3 + 3) * 2 / 2
    NSString *c0 = @"3".nn_add(@"3").nn_mul(@"2");
    NSLog(@"%@", c0);
    NSLog(@"%@", c0.nn_formula);
    //(3 + 3 * 2) / 2
    NSString *c1 = @"3".nn_add(@"4").nn_mul(@"5").nn_add(@"3".nn_mul(@"2")).nn_power(@(2));
    NSLog(@"%@", c1);
    NSLog(@"%@", c1.nn_formula);
    
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
