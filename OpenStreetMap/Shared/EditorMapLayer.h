//
//  OsmMapLayer.h
//  OpenStreetMap
//
//  Created by Bryce Cogswell on 10/5/12.
//  Copyright (c) 2012 Bryce Cogswell. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "VectorMath.h"
#import "iosapi.h"

@class OsmMapData;
@class OsmRenderInfo;
@class MapCSS;
@class MapView;
@class OsmBaseObject;
@class OsmNode;
@class OsmWay;
@class OsmRelation;
@class QuadMap;
@class SpeechBalloonLayer;

#define SHOW_3D	1


static const CGFloat DefaultHitTestRadius = 10.0;	// how close to an object do we need to tap to select it
static const CGFloat DragConnectHitTestRadius = DefaultHitTestRadius * 0.6;	// how close to an object do we need to drag a node to connect to it

extern const double MinIconSizeInPixels;


@interface EditorMapLayer : CALayer<UIActionSheetDelegate,NSCoding>
{
	CGSize					_iconSize;
	double					_highwayScale;

	OsmBaseObject		*	_highlightObject;
	NSMutableArray		*	_extraSelections;

	SpeechBalloonLayer	*	_speechBalloon;

	MapCSS				*	_mapCss;
	NSMutableSet		*	_nameDrawSet;

	NSMutableArray		*	_shownObjects;
	NSMutableSet		*	_fadingOutSet;

	NSMutableArray		*	_selectionChangeCallbacks;

	NSMutableArray		*	_highlightLayers;

	BOOL					_isPerformingLayout;

	CATransformLayer	*	_baseLayer;
}

@property (assign,nonatomic)	MapView				*	mapView;
@property (assign,nonatomic)	BOOL					whiteText;
@property (strong,nonatomic)	OsmNode				*	selectedNode;
@property (strong,nonatomic)	OsmWay				*	selectedWay;
@property (strong,nonatomic)	OsmRelation			*	selectedRelation;
@property (readonly,nonatomic)	OsmBaseObject		*	selectedPrimary;	// way or node, but not a node in a selected way
@property (readonly,nonatomic)	OsmMapData			*	mapData;
@property (assign,nonatomic)	BOOL					addNodeInProgress;
@property (assign,nonatomic)	BOOL					addWayInProgress;
@property (assign,nonatomic)	BOOL					enableMapCss;

- (id)initWithMapView:(MapView *)mapView;
- (void)didReceiveMemoryWarning;

- (OsmNode *)osmHitTestNodeInSelection:(CGPoint)point radius:(CGFloat)radius ;
- (OsmBaseObject *)osmHitTest:(CGPoint)point radius:(CGFloat)radius ;
- (OsmBaseObject *)osmHitTest:(CGPoint)point radius:(CGFloat)radius segment:(NSInteger *)segment ignoreList:(NSArray *)ignoreList;
- (OsmBaseObject *)osmHitTestSelection:(CGPoint)point radius:(CGFloat)radius ;
- (OsmBaseObject *)osmHitTestSelection:(CGPoint)point radius:(CGFloat)radius segment:(NSInteger *)segment;
+ (OsmBaseObject *)osmHitTest:(CGPoint)point radius:(CGFloat)radius mapView:(MapView *)mapView objects:(NSArray *)objects testNodes:(BOOL)testNodes
				   ignoreList:(NSArray *)ignoreList segment:(NSInteger *)segment;
- (NSArray *)osmHitTestMultiple:(CGPoint)point radius:(CGFloat)radius ;
- (void)osmObjectsNearby:(CGPoint)point radius:(double)radius block:(void(^)(OsmBaseObject * obj,CGFloat dist,NSInteger segment))block;


-(NSArray *)shownObjects;

- (void)osmHighlightObject:(OsmBaseObject *)object mousePoint:(CGPoint)mousePoint;
- (void)updateMapLocation;
- (void)purgeCachedDataHard:(BOOL)hard;

- (void)toggleExtraSelection:(OsmBaseObject *)object;
- (void)clearExtraSelections;
- (NSArray *)extraSelections;

- (void)setSelectionChangeCallback:(void (^)(void))callback;

-(OsmNode *)createNodeAtPoint:(CGPoint)point;
-(OsmWay *)createWayWithNode:(OsmNode *)node;
-(void)deleteNode:(OsmNode *)node fromWay:(OsmWay *)way;
-(void)deleteNode:(OsmNode *)node fromWay:(OsmWay *)way allowDegenerate:(BOOL)allowDegenerate;
-(void)addNode:(OsmNode *)node toWay:(OsmWay *)way atIndex:(NSInteger)index;
-(void)deleteSelectedObject;
-(void)cancelOperation;
-(void)adjustNode:(OsmNode *)node byDistance:(CGPoint)delta;
-(OsmBaseObject *)duplicateObject:(OsmBaseObject *)object;


- (BOOL)copyTags:(OsmBaseObject *)object;
- (BOOL)pasteTags:(OsmBaseObject *)object;
- (BOOL)canPasteTags;


- (void)save;

@end
