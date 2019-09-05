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
        if ([c0 nn_decimalIsEqualTo:c1]) {
            NSLog(@"c == c1");
        }
        else if ([c0 nn_decimalIsGreaterThan:c1]) {
            NSLog(@"c > c1");
        }
        else if ([c0 nn_decimalIsGreaterThanOrEqualTo:c1]) {
            NSLog(@"c >= c1");
        }
        else if ([c0 nn_decimalIsLessThan:c1]) {
            NSLog(@"c < c1");
        }
    }
    
    {
        //( 2 × [UIView new] )
        NSString *c = @"2".nn_mul([UIView new]);
        NSLog(@"%@", c);
        NSLog(@"%@", c.nn_formula);
    }
    
    {
    }
    
    {
        {
            [NSString nn_setDecimalNumberGlobalBehavior:[DecimalNumberGlobalBehavior class]];
            NSString *c = @"1".nn_div(@(3));
            NSLog(@"%@", c);
            NSLog(@"%@", c.nn_formula);
        }
        {
            DecimalNumberBehavior *behavior = [DecimalNumberBehavior new];
            NSString *c = @"1".nn_behavior(behavior).nn_div(@(3)).nn_div(@(2));
            NSLog(@"%@", c);
            NSLog(@"%@", c.nn_formula);
        }
        {
            NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                              scale:4
                                                                                   raiseOnExactness:false
                                                                                    raiseOnOverflow:false
                                                                                   raiseOnUnderflow:false
                                                                                raiseOnDivideByZero:false];
            NSString *c = @"1".nn_behavior(behavior).nn_div(@(3));
            NSLog(@"%@", c);
            NSLog(@"%@", c.nn_formula);
        }
        {
            NSString *c = @"1".nn_div(@(3));
            NSLog(@"%@", c);
            NSLog(@"%@", c.nn_formula);
        }
    }
 }

@end
