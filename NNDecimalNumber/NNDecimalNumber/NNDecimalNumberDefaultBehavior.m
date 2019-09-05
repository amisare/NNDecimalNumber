//
//  NNDecimalNumberDefaultBehavior.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumberDefaultBehavior.h"

@implementation NNDecimalNumberDefaultBehavior

- (nullable NSDecimalNumber *)exceptionDuringOperation:(nonnull SEL)operation error:(NSCalculationError)error leftOperand:(nonnull NSDecimalNumber *)leftOperand rightOperand:(nullable NSDecimalNumber *)rightOperand {
    return [NSDecimalNumber notANumber];
}

- (NSRoundingMode)roundingMode {
    return NSRoundPlain;
}

- (short)scale {
    return NSDecimalNoScale;
}

@end
