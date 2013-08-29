//
//  WebViewController.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/23/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *urlString;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
