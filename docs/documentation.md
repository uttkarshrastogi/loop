# AI Journey Feature Documentation

## Overview
The AI Journey feature is a personalized goal achievement system that uses AI to create customized learning plans based on user goals, deadlines, and daily routines. The feature integrates with OpenAI for plan generation and optionally with Google Calendar for time management.

## Architecture
The feature follows the project's clean architecture pattern with:
- **Data Models**: Store user routines, AI-generated tasks, and user preferences
- **Services**: Handle AI integration and data management
- **BLoC Pattern**: Manage state and business logic
- **UI Screens**: Provide user interaction

## Components

### Models
1. **UserRoutineModel**
   - Stores user's daily routine (wake-up time, sleep time, work hours, fixed activities)
   - Located at: `/lib/feature/user/data/models/user_routine_model.dart`

2. **AiGeneratedTaskModel**
   - Stores AI-generated tasks (title, description, estimated hours, source, completion status)
   - Located at: `/lib/feature/user/data/models/ai_generated_task_model.dart`

3. **UserPreferencesModel**
   - Stores user preferences (timezone, blocked hours, focus type)
   - Located at: `/lib/feature/user/data/models/user_preferences_model.dart`

### Services
1. **OpenAI Service**
   - Handles communication with OpenAI API
   - Generates personalized learning plans and feedback
   - Located at: `/lib/core/services/openai_service.dart`

2. **AI Planner Service**
   - Uses OpenAI service to generate and manage learning plans
   - Handles task distribution and management
   - Located at: `/lib/feature/journey/data/services/ai_planner_service.dart`

3. **Calendar Service (Optional)**
   - Integrates with Google Calendar
   - Identifies available time slots for learning activities
   - Implementation is basic and can be extended

### BLoC Components
1. **JourneyBloc**
   - Manages state for the journey feature
   - Handles events like loading tasks, generating plans, updating task status
   - Located at: `/lib/feature/journey/presentation/bloc/journey_bloc.dart`

2. **JourneyEvent**
   - Defines events for the journey feature
   - Located at: `/lib/feature/journey/presentation/bloc/journey_event.dart`

3. **JourneyState**
   - Defines states for the journey feature
   - Located at: `/lib/feature/journey/presentation/bloc/journey_state.dart`

### Screens
1. **GoalInputScreen**
   - Prompts user for goal and deadline
   - Located at: `/lib/feature/journey/presentation/pages/goal_input_screen.dart`

2. **RoutineInputScreen**
   - Collects user's daily routine information
   - Located at: `/lib/feature/journey/presentation/pages/routine_input_screen.dart`

3. **CalendarIntegrationScreen**
   - Allows Google Calendar integration
   - Located at: `/lib/feature/journey/presentation/pages/calendar_integration_screen.dart`

4. **TodoJourneyScreen**
   - Displays AI-generated tasks grouped by date
   - Allows marking tasks as completed or skipped
   - Located at: `/lib/feature/journey/presentation/pages/todo_journey_screen.dart`

5. **DailyCheckInScreen**
   - Shows today's tasks
   - Collects user feedback
   - Provides AI-generated adjustments
   - Located at: `/lib/feature/journey/presentation/pages/daily_checkin_screen.dart`

## Integration
The feature is integrated into the app through:
- **Route Configuration**: Added to the app's router in `journey_integration.dart`
- **Provider Setup**: BLoC providers configured in `journey_integration.dart`
- **Dashboard Integration**: Button added to start the journey

## User Flow
1. User starts the journey from the dashboard
2. User enters goal and deadline on GoalInputScreen
3. User provides daily routine on RoutineInputScreen
4. (Optional) User connects Google Calendar on CalendarIntegrationScreen
5. AI generates a personalized learning plan
6. User views and interacts with tasks on TodoJourneyScreen
7. User provides daily feedback on DailyCheckInScreen

## Future Enhancements
1. **Advanced Calendar Integration**: More sophisticated time slot identification
2. **Learning Analytics**: Track progress and provide insights
3. **Social Features**: Share goals and progress with friends
4. **Adaptive Learning**: Adjust difficulty based on user performance
5. **Offline Support**: Cache plans for offline access

## API Keys and Security
- OpenAI API key is currently hardcoded in `journey_integration.dart`
- In production, this should be moved to secure storage or environment variables
- Google Calendar integration uses standard OAuth flow

## Testing
The feature has been tested for:
- Basic functionality
- Integration with existing app components
- UI consistency with app design

## Dependencies
- OpenAI API for plan generation
- Google Sign-In for calendar integration
- Firebase Firestore for data storage
- Flutter BLoC for state management
