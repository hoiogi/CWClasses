//
//  CWEmbedWebView.h
//  TestYoutubeAPI
//
//  Created by 정창욱 on 13. 9. 26..
//  Copyright (c) 2013년 AfreecaTV Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWEmbedWebView : UIWebView

@property (strong, nonatomic) NSURL *sourceURL;

- (void)load;

@end
