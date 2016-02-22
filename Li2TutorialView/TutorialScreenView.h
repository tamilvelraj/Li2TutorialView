//
//  TutorialScreenView.h
//  zohoforms
//
//  Created by ZOHOCORP\thamil-1041 on 02/08/13.
//  Copyright (c) 2013 zohocorp. All rights reserved.
//

#import <UIKit/UIKit.h>

//CUSTOM TUTORIAL CONFIGURATION INFO
//You can use your own arrow images too.
#define ARROW_UP_LEFT_IMG_NAME @"arrow-toplft.png"
#define ARROW_UP_RIGHT_IMG_NAME @"arrow-toprgt.png"
#define ARROW_DOWN_LEFT_IMG_NAME @"arrow-btmlft.png"
#define ARROW_DOWN_RIGHT_IMG_NAME @"arrow-btmrgt.png"

#define TUTORIAL_FONT [UIFont fontWithName:@"AmericanTypewriter" size:15]
#define TUTORIAL_TITLE_COLOR [UIColor colorWithRed:0.984 green:0.831 blue:0.000 alpha:1.000]

typedef enum{
	ARROW_UP_LEFT = 0,
    ARROW_UP_RIGHT,
	ARROW_DOWN_LEFT,
	ARROW_DOWN_RIGHT
} TutorialScreenArrowType;

#define ARROW_TITLE_LABEL @"ARROW_TITLE_LABEL"
#define ARROW_IMAGEVIEW @"ARROW_IMAGEVIEW"

@interface TutorialScreenView : UIView 
-(void)addArrowAtPoint:(CGPoint)arwpoint forTitle:(NSString*)title;
-(void)addArrowAtPoint:(CGPoint)arwpoint arrowDirection:(TutorialScreenArrowType)arrowDirectionType forTitle:(NSString*)title;
-(void)showTutorial;
-(void)clearTutorial;
@end
