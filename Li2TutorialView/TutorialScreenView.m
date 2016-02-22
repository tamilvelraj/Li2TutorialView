//
//  TutorialScreenView.m
//  zohoforms
//
//  Created by ZOHOCORP\thamil-1041 on 02/08/13.
//  Copyright (c) 2013 zohocorp. All rights reserved.
//

#import "TutorialScreenView.h"
#import "AppDelegate.h"

@interface TutorialScreenView() {
    UIFont *titleFont;
    CGFloat defaultTitleHeight;
    NSMutableArray *arrowItems;
}

@end

@implementation TutorialScreenView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.8f];
        titleFont=TUTORIAL_FONT;
        defaultTitleHeight=0.0f;
        arrowItems=[[NSMutableArray alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(void)tapOut:(UIGestureRecognizer*)gestureRecognizer {
    //CGPoint p = [gestureRecognizer locationInView:self];
    [self clearTutorial];
}

-(TutorialScreenArrowType)arrowTypeForPoint:(CGPoint)arwpoint {
    
    CGFloat arrowPointX=arwpoint.x;
    CGFloat arrowPointY=arwpoint.y;
    
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    CGFloat screenWidth=screenSize.width;
    CGFloat screenHeight=screenSize.height;
    
    if (arrowPointX <= screenWidth/2 && arrowPointY <= screenHeight/2) {
        return ARROW_UP_LEFT;
    }
    else if (arrowPointX>=screenWidth/2 && arrowPointY<=screenHeight/2) {
        return ARROW_UP_RIGHT;
    }
    else if (arrowPointX<=screenWidth/2 && arrowPointY>=screenHeight/2) {
        return ARROW_DOWN_LEFT;
    }
    else if (arrowPointX >= screenWidth/2 && arrowPointY >= screenHeight/2) {
        return ARROW_DOWN_RIGHT;
    }
    
    return ARROW_UP_RIGHT;
}

-(void)showTutorial {
    for (int i=0; i < arrowItems.count; i++) {
        UILabel *titlelbl=[[arrowItems objectAtIndex:i] objectForKey:ARROW_TITLE_LABEL];
        UIImageView *arrowImgview=[[arrowItems objectAtIndex:i] objectForKey:ARROW_IMAGEVIEW];
        [self addSubview:titlelbl];
        [self addSubview:arrowImgview];
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

-(void)clearTutorial {
    [self removeFromSuperview];
}

-(void)addArrowAtPoint:(CGPoint)arwpoint arrowDirection:(TutorialScreenArrowType)arrowDirectionType forTitle:(NSString*)title {
    
    //TitleLabel creation.
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.numberOfLines=10;
    titleLabel.text=title;
    titleLabel.font=titleFont;
    titleLabel.textColor=TUTORIAL_TITLE_COLOR;
    titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    titleLabel.textAlignment=NSTextAlignmentLeft;
    
    //[self addSubview:titleLabel];
    
    UIImage *arwImg=[UIImage animatedResizableImageNamed:ARROW_UP_RIGHT_IMG_NAME capInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch duration:0.3];
    CGRect arwImgRect=CGRectZero;
    
    if (arrowDirectionType==ARROW_UP_RIGHT) {
        arwImg=[UIImage imageNamed:ARROW_UP_RIGHT_IMG_NAME];
        CGSize arwImgSize=[arwImg size];
        arwImgRect=CGRectMake(arwpoint.x-arwImgSize.width, arwpoint.y, arwImgSize.width, arwImgSize.height);
        CGRect titleRect= [self rectForTitleFromArrowRect:arwImgRect direction:arrowDirectionType titleText:title];
        titleLabel.frame=titleRect;
    }
    else if (arrowDirectionType==ARROW_UP_LEFT) {
        arwImg=[UIImage imageNamed:ARROW_UP_LEFT_IMG_NAME];
        CGSize arwImgSize=[arwImg size];
        arwImgRect=CGRectMake(arwpoint.x, arwpoint.y, arwImgSize.width, arwImgSize.height);
        CGRect titleRect= [self rectForTitleFromArrowRect:arwImgRect direction:arrowDirectionType titleText:title];
        titleLabel.frame=titleRect;
    }
    else if (arrowDirectionType==ARROW_DOWN_RIGHT) {
        arwImg=[UIImage imageNamed:ARROW_DOWN_RIGHT_IMG_NAME];
        CGSize arwImgSize=[arwImg size];
        arwImgRect=CGRectMake(arwpoint.x-arwImgSize.width, arwpoint.y, arwImgSize.width, arwImgSize.height);
        CGRect titleRect= [self rectForTitleFromArrowRect:arwImgRect direction:arrowDirectionType titleText:title];
        titleLabel.frame=titleRect;
    }
    else if (arrowDirectionType==ARROW_DOWN_LEFT) {
        arwImg=[UIImage imageNamed:ARROW_DOWN_LEFT_IMG_NAME];
        CGSize arwImgSize=[arwImg size];
        arwImgRect=CGRectMake(arwpoint.x, arwpoint.y, arwImgSize.width, arwImgSize.height);
        CGRect titleRect= [self rectForTitleFromArrowRect:arwImgRect direction:arrowDirectionType titleText:title];
        titleLabel.frame=titleRect;
    }
    
    UIImageView *arwImgview=[[UIImageView alloc] initWithFrame:arwImgRect];
    arwImgview.image=arwImg;
    
    //Add view items into arrowItems array.
    NSMutableDictionary *arrowViewDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:titleLabel,ARROW_TITLE_LABEL,arwImgview,ARROW_IMAGEVIEW, nil];
    [arrowItems addObject:arrowViewDict];
}

-(void)addArrowAtPoint:(CGPoint)arwpoint forTitle:(NSString*)title {
    TutorialScreenArrowType arrowDirectionType=[self arrowTypeForPoint:arwpoint];
    [self addArrowAtPoint:arwpoint arrowDirection:arrowDirectionType forTitle:title];
}

-(CGRect)rectForTitleFromArrowRect:(CGRect)arrowRect direction:(TutorialScreenArrowType)arwDirection titleText:(NSString*)title {
    CGFloat arrowX=arrowRect.origin.x;
    CGFloat arrowY=arrowRect.origin.y;
    CGFloat arrowW=arrowRect.size.width;
    CGFloat arrowH=arrowRect.size.height;
        
    CGSize screenSize=[[UIScreen mainScreen]bounds].size;
    CGFloat screenmark1=(screenSize.width/2)-(screenSize.width/4);  //  |<-------------- |(screenmark1) * (screenmark2)| ------------->|
    CGFloat screenmark2=(screenSize.width/2)+(screenSize.width/4);  //  |<----------------------DEVICE_SCREEN------------------------->|
    
    CGRect titleRect=CGRectZero;
    
    if (arrowX < screenmark1) {
        titleRect=CGRectMake(arrowX+arrowW, arrowY+arrowH, screenSize.width-(arrowX+arrowW), defaultTitleHeight);
    }
    else if(arrowX > screenmark2) {
        titleRect=CGRectMake(5, arrowY+arrowH, arrowX, defaultTitleHeight);
    }
    else if(arrowX >=screenmark1) {
        titleRect=CGRectMake(screenmark1, arrowY+arrowH, screenSize.width-screenmark1, defaultTitleHeight);
    }
    else if(arrowX <=screenmark2) {
        titleRect=CGRectMake(screenSize.width-screenmark2, arrowY+arrowH, screenSize.width-screenmark1, defaultTitleHeight);
    }
    
    CGSize titleSize=[self titleViewHeightForString:title inSize:titleRect.size];


    if (arwDirection==ARROW_UP_LEFT) {
        titleRect.origin.y=arrowY+arrowH;
        titleRect.size.height=titleSize.height;
    }
    else if(arwDirection==ARROW_UP_RIGHT) {
        titleRect.origin.x=arrowX-titleSize.width;

        if (titleRect.origin.x < 10.0f) {  //minimalLeftAlignTitle x position.
            titleRect.origin.x=10.0f;
        }
        
        titleRect.origin.y=arrowY+arrowH;
        titleRect.size.height=titleSize.height;
    }
    else if(arwDirection==ARROW_DOWN_LEFT) {
        titleRect.origin.y=arrowY-titleSize.height;
        titleRect.size.height=titleSize.height;
    }
    else if(arwDirection==ARROW_DOWN_RIGHT) {
        titleRect.origin.x=arrowX-titleSize.width;
        if (titleRect.origin.x < 10.0f) {  //minimalLeftAlignTitle x position.
            titleRect.origin.x=10.0f;
        }
        titleRect.origin.y=arrowY-titleSize.height;
        titleRect.size.height=titleSize.height;
    }
    
    return titleRect;
}

- (CGSize)titleViewHeightForString:(NSString*)string1 inSize:(CGSize)size
{
    CGSize boundingSize = CGSizeMake(size.width, 10000);
    CGSize requiredSize = [string1 sizeWithFont:titleFont constrainedToSize:boundingSize lineBreakMode:NSLineBreakByWordWrapping];
    return requiredSize;
}

@end
