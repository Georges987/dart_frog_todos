// routes/tasks/index.dart
import 'dart:io';

import 'package:backend/user.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final task = await context.request.body();
  final user = context.read<User>();

  return Response.json(
    body: {
      'recorded_task': task,
      'user_id': user.id,
    },
  );
}