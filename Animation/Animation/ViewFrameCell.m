//
//  ViewFrameCell.m
//  Animation
//
//  Created by ike on 2017/11/6.
//  Copyright © 2017年 ike. All rights reserved.
//

#import "ViewFrameCell.h"

@interface ViewFrameCell (){
    CGFloat selfHeight;
}

@end
@implementation ViewFrameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    selfHeight = self.frame.size.height;
}

-(void)setFrame:(CGRect)frame{
    if (self.bottomHeight != 0) {
        self.separatorInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, 0);
    }
    if (selfHeight - frame.size.height != self.bottomHeight) {
        frame.size.height -= self.bottomHeight;
    }
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
