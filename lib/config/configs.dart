class Configs {
  static const String appName = 'Offbeat प्रवासी';

  static const String appWriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT', defaultValue: '');

  static const String appWriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID', defaultValue: '');

  static const String appWriteUserProfileStorageBucketId =
      String.fromEnvironment('APPWRITE_USERSTORAGE_BUCKET', defaultValue: '');

  static const String appWriteTrekImageStorageBucketId =
      String.fromEnvironment('APPWRITE_TREKIMAGE_BUCKET', defaultValue: '');

  static const String appWriteUserBannerStorageBucketId =
      String.fromEnvironment('APPWRITE_USERBANNER_BUCKET', defaultValue: '');

  static const String appWriteUserPostsStorageBucketId =
      String.fromEnvironment('APPWRITE_USERPOSTS_BUCKET', defaultValue: '');

  static const String appWriteSendNotificationEndpoint = String.fromEnvironment(
      'APPWRITE_NOTIFICATION_ENDPOINT',
      defaultValue: '');

  static const String appWriteUserStoryStorageBucketId =
      String.fromEnvironment('APPWRITE_USERSTORY_BUCKET', defaultValue: '');

  static const String stripePublishableKey =
      String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue: '');
}
