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
    
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @(3).nn_add(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2)));
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @"3".nn_add(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2"));
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @(3).nn_add(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2"));
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
        NSString *c = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
        NSString *c = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    
    {
        NSString *c0 = @"100";
        NSNumber *c1 = @(100.1);
        if ([c0 nn_isEqualTo:c1]) {
            NSLog(@"c == c1");
        }
        else if ([c0 nn_isGreaterThan:c1]) {
            NSLog(@"c > c1");
        }
        else if ([c0 nn_isGreaterThanOrEqualTo:c1]) {
            NSLog(@"c >= c1");
        }
        else if ([c0 nn_isLessThan:c1]) {
            NSLog(@"c < c1");
        }
    }
    
    {
        //( 2 × [UIView new] )
        NSString *c = @"2".nn_mul([UIView new]);
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
 }

@end
