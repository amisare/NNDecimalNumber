//
//  DecimalNumberGlobalBehavior.m
//  NNDecimalNumberDemo
//
//  Created by 顾海军 on 2019/9/5.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "DecimalNumberGlobalBehavior.h"

@implementation DecimalNumberGlobalBehavior

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
