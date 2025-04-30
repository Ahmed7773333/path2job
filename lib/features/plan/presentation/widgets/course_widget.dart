import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 8),

              // Progress Bar
              _buildProgressIndicator(context),
              const SizedBox(height: 12),

              // Description with expandable functionality
              _buildDescription(context),
              const SizedBox(height: 8),

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
      borderRadius: BorderRadius.circular(4),
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
                padding: const EdgeInsets.only(bottom: 8),
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
