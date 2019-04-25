//
//  NNDecimalNumberHandler.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumberHandler.h"

@implementation NNDecimalNumberHandler

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
