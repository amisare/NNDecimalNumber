//
//  NSObject+NNDecimalNumberBehavior.m
//  NNDecimalNumber
//
//  Created by 顾海军 on 2019/9/26.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import "NSObject+NNDecimalNumberBehavior.h"
#import <objc/runtime.h>

@implementation NSObject (NNDecimalNumberBehavior)

- (id<NSDecimalNumberBehaviors>)nn_decimalNumberBehavior {
    id<NSDecimalNumberBehaviors> behavior = objc_getAssociatedObject(self, _cmd);
    return behavior;
}

- (void)setNn_decimalNumberBehavior:(id<NSDecimalNumberBehaviors>)nn_decimalNumberBehavior {
    objc_setAssociatedObject(self, @selector(nn_decimalNumberBehavior), nn_decimalNumberBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
