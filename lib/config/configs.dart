class Configs {
  static const String appName = 'Offbeat Pravasi';
  static const appWriteProjectId =
      String.fromEnvironment('APPWRITE_PROJECT_ID', defaultValue: '');
  static const appWriteUserProfileStorageBucketId =
      String.fromEnvironment('APPWRITE_USERSTORAGE_BUCKET', defaultValue: '');
  static const appWriteEndpoint =
      String.fromEnvironment('APPWRITE_ENDPOINT', defaultValue: '');
}

