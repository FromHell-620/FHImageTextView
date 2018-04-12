//
//  FHImageTextView.h
//  Grearn
//
//  Created by imac on 2018/4/11.
//  Copyright © 2018年 com.Genius.github. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHImageTextView : UIView

/**
 initialize a image-text view

 @param image normal image .
 @param text normal text
 @return a instance .
 */
- (instancetype)initWithImage:(nullable UIImage *)image text:(nullable NSString *)text;

@property (nonatomic,assign,getter=isSelected) BOOL selected;

@property (nonatomic,strong,nullable) UIImage *image;

@property (nonatomic,copy,nullable) NSString *text;

@property (nonatomic,strong,nullable) UIImage *selectedImage;

@property (nonatomic,copy,nullable) NSString *selectedText;

@property (nonatomic,strong,nullable) UIImage *backgroundImage;

@property (nonatomic,strong,nullable) UIImage *selectedBackgroundImage;

- (void)configationImageTextView:(nullable void(^)(UIImageView *imageView,UILabel *label))configationHandle;

@end

NS_ASSUME_NONNULL_END
