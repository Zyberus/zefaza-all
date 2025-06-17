import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';
import '../../../main.dart';
import '../../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Multiple animation controllers for complex animations
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  
  // Logo animations
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotateAnimation;
  late Animation<double> _logoOpacityAnimation;
  
  // Background animations
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<double> _backgroundGradientPositionAnimation;
  
  // Text animations
  late Animation<double> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  
  // Particle system variables
  final List<ParticleModel> _particles = [];
  final int _particleCount = 30;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    
    // Initialize particle system
    _initParticles();
    
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    
    // Particle animation controller
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();
    
    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Background animation controller
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    // Configure animations
    _setupAnimations();
    
    // Start animations in sequence
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      _textController.forward();
    });
    _backgroundController.forward();
    
    // Navigate to main screen after animations
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOutCubic;
            
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityAnimation = animation.drive(tween);
            
            return FadeTransition(opacity: opacityAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }
  
  void _setupAnimations() {
    // Logo scale animation
    _logoScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2).chain(
          CurveTween(curve: Curves.easeOutCubic),
        ),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0).chain(
          CurveTween(curve: Curves.elasticOut),
        ),
        weight: 60,
      ),
    ]).animate(_logoController);
    
    // Logo rotation animation
    _logoRotateAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );
    
    // Logo opacity animation
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );
    
    // Background color animation
    _backgroundColorAnimation = ColorTween(
      begin: Colors.black,
      end: AppTheme.primaryBlack,
    ).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Background gradient position animation
    _backgroundGradientPositionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Text slide animation
    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.elasticOut,
      ),
    );
    
    // Text opacity animation
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
  }
  
  void _initParticles() {
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(ParticleModel(
        position: Offset(
          _random.nextDouble() * 400 - 200,
          _random.nextDouble() * 400 - 200,
        ),
        speed: _random.nextDouble() * 2 + 0.5,
        theta: _random.nextDouble() * 2 * math.pi,
        size: _random.nextDouble() * 15 + 5,
        opacity: _random.nextDouble() * 0.6 + 0.2,
      ));
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _particleController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _logoController, 
          _particleController, 
          _textController, 
          _backgroundController
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColorAnimation.value ?? Colors.black,
                  Color.lerp(
                    const Color(0xFF1A1A1A), 
                    AppTheme.premiumGold.withOpacity(0.3),
                    _backgroundGradientPositionAnimation.value
                  ) ?? const Color(0xFF1A1A1A),
                ],
                stops: [0.3, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated particles
                ..._buildParticles(size),
                
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated logo
                      Transform.rotate(
                        angle: _logoRotateAnimation.value,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Opacity(
                            opacity: _logoOpacityAnimation.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppTheme.premiumGold,
                                    AppTheme.premiumGold.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.premiumGold.withOpacity(0.5),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Z",
                                  style: TextStyle(
                                    color: AppTheme.primaryBlack,
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Animated app name
                      Transform.translate(
                        offset: Offset(0, _textSlideAnimation.value),
                        child: Opacity(
                          opacity: _textOpacityAnimation.value,
                          child: const Column(
                            children: [
                              Text(
                                "ZEFAZA",
                                style: TextStyle(
                                  color: AppTheme.softWhite,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 8,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "PREMIUM SHOPPING EXPERIENCE",
                                style: TextStyle(
                                  color: AppTheme.premiumGold,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Shimmer effect at the bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildShimmerEffect(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  List<Widget> _buildParticles(Size size) {
    return _particles.map((particle) {
      // Update particle position based on animation
      final progress = _particleController.value;
      final double radiusX = size.width / 2 * particle.speed;
      final double radiusY = size.height / 2 * particle.speed * 0.6;
      
      final double updatedX = math.cos(particle.theta + progress * 2 * math.pi) * radiusX;
      final double updatedY = math.sin(particle.theta + progress * 2 * math.pi) * radiusY;
      
      // Calculate opacity with a safety clamp to ensure it's between 0.0 and 1.0
      final calculatedOpacity = particle.opacity * (0.4 + 0.6 * math.sin(progress * 2 * math.pi));
      final safeOpacity = calculatedOpacity.clamp(0.0, 1.0);
      
      return Positioned(
        left: size.width / 2 + updatedX,
        top: size.height / 2 + updatedY,
        child: Opacity(
          opacity: safeOpacity,
          child: Container(
            width: particle.size,
            height: particle.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.premiumGold.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.premiumGold.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
  
  Widget _buildShimmerEffect() {
    // Calculate sine wave value with safety clamp
    final sineValue = 20 * math.sin(_particleController.value * 2 * math.pi);
    
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppTheme.premiumGold.withOpacity(0.1),
            AppTheme.premiumGold.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
      ),
      child: Center(
        child: Transform.translate(
          offset: Offset(0, sineValue),
          child: Text(
            "SWIPE UP",
            style: TextStyle(
              color: AppTheme.softWhite.withOpacity(0.3),
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class ParticleModel {
  Offset position;
  double speed;
  double theta;
  double size;
  double opacity;
  
  ParticleModel({
    required this.position,
    required this.speed,
    required this.theta,
    required this.size,
    required this.opacity,
  });
} 