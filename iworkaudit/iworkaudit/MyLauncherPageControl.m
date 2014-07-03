//
//  MyLauncherPageControl.m
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

#import "MyLauncherPageControl.h"

@implementation MyLauncherPageControl

@synthesize numberOfPages, hidesForSinglePage, inactivePageColor, activePageColor;
@dynamic currentPage;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
        hidesForSinglePage = NO;
		//activePageColor = [UIColor yellowColor];
		//inactivePageColor = [UIColor grayColor];
        
    }
    return self;
}

- (void) drawRect:(CGRect) iRect {
    UIImage                 *grey, *image, *red;
    int                     i;
    CGRect                  rect;
    
    const CGFloat           kSpacing = 10.0;
    
    iRect = self.bounds;
    
    if ( self.opaque ) {
        [self.backgroundColor set];
        UIRectFill( iRect );
    }
    
    if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
    
    red = [UIImage imageNamed:@"pagination_active.png"];
    grey = [UIImage imageNamed:@"pagination.png"];
    
    rect.size.height = red.size.height;
    rect.size.width = self.numberOfPages * red.size.width + ( self.numberOfPages - 1 ) * kSpacing;
    rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
    rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
    rect.size.width = red.size.width;
    
    for ( i = 0; i < self.numberOfPages; ++i ) {
        image = i == self.currentPage ? red : grey;
        
        [image drawInRect: rect];
        
        rect.origin.x += red.size.width + kSpacing;
    }
}

- (NSInteger)currentPage
{
	return currentPage;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	if (self.touchInside)
	{
		CGPoint point = [touch locationInView:self];
		NSInteger currentPageInt = self.currentPage;
		
		if (point.x <= self.frame.size.width/2)
			[self setCurrentPage:--currentPageInt];
		else
			[self setCurrentPage:++currentPageInt];
        
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

-(void)setNumberOfPages:(NSInteger)count
{
	if (count > 6) return;
	self.hidden = count <= 1 ? YES : NO;
	
	numberOfPages = count;
	if (currentPage > [self numberOfPages]-1) currentPage = [self numberOfPages] - 1;
	
	[self setNeedsDisplay];
    //[self updateDots];
}

- (void)setCurrentPage:(NSInteger)page
{
	if (page < 0) page = 0;
	if (page > [self numberOfPages]-1) page = [self numberOfPages] - 1;
	
	currentPage = page;
	[self setNeedsDisplay];
    //[self updateDots];
}

- (void)dealloc
{
    [super dealloc];
}

@end
