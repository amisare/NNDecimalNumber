//
//  TESTDecimalNumberBehaviors.m
//  NNDecimalNumberDemo
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "TESTDecimalNumberBehaviors.h"

@implementation TESTDecimalNumberBehaviors



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
