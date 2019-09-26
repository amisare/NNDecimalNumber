//
//  NSObject+NNDecimalNumberFormulaStack.m
//  NNDecimalNumber
//
//  Created by 顾海军 on 2019/9/26.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NSObject+NNDecimalNumberFormulaStack.h"
#import <objc/runtime.h>

@implementation NSObject (NNDecimalNumberFormulaStack)

- (NSArray *)nn_formulaStack {
    NSArray *formulaStack = objc_getAssociatedObject(self, _cmd);
    return formulaStack;
}

- (void)setNn_formulaStack:(NSArray *)nn_formulaStack {
    objc_setAssociatedObject(self, @selector(nn_formulaStack), nn_formulaStack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
