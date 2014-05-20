//
//  MLBarGraphView.m
//  MinPairs
//
//  Created by Brandon on 2014-05-20.
//  Copyright (c) 2014 Brandon. All rights reserved.
//

#import "MLBarGraphView.h"

@interface MLBarGraphView()
@property (nonatomic, strong) CPTXYGraph* graph;
@property (nonatomic, strong) NSMutableDictionary* graphData;
@end

@implementation MLBarGraphView

-(void)awakeFromNib
{
    self.graphData = [[NSMutableDictionary alloc] init];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    
    [[self graphData] setObject: [NSNumber numberWithInteger: 10] forKey: [dateFormatter dateFromString: @"03/26/1990"]];
    [[self graphData] setObject:[NSNumber numberWithInteger: 5] forKey: [dateFormatter dateFromString: @"04/26/1990"]];
    [[self graphData] setObject:[NSNumber numberWithInteger: 3] forKey: [dateFormatter dateFromString: @"05/26/1990"]];
    [[self graphData] setObject:[NSNumber numberWithInteger: 7] forKey: [dateFormatter dateFromString: @"06/26/1990"]];
}

- (void)createGraph
{
    /** Create graph with theme and padding **/
    
    [self setGraph: [[CPTXYGraph alloc] initWithFrame: CGRectZero]];
    [[self graph] applyTheme: [CPTTheme themeNamed: kCPTDarkGradientTheme]];
    self.hostedGraph = [self graph];
    
    /*[[self graph] setPaddingTop: 0.0f];
    [[self graph] setPaddingBottom: 0.0f];
    [[self graph] setPaddingLeft: 0.0f];
    [[self graph] setPaddingRight: 0.0f];*/
    
    [[[self graph] plotAreaFrame] setPaddingTop: 20.0f];
    [[[self graph] plotAreaFrame] setPaddingBottom: 70.0f];
    [[[self graph] plotAreaFrame] setPaddingLeft: 70.0f];
    [[[self graph] plotAreaFrame] setPaddingRight: 20.0f];
   
    
    /** Set graph plot space **/
    
    float xMin = 0.0f;
    float yMin = 0.0f;
    float xMax = [[self graphData] count];
    float yMax = 10.0f;
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*)[[self graph] defaultPlotSpace];
    [plotSpace setDelegate: self];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax - xMin)]];
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax - yMin)]];
    
    
    /** Set grid lines **/
    
    CPTMutableLineStyle* majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    CPTMutableLineStyle* minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    [majorGridLineStyle setLineWidth: 0.5f];
    [minorGridLineStyle setLineWidth: 0.25f];
    [majorGridLineStyle setLineColor: [CPTColor blackColor]];
    [minorGridLineStyle setLineColor: [[CPTColor blackColor] colorWithAlphaComponent: 0.5]];
    
    
    /** Setup axises **/
    
    CPTMutableTextStyle* axisTextStyle = [CPTMutableTextStyle textStyle];
    [axisTextStyle setFontName: @"Helvetica"];
    [axisTextStyle setFontSize: 14.0f];
    [axisTextStyle setColor: [CPTColor whiteColor]];
    
    CPTMutableLineStyle* axisLineStyle = [CPTMutableLineStyle lineStyle];
    [axisLineStyle setLineColor: [CPTColor whiteColor]];
    [axisLineStyle setLineWidth: 2.0f];
    
    CPTXYAxisSet* axisSet = (CPTXYAxisSet*)[[self graph] axisSet];
    CPTXYAxis* xAxis = [axisSet xAxis];
    CPTXYAxis* yAxis = [axisSet yAxis];

    [xAxis setTitle: @"Date"];
    [xAxis setTitleTextStyle: axisTextStyle];
    [xAxis setLabelTextStyle: axisTextStyle];
    [xAxis setTitleOffset: 30.0f];
    [xAxis setLabelOffset: 3.0f];
    [xAxis setMajorGridLineStyle: nil];
    [xAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [xAxis setMajorTickLength: 7.0f];
    [xAxis setMinorTickLength: 5.0f];
    [xAxis setMinorTicksPerInterval: 0.0f];
    [xAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];
    [xAxis setLabelingPolicy: CPTAxisLabelingPolicyNone];
    
    
    [yAxis setTitle: @"Score"];
    [yAxis setTitleTextStyle: axisTextStyle];
    [yAxis setLabelTextStyle: axisTextStyle];
    [yAxis setTitleOffset: 40.0f];
    [yAxis setLabelOffset: 3.0f];
    [yAxis setMajorGridLineStyle: majorGridLineStyle];
    [yAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [yAxis setMajorTickLength: 7.0f];
    [yAxis setMinorTickLength: 5.0f];
    [yAxis setMinorTicksPerInterval: 0.0f];
    [yAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];
    
    
    /** Setup dates on X-Axis **/
    
    NSArray* dates = [[self graphData] allKeys];
    dates = [dates sortedArrayUsingSelector:@selector(compare:)];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    
    uint32_t xPosition = 0;
    NSMutableArray* xLabels = [NSMutableArray array];
    
    for (NSDate* date in dates)
    {
        NSString* dateString = [dateFormatter stringFromDate: date];
        
        CPTAxisLabel* xlabel = [[CPTAxisLabel alloc] initWithText: dateString textStyle: [xAxis labelTextStyle]];
        [xlabel setTickLocation: [[NSNumber numberWithUnsignedInt: xPosition] decimalValue]];
        [xlabel setOffset: [xAxis labelOffset] + [xAxis majorTickLength]];
        [xlabel setRotation: M_PI / 4.0f];
        [xLabels addObject: xlabel];
        ++xPosition;
    }
    
    [xAxis setAxisLabels: [NSSet setWithArray: xLabels]];


    /** Setup plot **/
    
    CPTBarPlot* plot = [[CPTBarPlot alloc] init];
    [plot setDataSource: self];
    [plot setDelegate: self];
    [plot setBarWidth: [[NSDecimalNumber decimalNumberWithString:@"0.7"] decimalValue]];
    [plot setBarOffset: [[NSDecimalNumber decimalNumberWithString:@"0.0"] decimalValue]];
    [plot setBarCornerRadius: 5.0f];

    CPTMutableLineStyle* barBorderLineStyle = [CPTMutableLineStyle lineStyle];
    [barBorderLineStyle setLineColor: [CPTColor clearColor]];
    [plot setLineStyle: barBorderLineStyle];
    [plot setIdentifier: @"main"];
    [[self graph] addPlot: plot];
}

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [[self graphData] count];
}

