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

- (void) setGraphData:(NSMutableDictionary*)data
{
    _graphData = data;
}

- (void)createGraph
{
    /** Create graph with theme and padding **/
    
    [self setGraph: [[CPTXYGraph alloc] initWithFrame: CGRectZero]];
    self.hostedGraph = [self graph];
    [[self graph] setTitle: @"Avg. Score per Day"];
    
    
    CPTColor* bgColour = [CPTColor colorWithComponentRed:220.0f/0xFF green:240.0f/0xFF blue:231.0f/0xFF alpha:1.0f];
    
    [[self graph] setFill: [CPTFill fillWithColor: bgColour]];
    [[[self graph] plotAreaFrame] setPaddingTop: 20.0f];
    [[[self graph] plotAreaFrame] setPaddingBottom: 65.0f];
    [[[self graph] plotAreaFrame] setPaddingLeft: 57.0f];
    [[[self graph] plotAreaFrame] setPaddingRight: 5.0f];
   
    
    /** Set graph plot space **/
    
    float xMin = 0.0f;
    float yMin = 0.0f;
    float xMax = 4.0f;//[[self graphData] count];
    float yMax = 10.0f;
    
    CPTXYPlotSpace* plotSpace = (CPTXYPlotSpace*)[[self graph] defaultPlotSpace];
    
    [plotSpace setDelegate: self];
    [plotSpace setAllowsUserInteraction: true];
    [plotSpace setAllowsMomentumX:true];
    
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
    
    CPTMutableTextStyle* xAxisTextStyle = [CPTMutableTextStyle textStyle];
    [xAxisTextStyle setFontName: @"Avenir"];
    [xAxisTextStyle setFontSize: 11.0f];
    [xAxisTextStyle setColor: [CPTColor blackColor]];
    
    CPTMutableTextStyle* yAxisTextStyle = [CPTMutableTextStyle textStyle];
    [xAxisTextStyle setFontName: @"Avenir"];
    [xAxisTextStyle setFontSize: 12.0f];
    [xAxisTextStyle setColor: [CPTColor blackColor]];
    
    CPTMutableLineStyle* axisLineStyle = [CPTMutableLineStyle lineStyle];
    [axisLineStyle setLineColor: [CPTColor blackColor]];
    [axisLineStyle setLineWidth: 2.0f];
    
    [[self graph] setTitleTextStyle: yAxisTextStyle];
    CPTXYAxisSet* axisSet = (CPTXYAxisSet*)[[self graph] axisSet];
    CPTXYAxis* xAxis = [axisSet xAxis];
    CPTXYAxis* yAxis = [axisSet yAxis];

    
    /*[xAxis setTitleOffset: 30.0f];
    [xAxis setLabelOffset: 3.0f];
    [xAxis setTitleTextStyle: xAxisTextStyle];
    [xAxis setLabelTextStyle: xAxisTextStyle];
    [xAxis setMajorGridLineStyle: nil];
    [xAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [xAxis setMajorTickLength: 7.0f];
    [xAxis setMinorTickLength: 5.0f];
    [xAxis setMinorTicksPerInterval: 0.0f];
    [xAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];
    [xAxis setLabelingPolicy: CPTAxisLabelingPolicyNone];
    
    
    [yAxis setTitle: @"Score"];
    [yAxis setTitleOffset: 40.0f];
    [yAxis setLabelOffset: 3.0f];
    [yAxis setTitleTextStyle: yAxisTextStyle];
    [yAxis setLabelTextStyle: yAxisTextStyle];
    [yAxis setMajorGridLineStyle: majorGridLineStyle];
    [yAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [yAxis setMajorTickLength: 7.0f];
    [yAxis setMinorTickLength: 5.0f];
    [yAxis setMinorTicksPerInterval: 0.0f];
    [yAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];*/
    [xAxis setTitleOffset: 30.0f];
    [xAxis setLabelOffset: 3.0f];
    [xAxis setTitleTextStyle: xAxisTextStyle];
    [xAxis setLabelTextStyle: xAxisTextStyle];
    [xAxis setLabelingPolicy: CPTAxisLabelingPolicyNone];
    [xAxis setOrthogonalCoordinateDecimal: CPTDecimalFromInt(0)];
    [xAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [xAxis setMinorTicksPerInterval: 1.0f];
    [xAxis setMajorGridLineStyle: nil];
    [xAxis setMinorGridLineStyle: nil];
    [xAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];
    
    [yAxis setTitle: @"Score"];
    [yAxis setTitleOffset: 40.0f];
    [yAxis setLabelOffset: 3.0f];
    [yAxis setTitleTextStyle: yAxisTextStyle];
    [yAxis setLabelTextStyle: yAxisTextStyle];
    [yAxis setOrthogonalCoordinateDecimal: CPTDecimalFromInt(0)];
    [yAxis setMajorIntervalLength: CPTDecimalFromFloat(1.0f)];
    [yAxis setMinorTicksPerInterval: 0.0f];
    [yAxis setMajorGridLineStyle: majorGridLineStyle];
    [yAxis setMinorGridLineStyle: nil];
    [yAxis setAxisConstraints: [CPTConstraints constraintWithLowerOffset: 0.0f]];
    
    
    /** Setup dates on X-Axis **/
    
    NSArray* dates = [[self graphData] allKeys];
    dates = [dates sortedArrayUsingSelector:@selector(compare:)];
    
    float xPosition = 0.3f;
    NSMutableArray* xLabels = [NSMutableArray array];
    
    for (NSString* date in dates)
    {
        CPTAxisLabel* xlabel = [[CPTAxisLabel alloc] initWithText: date textStyle: [xAxis labelTextStyle]];
        [xlabel setTickLocation: [[NSNumber numberWithFloat: xPosition] decimalValue]];
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
    [plot setBarOffset: [[NSDecimalNumber decimalNumberWithString:@"0.3"] decimalValue]];
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

/*- (CPTLayer*)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ([[plot identifier] isEqual: @"main"])
    {
        CPTMutableTextStyle* textStyle = [CPTMutableTextStyle textStyle];
        [textStyle setFontName: @"Avenir"];
        [textStyle setFontSize: 14];
        [textStyle setColor: [CPTColor whiteColor]];
        
        CPTTextLayer* label = [[CPTTextLayer alloc] initWithText: @"text"];
        [label setTextStyle: textStyle];
        return label;
    }
    
    CPTTextLayer* label = [[CPTTextLayer alloc] initWithText: @"???"];
    return label;
}*/

- (CPTFill*)barFillForBarPlot:(CPTBarPlot *)barPlot recordIndex:(NSUInteger)index
{
    if ([[barPlot identifier] isEqual: @"main"])
    {
        CPTColor* colour = [CPTColor colorWithComponentRed:21.0f/0xFF green:142.0f/0xFF blue:141.0f/0xFF alpha:1.0f];
        
        return [CPTFill fillWithColor: colour];
        
    }
    return [CPTFill fillWithColor: [CPTColor whiteColor]];
}

- (CPTPlotRange *)plotSpace:(CPTPlotSpace *)space willChangePlotRangeTo:(CPTPlotRange *)newRange forCoordinate:(CPTCoordinate)coordinate
{
    
    if (coordinate == CPTCoordinateX)
    {
        if (newRange.locationDouble < 0.0f)
            return [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:newRange.length];
        
        return [CPTPlotRange plotRangeWithLocation:newRange.location length:newRange.length];
    }
    else
    {
        return [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(10.0f)];
    }
    
    
    return nil;
}

- (CGPoint)plotSpace:(CPTPlotSpace *)space willDisplaceBy:(CGPoint)displacement
{
    return CGPointMake(displacement.x, 0);
}
@end
