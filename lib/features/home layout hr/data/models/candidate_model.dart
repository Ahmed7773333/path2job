// ignore_for_file: public_member_api_docs, sort_constructors_first
class CandidateModel {
  int id;
  String? name;
  String? job;
  String? image;
  String? summary;
  List<String>? skills;
  String? phone;
  String? email;
  List<Exps>? experinces;
  CandidateModel({
    required this.id,
    this.name,
    this.job,
    this.image,
    this.summary,
    this.skills,
    this.phone,
    this.email,
    this.experinces,
  });
}

class Exps {
  String companyName;
  String discription;
  String startDate;
  String endDate;
  Exps({
    required this.companyName,
    required this.discription,
    required this.startDate,
    required this.endDate,
  });
}

final List<CandidateModel> fakeCandidates = [
  CandidateModel(id:0,
    name: 'Liam Carter',
    job: 'Mobile Developer',
    image: 'https://randomuser.me/api/portraits/men/1.jpg',
    summary:
        'Flutter enthusiast with 3+ years of experience in building cross-platform apps.',
    skills: ['Flutter', 'Dart', 'Firebase', 'Git', 'REST APIs'],
    phone: '+201095673421',
    email: 'liam.carter@example.com',
    experinces: [
      Exps(
          companyName: 'Appify',
          discription: 'Built mobile apps using Flutter.',
          startDate: 'Jan 2022',
          endDate: 'Present'),
      Exps(
          companyName: 'DevCo',
          discription: 'Maintained legacy Android apps.',
          startDate: 'Jun 2020',
          endDate: 'Dec 2021'),
    ],
  ),
  CandidateModel(id:1,
    name: 'Noah Bennett',
    job: 'Backend Engineer',
    image: 'https://randomuser.me/api/portraits/men/15.jpg',
    summary: 'Node.js and Express expert with solid database knowledge.',
    skills: ['Node.js', 'Express', 'MongoDB', 'Docker', 'AWS'],
    phone: '+201002345678',
    email: 'noah.bennett@example.com',
    experinces: [
      Exps(
          companyName: 'CloudBase',
          discription: 'Developed and deployed RESTful APIs.',
          startDate: 'Mar 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'Datacore',
          discription: 'Worked on backend infrastructure.',
          startDate: 'Feb 2019',
          endDate: 'Feb 2021'),
    ],
  ),
  CandidateModel(id:2,
    name: 'Ethan Ross',
    job: 'UI/UX Designer',
    image: 'https://randomuser.me/api/portraits/men/3.jpg',
    summary:
        'Creative designer focused on user-centric mobile and web interfaces.',
    skills: ['Figma', 'Adobe XD', 'Sketch', 'Prototyping', 'User Research'],
    phone: '+201014567890',
    email: 'ethan.ross@example.com',
    experinces: [
      Exps(
          companyName: 'DesignHub',
          discription: 'Led UI redesign projects.',
          startDate: 'May 2020',
          endDate: 'Present'),
      Exps(
          companyName: 'PixelPerfect',
          discription: 'Created design systems.',
          startDate: 'Jan 2018',
          endDate: 'Apr 2020'),
    ],
  ),
  CandidateModel(id:3,
    name: 'Mason Wright',
    job: 'Frontend Developer',
    image: 'https://randomuser.me/api/portraits/men/4.jpg',
    summary: 'Skilled React developer with a flair for animations and UI.',
    skills: ['React', 'TypeScript', 'CSS Modules', 'Next.js', 'Redux'],
    phone: '+201023456781',
    email: 'mason.wright@example.com',
    experinces: [
      Exps(
          companyName: 'Webify',
          discription: 'Worked on responsive web apps.',
          startDate: 'Aug 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'CodeLogic',
          discription: 'Improved performance in legacy codebases.',
          startDate: 'May 2019',
          endDate: 'Jul 2021'),
    ],
  ),
  CandidateModel(id:4,
    name: 'Logan Cooper',
    job: 'DevOps Engineer',
    image: 'https://randomuser.me/api/portraits/men/5.jpg',
    summary: 'Automation geek with a strong background in CI/CD pipelines.',
    skills: ['Jenkins', 'Kubernetes', 'Docker', 'Terraform', 'Linux'],
    phone: '+201056789432',
    email: 'logan.cooper@example.com',
    experinces: [
      Exps(
          companyName: 'OpsGenie',
          discription: 'Managed cloud infrastructure.',
          startDate: 'Jan 2020',
          endDate: 'Present'),
      Exps(
          companyName: 'InfraTech',
          discription: 'Set up CI/CD workflows.',
          startDate: 'Mar 2018',
          endDate: 'Dec 2019'),
    ],
  ),
  CandidateModel(id:5,
    name: 'James Hall',
    job: 'Data Scientist',
    image: 'https://randomuser.me/api/portraits/men/6.jpg',
    summary: 'Data wizard who loves to find patterns in chaos.',
    skills: ['Python', 'Pandas', 'Scikit-learn', 'TensorFlow', 'SQL'],
    phone: '+201078945612',
    email: 'james.hall@example.com',
    experinces: [
      Exps(
          companyName: 'DeepData',
          discription: 'Built ML models for predictions.',
          startDate: 'Jul 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'DataSight',
          discription: 'Analyzed customer data trends.',
          startDate: 'Feb 2019',
          endDate: 'Jun 2021'),
    ],
  ),
  CandidateModel(id:6,
    name: 'Benjamin Gray',
    job: 'QA Engineer',
    image: 'https://randomuser.me/api/portraits/men/7.jpg',
    summary: 'Detail-oriented tester passionate about automation.',
    skills: ['Selenium', 'Postman', 'JUnit', 'TestRail', 'CI/CD'],
    phone: '+201034567893',
    email: 'benjamin.gray@example.com',
    experinces: [
      Exps(
          companyName: 'TestCraft',
          discription: 'Created test cases for web apps.',
          startDate: 'Apr 2020',
          endDate: 'Present'),
      Exps(
          companyName: 'BugSquash',
          discription: 'Wrote automation scripts.',
          startDate: 'Sep 2018',
          endDate: 'Mar 2020'),
    ],
  ),
  CandidateModel(id:7,
    name: 'Jackson Reed',
    job: 'AI Engineer',
    image: 'https://randomuser.me/api/portraits/men/8.jpg',
    summary:
        'Specializes in building intelligent systems using neural networks.',
    skills: ['Python', 'PyTorch', 'NLP', 'Deep Learning', 'Data Engineering'],
    phone: '+201088765432',
    email: 'jackson.reed@example.com',
    experinces: [
      Exps(
          companyName: 'NeuroNet',
          discription: 'Created ML models for text generation.',
          startDate: 'Jun 2022',
          endDate: 'Present'),
      Exps(
          companyName: 'AI Labs',
          discription: 'Worked on smart recommendation engines.',
          startDate: 'Mar 2020',
          endDate: 'May 2022'),
    ],
  ),
  CandidateModel(id:8,
    name: 'Caleb Morris',
    job: 'Cybersecurity Analyst',
    image: 'https://randomuser.me/api/portraits/men/9.jpg',
    summary: 'Passionate about protecting digital infrastructure and data.',
    skills: [
      'Ethical Hacking',
      'Firewalls',
      'SIEM',
      'Linux Security',
      'Python'
    ],
    phone: '+201012345699',
    email: 'caleb.morris@example.com',
    experinces: [
      Exps(
          companyName: 'SecureX',
          discription: 'Handled vulnerability scans and patching.',
          startDate: 'Jan 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'SafeGuard',
          discription: 'Conducted penetration testing.',
          startDate: 'Jul 2019',
          endDate: 'Dec 2020'),
    ],
  ),
  CandidateModel(id:9,
    name: 'Elijah Brooks',
    job: 'Product Manager',
    image: 'https://randomuser.me/api/portraits/men/10.jpg',
    summary: 'Loves turning ideas into scalable digital products.',
    skills: ['Agile', 'Scrum', 'JIRA', 'Roadmaps', 'User Stories'],
    phone: '+201077889911',
    email: 'elijah.brooks@example.com',
    experinces: [
      Exps(
          companyName: 'Prodify',
          discription: 'Led cross-functional agile teams.',
          startDate: 'Aug 2020',
          endDate: 'Present'),
      Exps(
          companyName: 'VisionTech',
          discription: 'Defined product vision and priorities.',
          startDate: 'Jan 2018',
          endDate: 'Jul 2020'),
    ],
  ),
  CandidateModel(id:10,
    name: 'Nathan Lewis',
    job: 'Database Administrator',
    image: 'https://randomuser.me/api/portraits/men/11.jpg',
    summary: 'Ensures data integrity, performance, and security.',
    skills: [
      'PostgreSQL',
      'MySQL',
      'Backup & Recovery',
      'Replication',
      'SQL Tuning'
    ],
    phone: '+201033322211',
    email: 'nathan.lewis@example.com',
    experinces: [
      Exps(
          companyName: 'DataNest',
          discription: 'Managed high-load DB servers.',
          startDate: 'May 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'StoreGrid',
          discription: 'Optimized queries and indexing.',
          startDate: 'Feb 2019',
          endDate: 'Apr 2021'),
    ],
  ),
  CandidateModel(id:11,
    name: 'Henry Collins',
    job: 'Cloud Architect',
    image: 'https://randomuser.me/api/portraits/men/12.jpg',
    summary: 'Helps organizations scale securely in the cloud.',
    skills: ['AWS', 'Azure', 'Microservices', 'DevOps', 'Kubernetes'],
    phone: '+201055566677',
    email: 'henry.collins@example.com',
    experinces: [
      Exps(
          companyName: 'CloudWorks',
          discription: 'Designed and deployed cloud-native apps.',
          startDate: 'Sep 2020',
          endDate: 'Present'),
      Exps(
          companyName: 'NextScale',
          discription: 'Migrated infrastructure to AWS.',
          startDate: 'Apr 2018',
          endDate: 'Aug 2020'),
    ],
  ),
  CandidateModel(id:12,
    name: 'Jayden Perez',
    job: 'Full Stack Developer',
    image: 'https://randomuser.me/api/portraits/men/13.jpg',
    summary: 'Builds sleek frontend and scalable backend systems.',
    skills: ['Vue.js', 'Laravel', 'TypeScript', 'MySQL', 'REST APIs'],
    phone: '+201066654433',
    email: 'jayden.perez@example.com',
    experinces: [
      Exps(
          companyName: 'WebWorks',
          discription: 'Created dashboards and admin panels.',
          startDate: 'Nov 2021',
          endDate: 'Present'),
      Exps(
          companyName: 'CodeCrafters',
          discription: 'Developed full-stack web portals.',
          startDate: 'Jan 2020',
          endDate: 'Oct 2021'),
    ],
  ),
];
