import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../hive/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseCard({super.key, required this.course, this.onTap});

  double get completionPercentage {
if (course.done == true) {
      return 100.0;
    }
    if (course.numberOfvideos == null ||
        course.numberOfvideos == 0 ||
        course.numberOfvideosDone == null) {
      return 0;
    }
    return (course.numberOfvideosDone! / course.numberOfvideos!) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Title
              Text(
                course.courseName ?? 'Untitled Course',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),

              // Progress Bar
              _buildProgressIndicator(context),
              SizedBox(height: 12.h),

              // Description with expandable functionality
              _buildDescription(context),
              SizedBox(height: 8.h),

              // Completion Percentage
              _buildCompletionText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: LinearProgressIndicator(
        value: completionPercentage / 100,
        minHeight: 8,
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation<Color>(
          completionPercentage > 0
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: course.courseDescription ?? 'No description available',
          style: Theme.of(context).textTheme.bodyMedium,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 3,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(
              course.courseDescription ?? 'No description available',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  course.courseDescription ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          );
        } else {
          return Text(
            course.courseDescription ?? 'No description available',
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
      },
    );
  }

  Widget _buildCompletionText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Progress: ${completionPercentage.toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        Text(
          '${course.numberOfvideosDone ?? 0}/${course.numberOfvideos ?? 0} videos',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}
