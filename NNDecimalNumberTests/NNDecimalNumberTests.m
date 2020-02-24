//
//  NNDecimalNumberTests.m
//  NNDecimalNumberTests
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <NNDecimalNumber/NNDecimalNumber.h>

@interface NNTestDecimalNumberGlobalBehavior : NSObject<NSDecimalNumberBehaviors>

@end

@implementation NNTestDecimalNumberGlobalBehavior

- (nullable NSDecimalNumber *)exceptionDuringOperation:(nonnull SEL)operation error:(NSCalculationError)error leftOperand:(nonnull NSDecimalNumber *)leftOperand rightOperand:(nullable NSDecimalNumber *)rightOperand {
    return [NSDecimalNumber notANumber];
}

- (NSRoundingMode)roundingMode {
    return NSRoundPlain;
}

- (short)scale {
    return 2;
}

@end

@interface NNDecimalNumberTests : XCTestCase

@end

@implementation NNDecimalNumberTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testCalculateNumberType {
    NSString *v = @(3).nn_sub(@(2)).nn_add(@(5)).nn_mul(@(3)).nn_mul(@(10).nn_mul(@(2))).nn_div(@(2));
    XCTAssertTrue([v isEqualToString:@"180"]);
    XCTAssertTrue([v.nn_formula isEqualToString:@"( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )"]);
}

- (void)testCalculateStringType {
    NSString *v = @"3".nn_sub(@"2").nn_add(@"5").nn_mul(@"3").nn_mul(@"10".nn_mul(@"2")).nn_div(@"2");
    XCTAssertTrue([v isEqualToString:@"180"]);
    XCTAssertTrue([v.nn_formula isEqualToString:@"( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )"]);
}

- (void)testCalculateMixtureType {
    NSString *v = @(3).nn_sub(@"2").nn_add(@(5)).nn_mul(@"3").nn_mul(@(10).nn_mul(@"2")).nn_div(@(2));
    XCTAssertTrue([v isEqualToString:@"180"]);
    XCTAssertTrue([v.nn_formula isEqualToString:@"( ( ( ( 3 - 2 + 5 ) × 3 ) × ( 10 × 2 ) ) ÷ 2 )"]);
}

- (void)testCalculatePower {
    NSString *v = @"2".nn_mul(@(5)).nn_add(@"2".nn_mul(@"2")).nn_power(@(2));
    XCTAssertTrue([v isEqualToString:@"196"]);
    XCTAssertTrue([v.nn_formula isEqualToString:@"( ( 2 × 5 + ( 2 × 2 ) ) ^ 2 )"]);
}

- (void)testCalculatePowerOf10 {
    NSString *v = @(2).nn_mul(@"5").nn_add(@"2".nn_mul(@(2))).nn_mulPowerOf10(@(2));
    XCTAssertTrue([v isEqualToString:@"1400"]);
    XCTAssertTrue([v.nn_formula isEqualToString:@"( ( 2 × 5 + ( 2 × 2 ) ) × 10 ^ 2 )"]);
}

- (void)testCompare {
    XCTAssertTrue([@(10.0001) nn_decimalIsEqualTo:@(10.0001)]);
    XCTAssertTrue([@(11.0001) nn_decimalIsGreaterThan:@(10.0001)]);
    XCTAssertTrue([@(11.0001) nn_decimalIsGreaterThanOrEqualTo:@(10.0001)]);
    XCTAssertTrue([@(10.0001) nn_decimalIsGreaterThanOrEqualTo:@(10.0001)]);
    XCTAssertTrue([@(10.0001) nn_decimalIsLessThan:@(11.0001)]);
    XCTAssertTrue([@(10.0001) nn_decimalIsLessThanOrEqualTo:@(11.0001)]);
    XCTAssertTrue([@(10.0001) nn_decimalIsLessThanOrEqualTo:@(10.0001)]);
    
    XCTAssertTrue([@"10.0001" nn_decimalIsEqualTo:@(10.0001)]);
    XCTAssertTrue([@"11.0001" nn_decimalIsGreaterThan:@(10.0001)]);
    XCTAssertTrue([@"11.0001" nn_decimalIsGreaterThanOrEqualTo:@(10.0001)]);
    XCTAssertTrue([@"10.0001" nn_decimalIsGreaterThanOrEqualTo:@(10.0001)]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThan:@(11.0001)]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThanOrEqualTo:@(11.0001)]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThanOrEqualTo:@(10.0001)]);
    
    XCTAssertTrue([@"10.0001" nn_decimalIsEqualTo:@"10.0001"]);
    XCTAssertTrue([@"11.0001" nn_decimalIsGreaterThan:@"10.0001"]);
    XCTAssertTrue([@"11.0001" nn_decimalIsGreaterThanOrEqualTo:@"10.0001"]);
    XCTAssertTrue([@"10.0001" nn_decimalIsGreaterThanOrEqualTo:@"10.0001"]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThan:@"11.0001"]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThanOrEqualTo:@"11.0001"]);
    XCTAssertTrue([@"10.0001" nn_decimalIsLessThanOrEqualTo:@"10.0001"]);
}

