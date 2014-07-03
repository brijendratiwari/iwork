//
//  MyLauncherViewController.h
//  @rigoneri
//  
//  Copyright 2010 Rodrigo Neri
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>
#import "MyLauncherView.h"
#import "MyLauncherItem.h"

@interface MyLauncherViewController : UIViewController <MyLauncherViewDelegate>
{
	UINavigationController *launcherNavigationController;
	MyLauncherView *launcherView;
	UIView *overlayView;
	NSMutableArray *launcherItems;
}

@property (nonatomic, retain) UINavigationController *launcherNavigationController;
@property (nonatomic, retain) MyLauncherView *launcherView;
@property (nonatomic, retain) NSMutableArray *launcherItems;

@end
