//
//  SMLAnimatedBarsView.m
//  SMLAnimatedBars
//
//  Created by Ivan Blagajić on 30/07/14.
//  Copyright (c) 2014 Simple Things. All rights reserved.
//

#import "SMLAnimatedBarsView.h"

@interface SMLBarView : UIView

@property (nonatomic) CGRect originalBarRect;
@property (nonatomic) CGFloat barAnimationVerticalInset;
@property (nonatomic) NSTimeInterval animationDuration;
@property (nonatomic) NSTimeInterval animationDelay;

@end

@implementation SMLBarView

@end

@interface SMLAnimatedBarsView ()

@property (nonatomic, strong) NSArray *bars;
@property (nonatomic) CGFloat percent;

@end

@implementation SMLAnimatedBarsView

#define barsValues @[@0.1, @0.5, @0.4, @0.6, @0.7, @0.4, @0.65, @0.55, @0.7, @0.65, @0.8, @0.55, @0.9, @0.8, @0.85, @0.2, @0.1, @0.7, @0.6, @0.65, @0.4, @0.6, @0.85, @0.3, @0.9, @0.55, @0.65, @0.6, @0.7, @0.55, @0.6, @0.7, @0.4, @0.95, @0.65, @0.6, @0.7, @0.55, @0.2, @0.5]
#define padding 2.0
#define margin 10.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBars];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self createBars];
}

- (void)createBars {
    
    NSMutableArray *barsMutableArray = [NSMutableArray new];
    CGSize viewSize = self.frame.size;
    CGFloat barWidth = (viewSize.width - 2*margin - ((barsValues.count-1)*padding))/barsValues.count;
    CGFloat maxBarHeight = viewSize.height - 2*padding;
    int counter = 0;
    for (NSNumber *value in barsValues) {
        CGFloat barHeight = maxBarHeight*value.floatValue;
        CGRect barFrame = CGRectMake(margin + counter*(padding+barWidth), (viewSize.height - barHeight)/2, barWidth, barHeight);
        SMLBarView *bar = [self barWithFrame:barFrame];
        [self addSubview:bar];
        [barsMutableArray addObject:bar];
        counter++;
    }
    self.bars = barsMutableArray;
}

- (SMLBarView*)barWithFrame:(CGRect)frame {
    
    CGRect minimizedBarFrame = frame;
    minimizedBarFrame = CGRectInset(minimizedBarFrame, 0, frame.size.height/2 - 1);
    SMLBarView *bar = [[SMLBarView alloc] initWithFrame:minimizedBarFrame];
    bar.backgroundColor = [UIColor blackColor];
    bar.barAnimationVerticalInset = frame.size.height * 0.3;
    bar.animationDuration = ((float)(arc4random()%100)/100)*0.25 + 0.35;
    bar.animationDelay = ((float)(arc4random()%100)/100)*0.2;
    bar.originalBarRect = frame;
    return bar;
}

- (void)animate {
    
    __weak SMLAnimatedBarsView *weakSelf = self;
    [self animateBarsToOriginalBarRectWithCompletion:^() {
        SMLAnimatedBarsView *strongSelf = weakSelf;
        [strongSelf startAnimatingBars];
    }];
}

- (void)animateBarsToOriginalBarRectWithCompletion:(void (^)())completionBlock {
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         for (SMLBarView *bar in self.bars) {
                             bar.frame = bar.originalBarRect;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (!finished) return;
                         if (completionBlock) {
                             completionBlock();
                         }
                     }];
}

- (void)startAnimatingBars {
    
    for (SMLBarView *bar in self.bars) {
        [UIView animateKeyframesWithDuration:bar.animationDuration
                                       delay:bar.animationDelay
                                     options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                                  animations:^{
                                      bar.frame = CGRectInset(bar.frame, 0, bar.barAnimationVerticalInset);
                                  }
                                  completion:^(BOOL finished) {

                                  }];
    }
}

- (void)stop {
    
    for (SMLBarView *bar in self.bars) {
        [bar.layer removeAllAnimations];
    }
    [UIView animateWithDuration:0.2
                     animations:^{
                         for (SMLBarView *bar in self.bars) {
                             CGRect minimizedBarFrame = CGRectInset(bar.frame, 0, bar.frame.size.height/2 - 1);
                             bar.frame = minimizedBarFrame;
                         }
                     }];
}

- (void)updateBarsToPercentage:(CGFloat)percent {
    
    if (self.percent == percent) return;
    
    NSInteger lastColoredBarIndex = self.bars.count*percent;
    for (SMLBarView *bar in self.bars) {
        if ([self.bars indexOfObject:bar] < lastColoredBarIndex) {
            bar.backgroundColor = [UIColor orangeColor];
        } else {
            bar.backgroundColor = [UIColor blackColor];
        }
    }
    
    self.percent = percent;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