- (void)testBehavior {
    // 设定全局 NSDecimalNumberBehaviors
    [NSObject nn_setDecimalNumberGlobalBehavior:[NNTestDecimalNumberGlobalBehavior class]];
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"3") isEqualToString:@"0.22"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"3").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 3 )"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"2") isEqualToString:@"0.34"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"2").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 2 )"]);
    
    // 设定运算式 NSDecimalNumberBehaviors
    NSDecimalNumberHandler *behavior = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain
                                                                                      scale:4
                                                                           raiseOnExactness:false
                                                                            raiseOnOverflow:false
                                                                           raiseOnUnderflow:false
                                                                        raiseOnDivideByZero:false];
    XCTAssertTrue([@"2".nn_behavior(behavior).nn_div(@(3)).nn_div(@"3") isEqualToString:@"0.2222"]);
    XCTAssertTrue([@"2".nn_behavior(behavior).nn_div(@(3)).nn_div(@"3").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 3 )"]);
    XCTAssertTrue([@"2".nn_behavior(behavior).nn_div(@(3)).nn_div(@"2") isEqualToString:@"0.3334"]);
    XCTAssertTrue([@"2".nn_behavior(behavior).nn_div(@(3)).nn_div(@"2").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 2 )"]);
    
    // 未设定运算式 NSDecimalNumberBehaviors 继续使用全局 NSDecimalNumberBehaviors
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"3") isEqualToString:@"0.22"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"3").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 3 )"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"2") isEqualToString:@"0.34"]);
    XCTAssertTrue([@"2".nn_div(@(3)).nn_div(@"2").nn_formula isEqualToString:@"( ( 2 ÷ 3 ) ÷ 2 )"]);
}

- (void)testNN_Trust {
    XCTAssertTrue(NN_Trust(nil) != nil);
}

- (void)testNN_isNaN {
    XCTAssertTrue(NN_isNaN(nil));
    XCTAssertTrue(NN_isNaN(@"NaN"));
    XCTAssertTrue(NN_isNaN([NSNull null]));
    XCTAssertTrue(NN_isNaN([UIView new]));
    XCTAssertTrue(!NN_isNaN(@"0.01"));
    XCTAssertTrue(!NN_isNaN(@(0.01)));
}

- (void)testExceptionCase {
    NSString *v;
    
    v = @"2".nn_div(@"0");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = NN_Trust(nil).nn_div(nil);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = @"2".nn_div(nil);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = NN_Trust(nil).nn_div(@"2");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = NN_Trust(nil).nn_div(@"0");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [UIView new].nn_div([UIView new]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = @"2".nn_div([UIView new]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [UIView new].nn_div(@"2");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [UIView new].nn_div(@"0");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [NSNull null].nn_div([NSNull null]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = @"2".nn_div([NSNull null]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [NSNull null].nn_div(@"2");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [NSNull null].nn_div(@"0");
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = NN_Trust(nil).nn_div([UIView new]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = NN_Trust(nil).nn_div([NSNull null]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [UIView new].nn_div(nil);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [UIView new].nn_div([NSNull null]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [NSNull null].nn_div(nil);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
    
    v = [NSNull null].nn_div([UIView new]);
    NSLog(@"%@", v.nn_formula);
    XCTAssertTrue(NN_isNaN(v));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
