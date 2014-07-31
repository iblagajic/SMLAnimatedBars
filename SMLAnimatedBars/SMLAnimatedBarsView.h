//
//  SMLAnimatedBarsView.h
//  SMLAnimatedBars
//
//  Created by Ivan Blagajić on 30/07/14.
//  Copyright (c) 2014 Simple Things. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMLAnimatedBarsView : UIView

- (void)animate;
- (void)stop;
- (void)updateBarsToPercentage:(CGFloat)percent;

@end
