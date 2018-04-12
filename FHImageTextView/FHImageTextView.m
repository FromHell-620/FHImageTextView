//
//  FHImageTextView.m
//  Grearn
//
//  Created by imac on 2018/4/11.
//  Copyright © 2018年 com.Genius.github. All rights reserved.
//

#import "FHImageTextView.h"

@implementation FHImageTextView {
    @protected
    UIImageView *_backgroundImageView;
    UIImageView *_imageView;
    UILabel *_textLabel;
}

- (instancetype)initWithImage:(UIImage *)image text:(NSString *)text {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _image = image;
        _text = text;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupSubViews];
    }
    return self;
}

#pragma mark- private

- (void)__setupSubViews {
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    _imageView = [UIImageView new];
    [_backgroundImageView addSubview:_imageView];
    
    _textLabel = [UILabel new];
    _textLabel.textColor = [UIColor colorWithRed:74 green:74 blue:74 alpha:1];
    _textLabel.font = [UIFont systemFontOfSize:12];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundImageView addSubview:_textLabel];
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10);
        make.width.height.mas_equalTo(22);
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-6);
        make.height.mas_equalTo(13);
    }];
    
    [self __configContent];
}

- (void)__configContent {
    if (self.isSelected) {
        self.selectedImage = self.selectedImage ? : self.image;
        self.selectedText = self.selectedText ? : self.text;
        self.selectedBackgroundImage = self.selectedBackgroundImage ? : self.backgroundImage;
        _imageView.image = self.selectedImage;
        _textLabel.text = self.selectedText;
        _backgroundImageView.image = self.selectedBackgroundImage;
    }else {
        self.image = self.image ?: self.selectedImage;
        self.text = self.text ?: self.selectedText;
        self.backgroundImage = self.backgroundImage ?: self.selectedBackgroundImage;
        _backgroundImageView.image = self.backgroundImage;
        _imageView.image = self.image;
        _textLabel.text = self.text;
    }
}

#pragma mark- public
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)configationImageTextView:(void (^)(UIImageView * _Nonnull, UILabel * _Nonnull))configationHandle {
    if (configationHandle) {
        configationHandle(_imageView,_textLabel);
    }
}

- (void)drawRect:(CGRect)rect {
    [self __configContent];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
