//
//  NSString+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"
#import "NNDecimalNumberHandler.h"
#import <objc/runtime.h>

#pragma mark - NNDecimalNumberFormulaStack

@implementation NSString (NNDecimalNumberFormulaStack)

- (NSArray *)nn_formulaStack {
    NSArray *formulaStack = objc_getAssociatedObject(self, _cmd);
    return formulaStack;
}

- (void)setNn_formulaStack:(NSArray *)nn_formulaStack {
    objc_setAssociatedObject(self, @selector(nn_formulaStack), nn_formulaStack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


#pragma mark - NNDecimalNumber

typedef NS_ENUM(NSUInteger, NNDecimalNumberOperatorType) {
    NNDecimalNumberOperatorTypeAdd,
    NNDecimalNumberOperatorTypeSub,
    NNDecimalNumberOperatorTypeMul,
    NNDecimalNumberOperatorTypeDiv,
    NNDecimalNumberOperatorTypePower,
    NNDecimalNumberOperatorTypeMulPowerOf10,
};

static Class __nn_decimalNumberBehaviors;

@implementation NSString (NNDecimalNumber)

#pragma mark - NNDecimalNumberBehaviors
+ (void)nn_setDecimalNumberBehaviors:(Class)decimalNumberBehaviors {
    NSAssert([decimalNumberBehaviors conformsToProtocol:@protocol(NSDecimalNumberBehaviors)], @"DecimalNumberBehaviors must be conforms to protocol NSDecimalNumberBehaviors");
    __nn_decimalNumberBehaviors = decimalNumberBehaviors;
}

+ (Class)nn_decimalNumberBehaviors {
    if (__nn_decimalNumberBehaviors == nil) {
        __nn_decimalNumberBehaviors = [NNDecimalNumberHandler class];
    }
    return __nn_decimalNumberBehaviors;
}

#pragma mark - NNDecimalNumberFormula
- (NSString *)nn_formula {
    NSString *formula = __nn_formulaFromFormulaStack(self.nn_formulaStack);
    return formula;
}

#pragma mark - NNDecimalNumber
- (NSString *(^)(id))nn_add {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypeAdd left:self right:value];
    };
}

- (NSString *(^)(id))nn_sub {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypeSub left:self right:value];
    };
}

- (NSString *(^)(id))nn_mul {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypeMul left:self right:value];
    };
}

- (NSString *(^)(id))nn_div {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypeDiv left:self right:value];
    };
}

- (NSString *(^)(id))nn_power {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypePower left:self right:value];
    };
}

- (NSString *(^)(id))nn_mulPowerOf10 {
    return ^NSString *(id value) {
        return [self __nn_operatorWithType:NNDecimalNumberOperatorTypeMulPowerOf10 left:self right:value];
    };
}

- (NSString *)__nn_operatorWithType:(NNDecimalNumberOperatorType)type left:(NSString *)l right:(NSString *)r {
    
    NSString *lString = __nn_stringWithValue(l);
    NSString *rString = __nn_stringWithValue(r);
    
    NSDecimalNumber *lDecimal = [NSDecimalNumber decimalNumberWithString:lString];
    NSDecimalNumber *rDecimal = [NSDecimalNumber decimalNumberWithString:rString];
    NSDecimalNumber *retDecimal = [NSDecimalNumber notANumber];
    
    NSMutableArray *formulaStack = ({
        NSMutableArray *formulaStack = [NSMutableArray new];
        if (lString.nn_formulaStack) {
            [formulaStack addObjectsFromArray:lString.nn_formulaStack];
        }
        else {
            [formulaStack addObject:lString];
        }
        formulaStack;
    });
    
    switch (type) {
        case NNDecimalNumberOperatorTypeAdd:
            [formulaStack addObject:@"+"];
            retDecimal = [lDecimal decimalNumberByAdding:rDecimal withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
        case NNDecimalNumberOperatorTypeSub:
            [formulaStack addObject:@"-"];
            retDecimal = [lDecimal decimalNumberBySubtracting:rDecimal withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
        case NNDecimalNumberOperatorTypeMul:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"×"];
            retDecimal = [lDecimal decimalNumberByMultiplyingBy:rDecimal withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
        case NNDecimalNumberOperatorTypeDiv:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"÷"];
            retDecimal = [lDecimal decimalNumberByDividingBy:rDecimal withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
        case NNDecimalNumberOperatorTypePower:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"^"];
            retDecimal = [lDecimal decimalNumberByRaisingToPower:[rDecimal unsignedIntegerValue] withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
        case NNDecimalNumberOperatorTypeMulPowerOf10:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"× 10 ^"];
            retDecimal = [lDecimal decimalNumberByMultiplyingByPowerOf10:[rDecimal shortValue] withBehavior:[[[self class] nn_decimalNumberBehaviors] new]];
            break;
    }
    NSString *retString = [retDecimal stringValue];
    
    if (rString.nn_formulaStack) {
        [formulaStack addObject:rString.nn_formulaStack];
    }
    else {
        [formulaStack addObject:rString];
    }
    retString.nn_formulaStack = formulaStack;
    
    return retString;
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






