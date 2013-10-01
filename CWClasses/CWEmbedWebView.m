//
//  CWEmbedWebView.m
//  TestYoutubeAPI
//
//  Created by 정창욱 on 13. 9. 26..
//  Copyright (c) 2013년 AfreecaTV Co., Ltd. All rights reserved.
//

#import "CWEmbedWebView.h"

#if !__has_feature(objc_arc)
#error CWEmbedWebView must be built with ARC.
// You can turn on ARC for only AFNetworking files by adding -fobjc-arc to the build phase for each of its files.
#endif

@interface CWEmbedWebView () <UIWebViewDelegate>
{
    id<UIWebViewDelegate> _delegate;
}
@property (readonly, nonatomic) NSString *htmlString;
@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation CWEmbedWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [super setDelegate:self];
    self.scrollView.scrollEnabled = NO;
    self.scalesPageToFit = NO;

    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.loadingView.center = self.center;
    self.loadingView.hidesWhenStopped = YES;
    [self.loadingView stopAnimating];
    [self addSubview:self.loadingView];
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    _delegate = delegate;
}

- (NSString *)htmlString
{
    if (![self.sourceURL scheme]) {
        NSString *urlString = [NSString stringWithFormat:@"http://%@", self.sourceURL];
        self.sourceURL = [NSURL URLWithString:urlString];
    }

    NSString *embedString = [NSString stringWithFormat:
                             @"<iframe id=\"youtube_frame\" style=\"position:fixed; top:0px; left:0px; bottom:0px; right:0px; border:none; "
                             @"margin:0; padding:0; overflow:hidden; z-index:999999; "
                             @"width:100%%; height:100%%; \" "
                             @"frameborder=\"0\" allowfullscreen "
                             @"src=\"%@\"></iframe>",
                             self.sourceURL];
    
    
    return embedString;
}

- (void)load
{
    [self loadHTMLString:self.htmlString
                 baseURL:[NSURL URLWithString:@"http://www.your-url.com"]];
    
    
}

#pragma mark - UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingView startAnimating];

    if (_delegate && [_delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_delegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingView stopAnimating];

    if (_delegate && [_delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_delegate webViewDidFinishLoad:webView];
    }
}


@end
