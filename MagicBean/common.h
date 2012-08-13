//
//  common.h
//  GlassPrince
//
//  Created by Ivan on 11-9-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#define ARC4RANDOM_MAX      0x100000000
#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "Box2D.h"
#import "GB2ShapeCache.h"
#import "GLES-Render.h"
#import "VRope.h"
#import "MyContactListener.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import "MainMenu.h"
#import "pintu.h"
#import "GameLayer.h"
#import "StoryLayer.h"
#import "ReadScene.h"
#import "ShareLayer.h"
#import "index_Scene.h"
class MyQueryCallback : public b2QueryCallback
{
public:
	MyQueryCallback(const b2Vec2& point)
	{
		m_point = point;
		m_fixture = NULL;
	}
	
	bool ReportFixture(b2Fixture* fixture)
	{
		printf("called query\n");
		b2Body* body = fixture->GetBody();
		if (body->GetType() == b2_dynamicBody)
		{
			bool inside = fixture->TestPoint(m_point);
			if (inside)
			{
				m_fixture = fixture;
				
				// We are done, terminate the query.
				return false;
			}
		}
		// Continue the query.
		return true;
	}
	b2Vec2 m_point;
	b2Fixture* m_fixture;
};

class MyQueryCallbackStatic : public b2QueryCallback
{
public:
	MyQueryCallbackStatic(const b2Vec2& point)
	{
		m_point = point;
		m_fixture = NULL;
	}
	
	bool ReportFixture(b2Fixture* fixture)
	{
		printf("called query static\n");
		b2Body* body = fixture->GetBody();
		if (body->GetType() == b2_staticBody)
		{
			bool inside = fixture->TestPoint(m_point);
			if (inside)
			{
				m_fixture = fixture;
				
				// We are done, terminate the query.
				return false;
			}
		}
		// Continue the query.
		return true;
	}
	b2Vec2 m_point;
	b2Fixture* m_fixture;
};

@interface Common : CCNode
+ (NSInteger)createRandomsizeValueInt:(NSInteger)fromInt toInt:(NSInteger)toInt;
+ (BOOL)isTransparentWithSprite: (CCSprite *)sprite pointInNodeSpace: (CGPoint) point onto:(CCLayer*)layer;//scaleto:(float)scale rotateto:(float)rotate
+ (double)createRandomsizeValueFloat:(double)fromFloat toFloat:(double)toFloat;
@end