//
//  NSObject+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by 顾海军 on 2019/9/26.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"
#import "NNDecimalNumberDefaultBehavior.h"
#import "NSObject+NNDecimalNumberFormulaStack.h"
#import "NSObject+NNDecimalNumberBehavior.h"

static Class __nn_decimalNumberGlobalBehavior;

@implementation NSObject (NNDecimalNumber)

#pragma mark - NNDecimalNumberGlobalBehavior
+ (Class)nn_decimalNumberGlobalBehavior {
    if (__nn_decimalNumberGlobalBehavior == nil) {
        __nn_decimalNumberGlobalBehavior = [NNDecimalNumberDefaultBehavior class];
    }
    return __nn_decimalNumberGlobalBehavior;
}

+ (void)nn_setDecimalNumberGlobalBehavior:(Class)decimalNumberGlobalBehavior {
    NSAssert([decimalNumberGlobalBehavior conformsToProtocol:@protocol(NSDecimalNumberBehaviors)], @"DecimalNumberGlobalBehavior must be conforms to protocol NSDecimalNumberBehaviors");
    __nn_decimalNumberGlobalBehavior = decimalNumberGlobalBehavior;
}

#pragma mark - NNDecimalNumberFormula
- (NSString *)nn_formula {
    NSString *formula = __nn_formulaFromFormulaStack(self.nn_formulaStack);
    return formula;
}

#pragma mark - NNDecimalNumberBehavior
- (NSString *(^)(id <NSDecimalNumberBehaviors>))nn_behavior {
    return ^id(id <NSDecimalNumberBehaviors> behavior) {
        NSString *value = __nn_convertToMutableString(self);
        value.nn_decimalNumberBehavior = behavior;
        value.nn_formulaStack = self.nn_formulaStack;
        return value;
    };
}

#pragma mark - NNDecimalNumber
- (NSString *(^)(id))nn_add {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypeAdd, self, value);
    };
}

- (NSString *(^)(id))nn_sub {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypeSub, self, value);
    };
}

- (NSString *(^)(id))nn_mul {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypeMul, self, value);
    };
}

- (NSString *(^)(id))nn_div {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypeDiv, self, value);
    };
}

- (NSString *(^)(id))nn_power {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypePower, self, value);
    };
}

- (NSString *(^)(id))nn_mulPowerOf10 {
    return ^NSString *(id value) {
        return __nn_calculate(NNDecimalNumberOperatorTypeMulPowerOf10, self, value);
    };
}

#pragma mark - NNDecimalNumberCompare
- (NSComparisonResult)nn_decimalCompare:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    NSDecimalNumber *r = __nn_decimalNumberWithValue(value);
    return [l compare:r];
}

- (BOOL)nn_decimalIsEqualTo:(id)value {
    NSComparisonResult r = [self nn_decimalCompare:value];
    return (r == NSOrderedSame);
}

- (BOOL)nn_decimalIsGreaterThan:(id)value {
    NSComparisonResult r = [self nn_decimalCompare:value];
    return (r == NSOrderedDescending);
}

- (BOOL)nn_decimalIsGreaterThanOrEqualTo:(id)value {
    NSComparisonResult r = [self nn_decimalCompare:value];
    return (r == NSOrderedDescending || r == NSOrderedSame);
}

- (BOOL)nn_decimalIsLessThan:(id)value {
    NSComparisonResult r = [self nn_decimalCompare:value];
    return (r == NSOrderedAscending);
}

- (BOOL)nn_decimalIsLessThanOrEqualTo:(id)value {
    NSComparisonResult r = [self nn_decimalCompare:value];
    return (r == NSOrderedAscending || r == NSOrderedSame);
}

@end
