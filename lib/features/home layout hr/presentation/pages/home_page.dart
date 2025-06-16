import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path2job/features/home%20layout%20hr/presentation/bloc/home_layout_hr_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../home layout/presentation/cubit/home_layout_cubit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    context.read<HomeLayoutCubit>().getAllActivties();
    context.read<HomeLayoutHrBloc>().add(GetAllFavoriteEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                controller: controller,
                onChanged: (value) {
                  context
                      .read<HomeLayoutHrBloc>()
                      .add(SearchEvent(value.trim()));
                },
                hintText: 'Search candidates',
                hintStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: const Color(0xFF6B7782),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFFF2F2F4)),
                padding: WidgetStateProperty.all(
                  EdgeInsets.only(
                      top: 8.h, left: 8.w, right: 16.w, bottom: 8.h),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                  ),
                ),
                leading: Icon(Icons.search,
                    color: const Color(0xFF6B7782), size: 20.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'Featured Candidates',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              buildCandidateList(),
              SizedBox(height: 24.h),
              Text(
                'Recent Activity',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              buildActivityList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCandidateList() {
    return BlocBuilder<HomeLayoutHrBloc, HomeLayoutHrState>(
      builder: (context, state) {
        final fakeCandidates = context.read<HomeLayoutHrBloc>().cndiadates;
        return SizedBox(
          height: 205.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: fakeCandidates.length, // Replace with dynamic count
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.candidateDetails,
                      arguments: fakeCandidates[index]);
                },
                child: CandidateCard(
                  name: fakeCandidates[index].name!,
                  jobTitle: fakeCandidates[index].job!,
                  imageUrl: fakeCandidates[index].image!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CandidateCard extends StatelessWidget {
  final String name;
  final String jobTitle;
  final String imageUrl;

  const CandidateCard({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.circular(12.r)),
      width: 140.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 150.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
          SizedBox(height: 4.h),
          Text(jobTitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
        ],
      ),
    );
  }
}

Widget buildActivityList() {
  return BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
    builder: (context, state) {
      if (state is RecentAcitivtyEmpty) {
        return Center(child: Text('No recent activities found.'));
      }

      final activities = context.read<HomeLayoutCubit>().recentActivities;
      final visibleActivities = activities.reversed.toList().take(3).toList();

      return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: visibleActivities.length,
          separatorBuilder: (context, index) => Divider(height: 1.h),
          itemBuilder: (context, index) {
            final activity = visibleActivities[index];
            return ListTile(
              leading: Icon(
                IconData(
                  activity.icon ?? 0,
                  fontFamily: 'MaterialIcons',
                ),
                color: Colors.black,
                size: 20.sp,
              ),
              title: Text(activity.name ?? "",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(
                DateFormat('yyyy-mm-dd').format(activity.time!),
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
              onTap: () {
                activity.route != null
                    ? Navigator.pushNamed(context, activity.route!)
                    : null;
              }, // TODO: Define tap action
            );
          },
        ),
      );
    },
  );
}
