//
//  AnimationVC.m
//  抖动动画
//
//  Created by KnowChat03 on 2019/10/24.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

#import "AnimationVC.h"

#define ANGLE_TO_RADIAN(angle) ((angle)/180.0 * M_PI)
@interface AnimationVC ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
@property(nonatomic, assign)CGFloat intervalTime;//开始动画的时间
@property(nonatomic, assign)CGFloat continueTime;//持续动画的时间
@property(nonatomic, assign)NSInteger shakeFrequency;//抖动次数

@end

@implementation AnimationVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.intervalTime = 0.0;
    self.continueTime = 2;
    self.shakeFrequency = 3;
    [_btnFirst addTarget:self action:@selector(firstEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self groupAniamtion];
}

-(void)groupAniamtion{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.btnFirst.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        CAKeyframeAnimation *keyframeAnimation=[self stratAnmation];
        keyframeAnimation.delegate = self;
        [self.btnFirst.layer addAnimation:keyframeAnimation forKey:@"stratAnmation"];
    }];
   
}
- (CAKeyframeAnimation *)stratAnmation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //拿到动画 key
    anim.keyPath =@"transform.rotation";
    anim.duration= (self.continueTime-0.3)/self.shakeFrequency;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    // 重复的次数
    anim.repeatCount = self.shakeFrequency;
    //设置抖动数值
    anim.values =@[@(ANGLE_TO_RADIAN(0)),@(ANGLE_TO_RADIAN(-17)),@(ANGLE_TO_RADIAN(17)),@(ANGLE_TO_RADIAN(0))];
    // 保持最后的状态
    anim.removedOnCompletion =NO;
    //动画的填充模式
    anim.fillMode =kCAFillModeForwards;
    return anim;
}

//-(CAKeyframeAnimation *)scaleAnimation
//{
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    //拿到动画 key
//    anim.keyPath =@"transform.scale";
//
//    anim.duration = 0.5;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
//    // 重复的次数
//    anim.repeatCount = 1;
//    //设置抖动数值
//    anim.values =@[@(1.0),@(1.1),@(1.2)];
//    // 保持最后的状态
//    anim.removedOnCompletion =NO;
//    //动画的填充模式
//    anim.fillMode =kCAFillModeForwards;
//    return anim;
//}

//-(CAKeyframeAnimation *)backScaleAnimation
//{
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    //拿到动画 key
//    anim.keyPath =@"transform.scale";
//
//    anim.duration = 0.5;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
//    // 重复的次数
//    anim.repeatCount = 1;
//    //设置抖动数值
//    anim.values =@[@(1.0),@(1.1),@(1.2)];
//    // 保持最后的状态
//    anim.removedOnCompletion =NO;
//    //动画的填充模式
//    anim.fillMode =kCAFillModeForwards;
//    return anim;
//}

#pragma mark -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([self.btnFirst.layer animationForKey:@"stratAnmation"] == anim) {
         [self.btnFirst.layer removeAnimationForKey:@"stratAnmation"];
        [UIView animateWithDuration:0.5 animations:^{
            self.btnFirst.transform = CGAffineTransformIdentity;
        }];
    }

}
-(void)removeAnmation{
    
    if ([self.btnFirst.layer animationForKey:@"stratAnmation"]) {
        [self.btnFirst.layer removeAnimationForKey:@"stratAnmation"];
    }
    
}

#pragma mark -
- (void)firstEvent:(UIButton *)btn
{
    [self groupAniamtion];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
