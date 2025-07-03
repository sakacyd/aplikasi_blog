// main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi_blog/core/common/cubits/cubit/bottom_nav_cubit.dart';
import 'package:aplikasi_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:aplikasi_blog/features/profile/presentation/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static route() => MaterialPageRoute(builder: (_) => const MainPage());

  @override
  Widget build(BuildContext context) {
    final pages = const [BlogPage(), ProfilePage()];

    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: IndexedStack(index: index, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) => context.read<BottomNavCubit>().changeTab(i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
