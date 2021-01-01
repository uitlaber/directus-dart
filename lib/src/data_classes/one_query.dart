import 'data_classes.dart';

/// Query that can be used when fetching data to specify needed data.
///
/// This query can be used for both [ItemsHandler.readOne] and [ItemsHandler.readMany] methods,
/// but [Query] is offering more options for `readMany`.
class OneQuery {
  OneQuery({this.deep, this.fields});

  /// List of all fields that should be returned.
  ///
  /// If value is null, server will default to `['*']`. You can do joins by
  /// calling fields with `.*` after column name.
  /// For example `['*', 'user_id.*']` will get all data from current item, and join
  /// `user_id` field with proper table, and get all data.
  ///
  /// Example:
  /// ```dart
  /// fields = ['*'];
  /// fields = ['id', 'title'];
  /// fields = ['id', 'user.*'];
  /// ```
  /// [Additional info](https://github.com/directus/directus/blob/main/docs/reference/api/query/fields.md)
  List<String>? fields;

  /// [deep] is used to apply any of the other query params to nested data sets.
  ///
  ///```dart
  /// deep = {
  ///   'favorites': Query(limit: 5)
  /// };
  ///
  ///```
  /// [Additional info](https://github.com/directus/directus/discussions/3424)
  Map<String, Query>? deep;

  /// Convert [OneQuery] to [Map] so it can be sent in HTTP request.
  Map<String, dynamic> toMap() {
    return {
      'fields': fields?.join(','),
      'deep': deep?.map((key, value) => MapEntry(key, value.toMap())),
    }..removeWhere(
        (key, value) => value == null,
      );
  }
}