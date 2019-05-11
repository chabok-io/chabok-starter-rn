//
//  NotificationService.m
//  NotificationService
//
//  Created by Hussein Habibi Juybari on 5/11/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NotificationService.h"
#import <AdpPushClient/AdpPushClient.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
  
    //ChabokPush download media
    [PushClientManager.defaultManager didReceiveNotificationRequest:request
                                               withContentHandler:contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
