//
//  NSNumber+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"

@implementation NSNumber (NNDecimalNumber)

- (NSString *)__nn_stringValue {
    return [NSMutableString stringWithString:self.stringValue];
}

#pragma mark - NNDecimalNumber
- (NSString *(^)(id))nn_add {
    return self.__nn_stringValue.nn_add;
}

- (NSString *(^)(id))nn_sub {
    return self.__nn_stringValue.nn_sub;
}

- (NSString *(^)(id))nn_mul {
    return self.__nn_stringValue.nn_mul;
}

- (NSString *(^)(id))nn_div {
    return self.__nn_stringValue.nn_div;
}

- (NSString *(^)(id))nn_power {
    return self.__nn_stringValue.nn_power;
}

- (NSString *(^)(id))nn_mulPowerOf10 {
    return self.__nn_stringValue.nn_mulPowerOf10;
}

#pragma mark - NNDecimalNumberCompare
- (NSComparisonResult)nn_compare:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_compare:value];
}

- (BOOL)nn_isEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_isEqualTo:value];
}

- (BOOL)nn_isGreaterThan:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_isGreaterThan:value];
}

- (BOOL)nn_isGreaterThanOrEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_isGreaterThanOrEqualTo:value];
}

- (BOOL)nn_isLessThan:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_isLessThan:value];
}

- (BOOL)nn_isLessThanOrEqualTo:(id)value {
    NSDecimalNumber *l = __nn_decimalNumberWithValue(self);
    return [l nn_isLessThanOrEqualTo:value];
}

@end
