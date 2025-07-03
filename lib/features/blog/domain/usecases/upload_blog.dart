import 'dart:io';

import 'package:aplikasi_blog/core/error/failures.dart';
import 'package:aplikasi_blog/core/usecase/usecase.dart';
import 'package:aplikasi_blog/features/blog/domain/entities/blog.dart';
import 'package:aplikasi_blog/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
}
