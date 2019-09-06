//
//  ViewController.m
//  NNDecimalNumberDemo
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "ViewController.h"
#import <NNDecimalNumber/NNDecimalNumber.h>
#import "DecimalNumberBehavior.h"
#import "DecimalNumberGlobalBehavior.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 混合运算
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @(3).nn_add(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2)));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @"3".nn_add(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2"));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    {
        //( ( ( 3 + 2 + 5 ) × 3 ) × ( 10 × 2 ) )
        NSString *c = @(3).nn_add(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2"));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
        NSString *c = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
        NSString *c = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    // 值比较
    {
        NSString *c0 = @"100";
        NSNumber *c1 = @(100.1);
        if ([c0 nn_decimalIsEqualTo:c1]) {
            NSLog(@"c0 == c1 : c0 = %@, c1 = %@", c0, c1);
        }
        else if ([c0 nn_decimalIsGreaterThan:c1]) {
            NSLog(@"c0 > c1 : c0 = %@, c1 = %@", c0, c1);
        }
        else if ([c0 nn_decimalIsGreaterThanOrEqualTo:c1]) {
            NSLog(@"c0 <= c1 : c0 = %@, c1 = %@", c0, c1);
        }
        else if ([c0 nn_decimalIsLessThan:c1]) {
            NSLog(@"c0 < c1 : c0 = %@, c1 = %@", c0, c1);
        }
    }
    
    // NSDecimalNumberBehaviors
    {
        {
            [NSString nn_setDecimalNumberGlobalBehavior:[DecimalNumberGlobalBehavior class]];
            NSString *c = @"1".nn_div(@(3));
            NSLog(@"%@ = %@", c, c.nn_formula);
        }
        {
            DecimalNumberBehavior *behavior = [DecimalNumberBehavior new];
            NSString *c = @"1".nn_behavior(behavior).nn_div(@(3)).nn_div(@(2));
            NSLog(@"%@ = %@", c, c.nn_formula);
        }
        {
            NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                              scale:4
                                                                                   raiseOnExactness:false
                                                                                    raiseOnOverflow:false
                                                                                   raiseOnUnderflow:false
                                                                                raiseOnDivideByZero:false];
            NSString *c = @"1".nn_behavior(behavior).nn_div(@(3));
            NSLog(@"%@ = %@", c, c.nn_formula);
        }
        {
            NSString *c = @"1".nn_div(@(3));
            NSLog(@"%@ = %@", c, c.nn_formula);
        }
    }
    
    // 异常计算
    {
        //( 2 × [UIView new] )
        NSString *c = @"2".nn_mul([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( 2 / 0 )
        NSString *c = @"2".nn_div(@"0");
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / nil )
        NSString *c =  NN_Trust(nil).nn_div(nil);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / 0 )
        NSString *c =  NN_Trust(nil).nn_div(@(0));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / [UIView new] )
        NSString *c =  NN_Trust(nil).nn_div([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( nil / [NSNull null] )
        NSString *c =  NN_Trust(nil).nn_div([NSNull null]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / [NSNull null] )
        NSString *c =  NN_Trust([NSNull null]).nn_div([NSNull null]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / 0 )
        NSString *c =  NN_Trust([NSNull null]).nn_div(@(0));
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / [UIView new] )
        NSString *c =  NN_Trust([NSNull null]).nn_div([UIView new]);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
    
    {
        //( [NSNull null] / nil )
        NSString *c =  NN_Trust([NSNull null]).nn_div(nil);
        NSLog(@"%@ = %@", c, c.nn_formula);
    }
 }

@end
