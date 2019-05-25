//
//  FHImageTextView.h
//  Grearn
//
//  Created by imac on 2018/4/11.
//  Copyright © 2018年 com.Genius.github. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FHImageTextType) {
    FHImageTextTypeTextLeft,
    FHImageTextTypeTextTop,
    FHImageTextTypeTextRight,
    FHImageTextTypeTextBottom
};

typedef NS_ENUM(NSInteger,FHImageTextContronState) {
    FHImageTextContronStateNormal,
    FHImageTextContronStateSelected
};

@interface FHImageTextView : UIView

- (instancetype)initWithType:(FHImageTextType)type;

@property (nonatomic,assign,readonly) FHImageTextType type;// default is TextLeft

@property (nonatomic,assign) UIEdgeInsets contentInsets;

@property (nonatomic,assign) CGFloat textImageSpace;

@property (nonatomic,assign,getter=isSelected) BOOL selected;

- (void)setImage:(UIImage *)image forState:(FHImageTextContronState)state;

- (void)setText:(NSString *)text forState:(FHImageTextContronState)state;

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(FHImageTextContronState)state;

- (void)configationImageTextView:(nullable void(^)(UIImageView *imageView,UILabel *label))configationHandle;

@end

NS_ASSUME_NONNULL_END
