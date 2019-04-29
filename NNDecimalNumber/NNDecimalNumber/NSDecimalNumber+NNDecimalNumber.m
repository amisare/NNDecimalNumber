//
//  NSDecimalNumber+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/25.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"

@implementation NSDecimalNumber (NNDecimalNumber)

#pragma mark - NNDecimalNumberCompare
- (NSComparisonResult)nn_decimalCompare:(id)value {
    NSDecimalNumber *v = __nn_decimalNumberWithValue(value);
    return [self compare:v];
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
