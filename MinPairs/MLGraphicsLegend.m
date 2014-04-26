//
//  MLGraphicsLegend.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLGraphicsLegend.h"

@interface MLGraphicsLegend ()
@property (nonatomic, weak) MLGraphics* graphics;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) Colour titleColour;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, strong) NSMutableDictionary* items;
@property (nonatomic, strong) Colour bgColour;
@property (nonatomic, strong) Colour outlnColour;
@end


@implementation MLGraphicsLegend
-(MLGraphicsLegend*)init:(MLGraphics*)graphics
{
    self = [super init];
    if (self)
    {
        _graphics = graphics;
        _items = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) setOutlineColour:(Colour)outlineColour
{
    self.outlnColour = outlineColour;
}

-(void) setOutlineColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    self.outlnColour = [[self graphics] CreateColour:R withGreen:G withBlue:B withAlpha:A];
}

-(void) setBackgroundColour:(Colour)colour
{
    self.bgColour = colour;
}

-(void) setBackgroundColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    self.bgColour = [[self graphics] CreateColour:R withGreen:G withBlue:B withAlpha:A];
}

-(void) setTitle:(NSString*)title withColour:(Colour)colour
{
    _title = title;
    _titleColour = colour;
}

-(void) addItem:(NSString*)text withColour:(Colour)colour
{
    [[self items] setObject: colour forKey: text];
}

-(void) addItem:(NSString*)text withRed:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    [[self items] setObject: [[self graphics] CreateColour: R withGreen: G withBlue: B withAlpha: A] forKey: text];
}

-(void) setDimensions:(CGRect)rect
{
    self.bounds = rect;
}

-(void) setDimensions:(float)X withY:(float)Y withWidth:(float)Width withHeight:(float)Height
{
    self.bounds = CGRectMake(X, Y, Width, Height);
    
}

-(void) draw
{
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float w = self.bounds.size.width;
    //float h = self.bounds.size.height;
    
    float titlex = x + 20;
    float titley = y + 5;
    float itemVerticalSpace = 15.0f;
    
    
    Font font = [[self graphics] CreateFont: @"Arial" withSize: 10.0f];
    
    [[self graphics] SetStrokeColour: [self outlnColour]];
    [[self graphics] SetFillColour: [self bgColour]];
    [[self graphics] DrawRoundedRect: 5.0f withRect: [self bounds]];

    
    [[self graphics] SetStrokeColour: [self titleColour]];
    [[self graphics] SetFillColour: [self titleColour]];
    [[self graphics] DrawText: font withText:[self title] withX: titlex withY: titley];
    
    [[self graphics] BeginDrawing];
    [[self graphics] DrawLine: titlex - 15 withY1: titley + 18 withX2: x + w - 5 withY2: titley + 18];
    [[self graphics] EndDrawing];
    
    titlex -= 10;
    titley += 13;
    
    for (NSString* text in [self items])
    {
        Colour colour = [[self items] objectForKey: text];
        
        [[self graphics] SetStrokeColour: colour];
        [[self graphics] SetFillColour: colour];
        [[self graphics] BeginDrawing];
        [[self graphics] DrawCircle: titlex withY: titley + itemVerticalSpace + 7 withRadius: 1];
        [[self graphics] EndDrawing];
        [[self graphics] DrawText: font withText: text withX: titlex + 10 withY: titley += itemVerticalSpace];
    }
}
@end
