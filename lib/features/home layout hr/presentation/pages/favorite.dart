import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/candidate_model.dart';
import '../bloc/home_layout_hr_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<HomeLayoutHrBloc>().add(GetAllFavoriteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GOLDEN CHOICES'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        child: BlocBuilder<HomeLayoutHrBloc, HomeLayoutHrState>(
          builder: (context, state) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final candidate = context
                      .read<HomeLayoutHrBloc>()
                      .cndiadates
                      .firstWhere((e) =>
                          e.id ==
                          context.read<HomeLayoutHrBloc>().favorites[index].id);
                  return CandidateCard(candidate, index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10.h);
                },
                itemCount: context.read<HomeLayoutHrBloc>().favorites.length);
          },
        ),
      ),
    );
  }
}

class CandidateCard extends StatelessWidget {
  final CandidateModel candidate;
  final int index;
  const CandidateCard(this.candidate, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 72),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(color: Color(0xFFF7F9FC)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Left side: Image + Info
            Row(
              children: [
                /// Profile Image
                Container(
                  width: 56,
                  height: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          candidate.image ?? 'https://placehold.co/56x56'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                /// Name and Job Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      candidate.name ?? 'Unknown Name',
                      style: const TextStyle(
                        color: Color(0xFF0C141C),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),

                    /// Job Title
                    Text(
                      candidate.job ?? 'No Job Title',
                      style: const TextStyle(
                        color: Color(0xFF49729B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            /// Optional Right Side Icon (You can customize this)
            IconButton(
              icon: const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              onPressed: () {
                context
                    .read<HomeLayoutHrBloc>()
                    .add(DeleteFavoriteEvent(index));
                context.read<HomeLayoutHrBloc>().add(GetAllFavoriteEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
