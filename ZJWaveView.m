//
//  ZJWaveView.m
//  OC_Project
//
//  Created by 小黎 on 2018/11/22.
//  Copyright © 2018年 ZJ. All rights reserved.
//

#import "ZJWaveView.h"

@interface ZJWaveView ()

@end

@implementation ZJWaveView
-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [[self backgroundColor] setFill]; //
    UIRectFill(rect);
    NSInteger pulsingCount = 3; // 波纹数
    double animationDuration = 6; // 波纹扩散速度
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < pulsingCount; i++) {
        // 创建波纹
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        pulsingLayer.cornerRadius = rect.size.height / 2.0;
        pulsingLayer.borderColor = [UIColor whiteColor].CGColor;
        pulsingLayer.borderWidth = 1;
        
        //
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        // 动画组
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        // 动画(缩放)
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.0; // 波纹内圈倍数
        scaleAnimation.toValue = @1.6;   // 波纹外圈倍数
        
        // 渐变动画（values和keyTimes一一对应）
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];// 渐变
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];// 时间
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
}
@end
