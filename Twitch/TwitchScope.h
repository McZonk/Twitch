#import <Foundation/Foundation.h>

/**
 * <code>user_read</code>: Read access to non-public user information, such as email address.
 */
extern NSString * const TwitchScopeUserRead;

/**
 * <code>user_blocks_edit</code>: Ability to ignore or unignore on behalf of a user.
 */
extern NSString * const TwitchScopeUserBlocksEdit;

/**
 * <code>user_blocks_read</code>: Read access to a user's list of ignored users.
 */
extern NSString * const TwitchScopeUserBlocksRead;

/**
 * <code>user_follows_edit</code>: Access to manage a user's followed channels.
 */
extern NSString * const TwitchScopeUserFollowsEdit;

/**
 * <code>channel_read</code>: Read access to non-public channel information, including email address and stream key.
 */
extern NSString * const TwitchScopeChannelRead;

/**
 * <code>channel_editor</code>: Write access to channel metadata (game, status, etc).
 */
extern NSString * const TwitchScopeChannelEditor;

/**
 * <code>channel_commercial</code>: Access to trigger commercials on channel.
 */
extern NSString * const TwitchScopeChannelCommercial;

/**
 * <code>channel_stream</code>: Ability to reset a channel's stream key.
 */
extern NSString * const TwitchScopeChannelStream;

/**
 * <code>channel_subscriptions</code>: Read access to all subscribers to your channel.
 */
extern NSString * const TwitchScopeChannelSubscriptions;

/**
 * <code>user_subscriptions</code>: Read access to subscriptions of a user.
 */
extern NSString * const TwitchScopeUserSubscriptions;

/**
 * <code>channel_check_subscription</code>: Read access to check if a user is subscribed to your channel.
 */
extern NSString * const TwitchScopeChannelCheckSubscription;

/**
 * <code>chat_login</code>: Ability to log into chat and send messages.
 */
extern NSString * const TwitchScopeChatLogin;
