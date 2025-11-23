# The Alphermix - Architecture Document

## App Overview
A production-ready Flutter app that generates novel business concepts by fusing two unreleased ideas. Features beautiful animations, AI-powered concept generation, uniqueness research, and visual asset creation.

## Core Features
1. **Splash Screen** - Animated logo with particle effects and typing tagline
2. **Concept Input Lab** - Dual concept input with glassmorphic cards and animated VS icon
3. **Fusion Processing** - Multi-stage animation showing concept merging, research, and asset generation
4. **Results Dashboard** - Display generated concept with logo, banner, pitch, description, and business plan
5. **API Integration** - OpenAI (concept blending), Replicate (image generation), Perplexity (uniqueness research)

## Design Philosophy
- **Animation-First**: Every interaction has purposeful, fluid motion
- **Modern UI**: Sleek gradients, glassmorphism, generous spacing
- **60fps Performance**: Optimized animations for mid-range devices
- **Haptic Feedback**: Synchronized with visual animations

## Technology Stack
- **Framework**: Flutter/Dart
- **State Management**: ValueNotifier & StatefulWidgets
- **Animations**: AnimationController, Rive, Lottie (fallback)
- **Storage**: SharedPreferences for API keys and history
- **HTTP**: http package for API calls
- **APIs**: OpenAI, Replicate MCP, Perplexity

## Data Models
Located in `lib/models/`:
1. **ConceptInput** - User's input concepts (A & B)
2. **FusionResult** - Complete fusion output with all generated content
3. **User** - User profile and API configuration

## Services
Located in `lib/services/`:
1. **OpenAIService** - Concept fusion and content generation
2. **ReplicateService** - Logo and banner image generation
3. **PerplexityService** - Web research for uniqueness validation
4. **StorageService** - Local storage for API keys and history
5. **FusionOrchestrator** - Coordinates all services and manages fusion process

## Screen Structure
```
lib/
├── main.dart
├── theme.dart
├── models/
│   ├── concept_input.dart
│   ├── fusion_result.dart
│   └── user.dart
├── services/
│   ├── openai_service.dart
│   ├── replicate_service.dart
│   ├── perplexity_service.dart
│   ├── storage_service.dart
│   └── fusion_orchestrator.dart
├── screens/
│   ├── splash_screen.dart
│   ├── concept_lab_screen.dart
│   ├── fusion_processing_screen.dart
│   └── results_dashboard_screen.dart
├── widgets/
│   ├── animated_logo.dart
│   ├── glassmorphic_card.dart
│   ├── concept_input_card.dart
│   ├── fusion_button.dart
│   ├── vs_icon_widget.dart
│   ├── processing_animation.dart
│   ├── progress_indicator_widget.dart
│   └── result_card.dart
└── utils/
    ├── constants.dart
    ├── animation_curves.dart
    └── haptic_feedback.dart
```

## Animation Strategy
1. **Entry Animations**: Staggered slides with elastic bounce
2. **Interaction Feedback**: Scale, glow, and color transitions
3. **Processing**: Multi-stage Rive animation with particle effects
4. **Result Reveal**: Hero animations and parallax scrolling

## API Integration Flow
1. User inputs Concept A & B
2. OpenAI generates fusion concept name, tagline, description, pitch, business plan
3. Perplexity researches web for similar concepts (uniqueness check)
4. Replicate generates logo and banner images
5. Display complete results with visual assets

## Security
- API keys stored encrypted in SharedPreferences
- Keys never logged or exposed in UI
- Secure HTTPS for all API calls

## Performance Optimization
- RepaintBoundary for particle systems
- Cached Rive/Lottie assets
- Limit particles to 100 max
- Device performance tier detection

## Implementation Steps
1. ✅ Create architecture document
2. ✅ Add dependencies (http, shared_preferences, lottie, rive, flutter_animate)
3. ✅ Update theme with gradient colors for fusion aesthetic
4. ✅ Create data models (User, ConceptInput, FusionResult)
5. ✅ Build service layer (Storage, OpenAI, Replicate, Perplexity, Orchestrator)
6. ✅ Implement splash screen with animated logo and typewriter effect
7. ✅ Build concept lab input screen with glassmorphic cards and VS animation
8. ✅ Create fusion processing screen with multi-stage custom-painted animations
9. ✅ Build results dashboard with expandable sections and image display
10. ✅ Add API key configuration screen with secure storage
11. ✅ Integrate all services through FusionOrchestrator
12. ✅ Test and debug with compile_project - NO ERRORS
