import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/Interview/presentation/cubit/interview_cubit.dart';
import 'package:path2job/core/utils/assets.dart';
import 'add_question.dart';
import 'question_list.dart';

class CategoryFaq extends StatefulWidget {
  const CategoryFaq(this.jobName, {super.key});
  final String jobName;

  @override
  State<CategoryFaq> createState() => _CategoryFaqState();
}

class _CategoryFaqState extends State<CategoryFaq> {
  @override
  void initState() {
    context.read<InterviewCubit>().syncQuestions(widget.jobName);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<InterviewCubit>().syncCategories();

            Navigator.pop(context);
          },
          tooltip: 'Back',
        ),
        title: Text(widget.jobName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<InterviewCubit>().syncQuestions(widget.jobName),
            tooltip: 'Refresh questions',
          ),
        ],
      ),
      body: Column(
        children: [
          // Action buttons with better styling
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.add_circle_outline,
                  label: 'Custom',
                  onPressed: () => _showAddQuestionSheet(context),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                _buildActionButton(
                  context,
                  icon: Icons.auto_awesome,
                  label: 'Generate',
                  onPressed: () => context
                      .read<InterviewCubit>()
                      .generateQuestions(widget.jobName),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Content area
          BlocBuilder<InterviewCubit, InterviewState>(
            builder: (context, state) {
              if (state is InterviewLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is InterviewError) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              } else if (state is QuestionSyncEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.emptyFaq, width: 200),
                    const SizedBox(height: 16),
                    Text(
                      'No questions yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the buttons above to add some',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              } else if (state is InterviewLoaded) {
                return QuestionsList(context.read<InterviewCubit>().questions);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: 120,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 20),
        label: Text(label),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showAddQuestionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddQuestionSheet(widget.jobName),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}
