import 'package:aplikasi_blog/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:aplikasi_blog/core/theme/app_pallete.dart';
import 'package:aplikasi_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:aplikasi_blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const ProfilePage());
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
    
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppPallete.gradient1,
                        AppPallete.gradient2,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BlogGetAllSuccess) {
              final userBlogs = state.blogs
                  .where((blog) => blog.posterId == user.id)
                  .toList();

              if (userBlogs.isEmpty) {
                return const Center(
                  child: Text('No blogs yet'),
                );
              }

              return ListView.builder(
                itemCount: userBlogs.length,
                itemBuilder: (context, index) {
                  final blog = userBlogs[index];
                  return BlogCard(blog: blog);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}