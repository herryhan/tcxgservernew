//
//  commentsTableViewCell.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/9.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "commentsTableViewCell.h"

@implementation commentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.replyBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
- (IBAction)resBtnPress:(UIButton *)sender {
    _res(YES);
}

- (void)setModel:(commentsModel *)model{
    self.commentTime.text = [NSString stringWithFormat:@"%@",model.time];
    self.commentScore.text =[NSString stringWithFormat:@"评分：%@",model.score];
    self.commentContent.text = model.txt;
    if (model.res.length == 0) {
//        self.resLabel.text =@"可划分空间丰富我空间访问空间我空间氛围开发各位看完金额分为看了几分金额看我来看我减肥王俊凯刘恺威 u 氛围";
        
        self.replyBtn.hidden = NO;
        self.resLabel.hidden = YES;
        self.resTitleLabel.hidden = YES;
        self.bottomConstraint.constant = 32;
        NSLog(@"ddddddddddddddd");
        
    }else{
        NSLog(@"ffffffffff");
        self.resLabel.text = model.res;
        self.resLabel.hidden = NO;
        self.replyBtn.hidden = YES;
        self.resTitleLabel.hidden = NO;
         self.bottomConstraint.constant = 12;
       
        
    }
}
@end
