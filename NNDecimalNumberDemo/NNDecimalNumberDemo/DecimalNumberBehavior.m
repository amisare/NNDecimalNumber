//
//  DecimalNumberBehavior.m
//  NNDecimalNumberDemo
//
//  Created by 顾海军 on 2019/9/5.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "DecimalNumberBehavior.h"

@implementation DecimalNumberBehavior

- (nullable NSDecimalNumber *)exceptionDuringOperation:(nonnull SEL)operation error:(NSCalculationError)error leftOperand:(nonnull NSDecimalNumber *)leftOperand rightOperand:(nullable NSDecimalNumber *)rightOperand {
    return [NSDecimalNumber notANumber];
}

- (NSRoundingMode)roundingMode {
    return NSRoundPlain;
}

- (short)scale {
    return 3;
}


@end
