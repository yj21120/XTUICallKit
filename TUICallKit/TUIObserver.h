//
//  TUICallKit.h
//  TUICalling
//
//  Created by noah on 2021/8/28.
//  Copyright © 2021 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol TUICallObserver1 <NSObject>

@optional
- (void)answerCall:(BOOL)accept;
- (void)endCall;
@end

