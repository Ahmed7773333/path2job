import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/plan/presentation/cubit/plan_cubit.dart';
import 'package:path2job/features/plan/presentation/widgets/plan_content.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/componetns.dart';
import '../widgets/empty_page.dart';

class CareerPlanPage extends StatefulWidget {
  const CareerPlanPage({super.key});

  @override
  State<CareerPlanPage> createState() => _CareerPlanPageState();
}

class _CareerPlanPageState extends State<CareerPlanPage> {
  @override
  void initState() {
    super.initState();
    // Trigger sync when page initializes
    context.read<PlanCubit>().sync();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanState>(
      builder: (context, state) {
        if (state is CourseSyncLoading) {
          Components.circularProgressLoad(context);
        } else if (state is CourseSyncError) {
          Components.showMessage(context,
              content: state.error,
              icon: Icons.error,
              color: AppColor.errorColor);
        } else if (state is CourseSyncEmpty) {
          return const EmptyPlanPage();
        } else if (state is CourseSyncSuccess) {
          return PlanContent(); // Your actual content widget
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
