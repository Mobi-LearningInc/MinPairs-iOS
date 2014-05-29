//
//  LineGraphView.m
//  MinPairs
//
//  Created by Brandon on 2014-05-20.
//  Copyright (c) 2014 Brandon. All rights reserved.
//

#import "MLLineGraphView.h"
#import "CorePlot-CocoaTouch.h"

@interface MLLineGraphView()
@property (nonatomic, strong) CPTXYGraph* graph;
@property (nonatomic, strong) NSMutableDictionary* graphData;
@end

@implementation MLLineGraphView

- (void) setGraphData:(NSMutableDictionary*)data
{
    _graphData = data;
}

- (void)createGraph
{
    /** Create graph with theme and padding **/
    
    [self setGraph: [[CPTXYGraph alloc] initWithFrame: CGRectZero]];
    self.hostedGraph = [self graph];
    [[self graph] setTitle: @"Score per Game"];
    
    CPTColor* bgColour = [CPTColor colorWithComponentRed:220.0f/0xFF green:240.0f/0xFF blue:231.0f/0xFF alpha:1.0f];
    
    [[self graph] setFill: [CPTFill fillWithColor: bgColour]];
    [[[self graph] plotAreaFrame] setPaddingTop: 20.0f];
    [[[self graph] plotAreaFrame] setPaddingBottom: 65.0f];
    [[[self graph] plotAreaFrame] setPaddingLeft: 57.0f];
    [[[self graph] plotAreaFrame] setPaddingRight: 5.0f];
    
    
    /** Set graph plot space **/
    
    float xMin = -0.05f;
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
    
    [[self graph] setTitleTextStyle: yAxisTextStyle];
    CPTXYAxisSet* axisSet = (CPTXYAxisSet*)[[self graph] axisSet];
    CPTXYAxis* xAxis = [axisSet xAxis];
    CPTXYAxis* yAxis = [axisSet yAxis];
    
    //[xAxis setTitle: @"Date"];
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
    
    uint32_t xPosition = 0;
    NSMutableArray* xLabels = [NSMutableArray array];
    
    for (NSString* date in dates)
    {
        CPTAxisLabel* xlabel = [[CPTAxisLabel alloc] initWithText: date textStyle: [xAxis labelTextStyle]];
        [xlabel setTickLocation: [[NSNumber numberWithUnsignedInt: xPosition] decimalValue]];
        [xlabel setOffset: [xAxis labelOffset] + [xAxis majorTickLength]];
        [xlabel setRotation: M_PI / 4.0f];
        [xLabels addObject: xlabel];
        ++xPosition;
    }
     
    [xAxis setAxisLabels: [NSSet setWithArray: xLabels]];
    
    
    /** Setup plot **/
    
    CPTColor* lineColour = [CPTColor colorWithComponentRed:21.0f/0xFF green:142.0f/0xFF blue:141.0f/0xFF alpha:1.0f];
    CPTMutableLineStyle* plotLineStyle = [CPTMutableLineStyle lineStyle];
    [plotLineStyle setLineColor: lineColour];
    [plotLineStyle setLineWidth: 2.0f];
    
    CPTPlotSymbol* plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    [plotSymbol setFill: [CPTFill fillWithColor: [plotLineStyle lineColor]]];
    [plotSymbol setSize: CGSizeMake(4.0f, 4.0f)];
    [plotSymbol setLineStyle: plotLineStyle];
    
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] init];
    [plot setDataSource: self];
    [plot setIdentifier: @"main"];
    [plot setDataLineStyle: plotLineStyle];
    [plot setPlotSymbol: plotSymbol];
    
    
    /** Fill under the graph **/
    
    CPTColor* uFillColour = [CPTColor colorWithComponentRed:21.0f/0xFF green:142.0f/0xFF blue:141.0f/0xFF alpha:0.5f];
    CPTGradient* uFillGradient = [CPTGradient gradientWithBeginningColor:uFillColour endingColor:[CPTColor clearColor]];
    [uFillGradient setAngle: -90.0f];
    CPTFill* uFill = [CPTFill fillWithGradient: uFillGradient];
    [plot setAreaFill: uFill];
    [plot setAreaBaseValue: CPTDecimalFromString(@"-1.00")];
    
    [[self graph] addPlot: plot];
}

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [[self graphData] count];
}

- (double)doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ([[plot identifier] isEqual: @"main"])
    {
        NSNumber* num = [[[self graphData] allValues] objectAtIndex: index];
        
        if (fieldEnum == CPTScatterPlotFieldX) //X-Axis
        {
            return index;
        }
        else //Y-Axis
        {
            return [num doubleValue];
        }
    }
    
    return 0;
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
