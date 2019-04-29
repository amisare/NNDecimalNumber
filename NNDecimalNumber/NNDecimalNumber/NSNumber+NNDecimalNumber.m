//
//  NSNumber+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"


@implementation NSNumber (NNDecimalNumberStringValue)

- (NSString *)nn_stringValue {
    return [NSMutableString stringWithString:self.stringValue];
}

@end

@implementation NSNumber (NNDecimalNumber)

#pragma mark - NNDecimalNumber
- (NSString *(^)(id))nn_add {
    return self.nn_stringValue.nn_add;
}

- (NSString *(^)(id))nn_sub {
    return self.nn_stringValue.nn_sub;
}

- (NSString *(^)(id))nn_mul {
    return self.nn_stringValue.nn_mul;
}

- (NSString *(^)(id))nn_div {
    return self.nn_stringValue.nn_div;
}

- (NSString *(^)(id))nn_power {
    return self.nn_stringValue.nn_power;
}

- (NSString *(^)(id))nn_mulPowerOf10 {
    return self.nn_stringValue.nn_mulPowerOf10;
}

#pragma mark - NNDecimalNumberCompare
- (NSComparisonResult)nn_decimalCompare:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalCompare:value];
}

- (BOOL)nn_decimalIsEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalIsEqualTo:value];
}

- (BOOL)nn_decimalIsGreaterThan:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalIsGreaterThan:value];
}

- (BOOL)nn_decimalIsGreaterThanOrEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalIsGreaterThanOrEqualTo:value];
}

- (BOOL)nn_decimalIsLessThan:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalIsLessThan:value];
}

- (BOOL)nn_decimalIsLessThanOrEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_decimalIsLessThanOrEqualTo:value];
}

@end
