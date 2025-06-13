import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path2job/features/home%20layout%20hr/data/models/candidate_model.dart';
import 'package:path2job/features/home%20layout%20hr/presentation/bloc/home_layout_hr_bloc.dart';
import 'package:path2job/hive/favs.dart';

class CandidateDetails extends StatelessWidget {
  const CandidateDetails(this.candidateModel, {super.key});
  final CandidateModel candidateModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${candidateModel.name} Profile'),
        centerTitle: true,
        actions: [
          BlocBuilder<HomeLayoutHrBloc, HomeLayoutHrState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    final bool isFav = context
                        .read<HomeLayoutHrBloc>()
                        .favorites
                        .contains(FavoritModel(candidateModel.id));
                    context.read<HomeLayoutHrBloc>().add(isFav
                        ? DeleteFavoriteEvent(candidateModel.id)
                        : AddFavoriteEvent(candidateModel.id));
                    context.read<HomeLayoutHrBloc>().add(GetAllFavoriteEvent());
                  },
                  icon: Icon(
                    context
                            .read<HomeLayoutHrBloc>()
                            .favorites
                            .contains(FavoritModel(candidateModel.id))
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: Colors.yellow,
                  ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Align(
              alignment: AlignmentDirectional.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(candidateModel.image ?? ''),
              ),
            ),
            const SizedBox(height: 12),
            // Name & Job
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                candidateModel.name ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                candidateModel.job ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            // Summary
            Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              candidateModel.summary ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            // Skills
            Text(
              'Skills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: candidateModel.skills
                      ?.map((skill) => Chip(label: Text(skill)))
                      .toList() ??
                  [],
            ),
            const SizedBox(height: 20),
            // Experience
            Text(
              'Experience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...?candidateModel.experinces?.map(
              (exp) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.companyName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('${exp.startDate} - ${exp.endDate}'),
                  Text(exp.discription),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const Divider(height: 32, thickness: 1),
            // Contact Info
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 20),
                const SizedBox(width: 8),
                Text(candidateModel.phone ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 20),
                const SizedBox(width: 8),
                Text(candidateModel.email ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
