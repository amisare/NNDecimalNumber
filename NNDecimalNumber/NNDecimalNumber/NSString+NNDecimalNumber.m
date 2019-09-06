//
//  NSString+NNDecimalNumber.m
//  NNDecimalNumber
//
//  Created by GuHaijun on 2019/4/24.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NNDecimalNumber.h"
#import "NNDecimalNumberInternal.h"
#import "NNDecimalNumberDefaultBehavior.h"
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


@implementation NSString (NNDecimalNumberBehavior)

- (id<NSDecimalNumberBehaviors>)nn_decimalNumberBehavior {
    id<NSDecimalNumberBehaviors> behavior = objc_getAssociatedObject(self, _cmd);
    return behavior;
}

- (void)setNn_decimalNumberBehavior:(id<NSDecimalNumberBehaviors>)nn_decimalNumberBehavior {
    objc_setAssociatedObject(self, @selector(nn_decimalNumberBehavior), nn_decimalNumberBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

static Class __nn_decimalNumberGlobalBehavior;

@implementation NSString (NNDecimalNumber)

#pragma mark - NNDecimalNumberGlobalBehavior
+ (Class)nn_decimalNumberGlobalBehavior {
    if (__nn_decimalNumberGlobalBehavior == nil) {
        __nn_decimalNumberGlobalBehavior = [NNDecimalNumberDefaultBehavior class];
    }
    return __nn_decimalNumberGlobalBehavior;
}

+ (void)nn_setDecimalNumberGlobalBehavior:(Class)decimalNumberGlobalBehavior {
    NSAssert([decimalNumberGlobalBehavior conformsToProtocol:@protocol(NSDecimalNumberBehaviors)], @"DecimalNumberGlobalBehavior must be conforms to protocol NSDecimalNumberBehaviors");
    __nn_decimalNumberGlobalBehavior = decimalNumberGlobalBehavior;
}

#pragma mark - NNDecimalNumberFormula
- (NSString *)nn_formula {
    NSString *formula = __nn_formulaFromFormulaStack(self.nn_formulaStack);
    return formula;
}

#pragma mark - NNDecimalNumberBehavior
- (NSString *(^)(id <NSDecimalNumberBehaviors>))nn_behavior {
    return ^NSString *(id <NSDecimalNumberBehaviors> behavior) {
        if (![[self class] isKindOfClass:[NSMutableString class]]) {
            NSMutableString *value = [NSMutableString stringWithString:self];
            value.nn_decimalNumberBehavior = behavior;
            value.nn_formulaStack = self.nn_formulaStack;
            return value;
        }
        else {
            self.nn_decimalNumberBehavior = behavior;
            return self;
        }
    };
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

- (NSString *)__nn_operatorWithType:(NNDecimalNumberOperatorType)type left:(id)l right:(id)r {
    
    NSString *lString = NN_Trust(l);
    NSString *rString = NN_Trust(r);
    
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
    
    id <NSDecimalNumberBehaviors> behavior = ({
        id <NSDecimalNumberBehaviors> behavior = [[[self class] nn_decimalNumberGlobalBehavior] new];
        if (lString.nn_decimalNumberBehavior != nil) {
            behavior = lString.nn_decimalNumberBehavior;
        }
        behavior;
    });
    
    switch (type) {
        case NNDecimalNumberOperatorTypeAdd:
            [formulaStack addObject:@"+"];
            retDecimal = [lDecimal decimalNumberByAdding:rDecimal withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeSub:
            [formulaStack addObject:@"-"];
            retDecimal = [lDecimal decimalNumberBySubtracting:rDecimal withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeMul:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"×"];
            retDecimal = [lDecimal decimalNumberByMultiplyingBy:rDecimal withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeDiv:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"÷"];
            retDecimal = [lDecimal decimalNumberByDividingBy:rDecimal withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypePower:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"^"];
            retDecimal = [lDecimal decimalNumberByRaisingToPower:[rDecimal unsignedIntegerValue] withBehavior:behavior];
            break;
        case NNDecimalNumberOperatorTypeMulPowerOf10:
            if (lString.nn_formulaStack != nil) {
                formulaStack = [NSMutableArray arrayWithObject:formulaStack];
            }
            [formulaStack addObject:@"× 10 ^"];
            retDecimal = [lDecimal decimalNumberByMultiplyingByPowerOf10:[rDecimal shortValue] withBehavior:behavior];
            break;
    }
    
    NSString *retString = [NSMutableString stringWithString:[retDecimal stringValue]];
    
    retString.nn_decimalNumberBehavior = behavior;
    
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






