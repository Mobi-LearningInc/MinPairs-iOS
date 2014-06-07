//
//  LineGraphView.h
//  MinPairs
//
//  Created by Brandon on 2014-05-20.
//  Copyright (c) 2014 Brandon. All rights reserved.
//

#import "CPTGraphHostingView.h"
#import "CorePlot-CocoaTouch.h"

@interface MLLineGraphView : CPTGraphHostingView<CPTPlotDataSource, CPTPlotSpaceDelegate>
- (void)createGraph;
- (void) setGraphData:(NSMutableDictionary*)data;
- (void) reload;
@end
