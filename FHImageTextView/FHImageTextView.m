//
//  FHImageTextView.m
//  Grearn
//
//  Created by imac on 2018/4/11.
//  Copyright © 2018年 com.Genius.github. All rights reserved.
//

#import "FHImageTextView.h"
#import <Masonry/Masonry.h>

@interface FHImageTextView ()

@property (nonatomic,strong) NSMutableArray *contents;

@end

@implementation FHImageTextView {
    @private
    UIImageView *_backgroundImageView;
    UIImageView *_imageView;
    UILabel *_textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupSubViews];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __setupSubViews];
    }
    return self;
}

- (instancetype)initWithType:(FHImageTextType)type {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        _type = type;
        [self __setupSubViewslayout];
    }
    return self;
}

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray arrayWithObjects:NSNull.null,NSNull.null,NSNull.null,NSNull.null,NSNull.null,NSNull.null, nil];
    }
    return _contents;
}

#pragma mark- private

- (void)__setupSubViews {
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeCenter;
    [_backgroundImageView addSubview:_imageView];
    
    _textLabel = [UILabel new];
    [_backgroundImageView addSubview:_textLabel];
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
}

- (void)__setupSubViewslayout {
    switch (self.type) {
        case FHImageTextTypeTextLeft: {
            [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.offset(0);
            }];
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.offset(0);
                make.width.equalTo(_imageView.mas_height);
                make.left.equalTo(_textLabel.mas_right).offset(4);
            }];
        } break;
            
        case FHImageTextTypeTextTop: {
            [_textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.offset(0);
            }];
            [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.equalTo(_textLabel.mas_bottom).offset(4);
                make.bottom.offset(0);
            }];
        } break;
            
        case FHImageTextTypeTextRight: {
            [_textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.right.offset(0);
                make.left.equalTo(_imageView.mas_right).offset(4);
            }];
            
            [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.offset(0);
                make.width.equalTo(_imageView.mas_height);
            }];
        } break;
            
        case FHImageTextTypeTextBottom: {
            [_textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.bottom.offset(0);
                make.top.equalTo(_imageView.mas_bottom).offset(4);
            }];
            
            [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.offset(0);
            }];
        }
            
        default:
            break;
    }
}

- (id)_getContentAtIndex:(NSInteger)idx {
    return NSNull.null == self.contents[idx] ? nil : self.contents[idx];
}

- (UIImage *)_getCurrentImage {
    id image = [self _getContentAtIndex:self.isSelected];
    return image == nil && self.isSelected == YES ? [self _getContentAtIndex:0] : image;
}

- (NSString *)_getCurrentText {
    id text = [self _getContentAtIndex:self.isSelected + 2];
    return text == nil && self.isSelected == YES ? [self _getContentAtIndex:2] : text;
}

- (UIImage *)_getCurrentBackgroundImage {
    id image = [self _getContentAtIndex:self.isSelected + 4];
    return image == nil && self.isSelected == YES ? [self _getContentAtIndex:4] : image;
}

#pragma mark- public
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsUpdateConstraints];
}

- (void)setTextImageSpace:(CGFloat)textImageSpace {
    _textImageSpace = textImageSpace;
    [self setNeedsUpdateConstraints];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image forState:(FHImageTextContronState)state {
    NSCParameterAssert(image);
    [self.contents replaceObjectAtIndex:state withObject:image];
    _imageView.image = [self _getCurrentImage];
}

- (void)setText:(NSString *)text forState:(FHImageTextContronState)state {
    NSCParameterAssert(text);
    NSInteger index = state + 2;
    [self.contents replaceObjectAtIndex:index withObject:text];
    _textLabel.text = [self _getCurrentText];
    [self setNeedsUpdateConstraints];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forState:(FHImageTextContronState)state {
    NSCParameterAssert(backgroundImage);
    NSInteger index = state + 4;
    [self.contents replaceObjectAtIndex:index withObject:backgroundImage];
    _backgroundImageView.image = [self _getCurrentBackgroundImage];
}

- (void)configationImageTextView:(void (^)(UIImageView * _Nonnull, UILabel * _Nonnull))configationHandle {
    if (configationHandle) {
        configationHandle(_imageView,_textLabel);
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _imageView.image = [self _getCurrentImage];
    _textLabel.text = [self _getCurrentText];
    _backgroundImageView.image = [self _getCurrentBackgroundImage];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    CGSize textSize = [_textLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textSize.width);
    }];
    [_backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(self.contentInsets);
    }];
    switch (self.type) {
        case FHImageTextTypeTextLeft: {
            [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_textLabel.mas_right).offset(self.textImageSpace);
            }];
        } break;

        case FHImageTextTypeTextTop: {
            [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_textLabel.mas_bottom).offset(self.textImageSpace);
            }];
        } break;
        
        case FHImageTextTypeTextRight: {
            [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_imageView.mas_right).offset(self.textImageSpace);
            }];
        } break;
            
        case FHImageTextTypeTextBottom: {
            [_textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imageView.mas_bottom).offset(self.textImageSpace);
            }];
        }
        default:
            break;
    }
    [self sizeToFit];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
