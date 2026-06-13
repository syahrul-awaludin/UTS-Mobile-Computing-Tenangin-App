import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/character_painter.dart';
import '../widgets/mood_card.dart';
import '../widgets/tenangin_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDateIndex = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildDateSelector(),
            const SizedBox(height: 24),
            _buildGreetingBanner(),
            const SizedBox(height: 24),
            _buildMoodHistory(),
            const SizedBox(height: 32),
            _buildPersonalitiesTest(),
            const SizedBox(height: 32),
            _buildDailyAffirmation(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/Logo_Primary.png',
          height: 28,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '12',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.notifications_none, color: AppColors.textHeading, size: 28),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    
    return SizedBox(
      height: 70, // Fixed height for the horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 30,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedDateIndex;
          final dayName = days[index % 7];
          final dateNumber = (index + 1).toString();
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDateIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? AppColors.textHeading : AppColors.textCaption,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.primary : Colors.white,
                      border: isSelected ? null : Border.all(color: AppColors.borderDefault),
                    ),
                    child: Center(
                      child: Text(
                        dateNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white : AppColors.textHeading,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGreetingBanner() {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        color: const Color(0xFF4D22B5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // Decorative squiggles
          Positioned(
            top: 20,
            right: 120,
            child: SizedBox(
              width: 30,
              height: 20,
              child: CustomPaint(
                painter: SquigglePainter(color: AppColors.primaryLight),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 180,
            child: SizedBox(
              width: 30,
              height: 30,
              child: CustomPaint(
                painter: SquigglePainter(color: AppColors.primaryLight),
              ),
            ),
          ),
          // Character illustration
          Positioned(
            right: 16,
            bottom: 0,
            child: Image.asset(
              'assets/images/Home_Illustration.png',
              height: 140,
              fit: BoxFit.contain,
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Good Morning, Sarah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryFocused,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text('Add Mood', style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodHistory() {
    return Column(
      children: const [
        MoodCard(
          date: '11 Juni 2025',
          feeling: 'I\'m Feeling Good',
          moodColor: AppColors.moodHappy,
          expression: MoodExpression.happy,
        ),
        SizedBox(height: 12),
        MoodCard(
          date: '10 Juni 2025',
          feeling: 'I\'m Feeling Anxious',
          moodColor: AppColors.moodAnxious,
          expression: MoodExpression.neutral,
        ),
        SizedBox(height: 12),
        MoodCard(
          date: '9 Juni 2025',
          feeling: 'I\'m Feeling Stress',
          moodColor: AppColors.moodStress,
          expression: MoodExpression.sad,
        ),
      ],
    );
  }

  Widget _buildPersonalitiesTest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalities Test',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTestCard('Childhood Trauma', '10 mins', '20 questions', 'assets/images/trauma_childhood.png'),
              const SizedBox(width: 12),
              _buildTestCard('Emotional Intelligence', '15 mins', '30 questions', 'assets/images/emotional_inteligence.png'),
              const SizedBox(width: 12),
              _buildTestCard('Emotional Intelligence', '15 mins', '30 questions', 'assets/images/emotional_inteligence.png'),
              const SizedBox(width: 12),
              _buildTestCard('Emotional Intelligence', '15 mins', '30 questions', 'assets/images/emotional_inteligence.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestCard(String title, String time, String questions, String imagePath) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textCaption),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
              const SizedBox(width: 12),
              const Icon(Icons.article_outlined, size: 14, color: AppColors.textCaption),
              const SizedBox(width: 4),
              Text(questions, style: const TextStyle(fontSize: 12, color: AppColors.textCaption)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyAffirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dailfy Affirmation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              // Logo
              Image.asset('assets/images/Logo_Primary.png', height: 28),
              const SizedBox(height: 32),
              
              // Quote Text
              Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Text(
                      'Be Honest and Powerfull as Yourself',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textHeading,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: const Text(
                      '"',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 64,
                        color: AppColors.textHeading,
                        height: 0.8,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: const Text(
                      '"',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 64,
                        color: AppColors.textHeading,
                        height: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Share Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.ios_share, color: Colors.white),
                  label: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarySoft,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
