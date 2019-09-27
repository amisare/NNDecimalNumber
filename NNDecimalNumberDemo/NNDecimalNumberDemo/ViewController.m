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

#define DLog(format, ...) printf("%s\n", [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logTextView.text = @"";
    self.logTextView.editable = NO;
    
    [self redirectSTD:STDOUT_FILENO];
    [self redirectSTD:STDERR_FILENO];
    
    [self decimalNumberDemo];
 }

- (void)decimalNumberDemo {
    
    // 混合运算
    {
        
        //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
        NSString *v = @(3).nn_sub(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2))).nn_div(@(2));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    {
        //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
        NSString *v = @"3".nn_sub(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2")).nn_div(@"2");
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    {
        //( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )
        NSString *v = @(3).nn_sub(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2")).nn_div(@(2));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )
        NSString *v = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    {
        //( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )
        NSString *v = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    // 值比较
    {
        NSString *v0 = @"100";
        NSNumber *v1 = @(100.1);
        if ([v0 nn_decimalIsEqualTo:v1]) {
            DLog(@"v0 == v1 : v0 = %@, v1 = %@", v0, v1);
        }
        else if ([v0 nn_decimalIsGreaterThan:v1]) {
            DLog(@"v0 > v1 : v0 = %@, v1 = %@", v0, v1);
        }
        else if ([v0 nn_decimalIsGreaterThanOrEqualTo:v1]) {
            DLog(@"v0 <= v1 : v0 = %@, v1 = %@", v0, v1);
        }
        else if ([v0 nn_decimalIsLessThan:v1]) {
            DLog(@"v0 < v1 : v0 = %@, v1 = %@", v0, v1);
        }
    }
    
    // NSDecimalNumberBehaviors
    {
        {
            [NSString nn_setDecimalNumberGlobalBehavior:[DecimalNumberGlobalBehavior class]];
            NSString *v = @"1".nn_div(@(3));
            DLog(@"%@ = %@", v, v.nn_formula);
        }
        {
            DecimalNumberBehavior *behavior = [DecimalNumberBehavior new];
            NSString *v = @"1".nn_behavior(behavior).nn_div(@(3)).nn_div(@(2));
            DLog(@"%@ = %@", v, v.nn_formula);
        }
        {
            NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                              scale:4
                                                                                   raiseOnExactness:false
                                                                                    raiseOnOverflow:false
                                                                                   raiseOnUnderflow:false
                                                                                raiseOnDivideByZero:false];
            NSString *v = @"1".nn_behavior(behavior).nn_div(@(3));
            DLog(@"%@ = %@", v, v.nn_formula);
        }
        {
            NSString *v = @"1".nn_div(@(3));
            DLog(@"%@ = %@", v, v.nn_formula);
        }
    }
    
    // 异常计算
    {
        //( 2 × [UIView new] )
        NSString *v = @"2".nn_mul([UIView new]);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( 2 / 0 )
        NSString *v = @"2".nn_div(@"0");
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / nil )
        NSString *v =  NN_Trust(nil).nn_div(nil);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / 0 )
        NSString *v =  NN_Trust(nil).nn_div(@(0));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / [UIView new] )
        NSString *v =  NN_Trust(nil).nn_div([UIView new]);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( nil / [NSNull null] )
        NSString *v =  NN_Trust(nil).nn_div([NSNull null]);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / [NSNull null] )
        NSString *v =  [NSNull null].nn_div([NSNull null]);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / 0 )
        NSString *v =  [NSNull null].nn_div(@(0));
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / [UIView new] )
        NSString *v =  [NSNull null].nn_div([UIView new]);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
    
    {
        //( [NSNull null] / nil )
        NSString *v =  [NSNull null].nn_div(nil);
        DLog(@"%@ = %@", v, v.nn_formula);
    }
}

- (void)redirectNotificationHandle:(NSNotification *)notification{
    NSData *data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    self.logTextView.text = [NSString stringWithFormat:@"%@%@",self.logTextView.text, str];
    NSRange range;
    range.location = [self.logTextView.text length] - 1;
    range.length = 0;
    [self.logTextView scrollRangeToVisible:range];
    
    [[notification object] readInBackgroundAndNotify];
}

- (void)redirectSTD:(int )fd{
    NSPipe * pipe = [NSPipe pipe] ;
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
    dup2([[pipe fileHandleForWriting] fileDescriptor], fd) ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(redirectNotificationHandle:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:pipeReadHandle] ;
    [pipeReadHandle readInBackgroundAndNotify];
}

@end