- (NSNumber*)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ([[plot identifier] isEqual: @"main"])
    {
        NSNumber* num = [[[self graphData] allValues] objectAtIndex: index];
        
        if (fieldEnum == CPTBarPlotFieldBarLocation) //X-Axis
        {
            return [NSNumber numberWithUnsignedInteger: index];
        }
        else if (fieldEnum == CPTBarPlotFieldBarTip) //Y-Axis
        {
            return num;
        }
    }
    
    return [NSNumber numberWithInteger: 0];
}

- (CPTLayer*)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ([[plot identifier] isEqual: @"main"])
    {
        CPTMutableTextStyle* textStyle = [CPTMutableTextStyle textStyle];
        [textStyle setFontName: @"Helvetica"];
        [textStyle setFontSize: 14];
        [textStyle setColor: [CPTColor whiteColor]];
        
        CPTTextLayer* label = [[CPTTextLayer alloc] initWithText: @"text"];
        [label setTextStyle: textStyle];
        return label;
    }
    
    CPTTextLayer* label = [[CPTTextLayer alloc] initWithText: @"???"];
    return label;
    
}

- (CPTFill*)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    if ([[barPlot identifier] isEqual: @"main"])
    {
        CPTColor* colours[] =
        {
            [CPTColor redColor],
            [CPTColor blueColor],
            [CPTColor orangeColor],
            [CPTColor purpleColor]
        };
        
        static unsigned int index = 0;
        
        CPTGradient* gradient = [CPTGradient gradientWithBeginningColor:[CPTColor whiteColor] endingColor: colours[index] beginningPosition: 0.0f endingPosition: 0.3f];
        [gradient setGradientType: CPTGradientTypeAxial];
        [gradient setAngle: 320.0];
        
        if (index++ == 3)
            index = 0;
        
        return [CPTFill fillWithGradient: gradient];
        
    }
    return [CPTFill fillWithColor: [CPTColor whiteColor]];
    
}
@end
