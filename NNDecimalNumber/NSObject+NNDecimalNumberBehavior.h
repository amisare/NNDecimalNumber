//
//  NSObject+NNDecimalNumberBehavior.h
//  NNDecimalNumber
//
//  Created by 顾海军 on 2019/9/26.
//  Copyright © 2019 HaiJun Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NNDecimalNumberBehavior)

/// NSDecimalNumber 运算规则
@property (nonatomic, strong) id<NSDecimalNumberBehaviors> nn_decimalNumberBehavior;

@end
