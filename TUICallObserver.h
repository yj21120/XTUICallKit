//
//  TUICallObserver.h
//  XTUICallKit
//
//  Created by Yuj on 2023/7/31.
//

@protocol TUICallObserver1 <NSObject>

@optional

- (void)answerCall:(BOOL)accept;
- (void)endCall;
@end

NS_ASSUME_NONNULL_END

