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
- (NSComparisonResult)nn_compare:(id)value {
    NSDecimalNumber *v = __nn_decimalNumberWithValue(value);
    return [self compare:v];
}

- (BOOL)nn_isEqualTo:(id)value {
    NSComparisonResult r = [self nn_compare:value];
    return (r == NSOrderedSame);
}

- (BOOL)nn_isGreaterThan:(id)value {
    NSComparisonResult r = [self nn_compare:value];
    return (r == NSOrderedDescending);
}

- (BOOL)nn_isGreaterThanOrEqualTo:(id)value {
    NSComparisonResult r = [self nn_compare:value];
    return (r == NSOrderedDescending || r == NSOrderedSame);
}

- (BOOL)nn_isLessThan:(id)value {
    NSComparisonResult r = [self nn_compare:value];
    return (r == NSOrderedAscending);
}

- (BOOL)nn_isLessThanOrEqualTo:(id)value {
    NSComparisonResult r = [self nn_compare:value];
    return (r == NSOrderedAscending || r == NSOrderedSame);
}

@end
