# Zefaza - Premium E-Commerce App

A modern, minimal Flutter app inspired by Amazon's design principles but with a premium, luxury aesthetic.

## Features

### Design System
- **Premium Color Palette**: Black, gold accents, and soft whites for a luxury feel
- **Minimal UI**: Clean, spacious layouts with careful attention to typography
- **Material 3 Design**: Latest Material Design guidelines with custom theming
- **Responsive**: Adapts to different screen sizes

### Screens Implemented

1. **Home Screen**
   - Premium welcome header
   - Integrated search bar with filters
   - Category navigation
   - Featured banner with gradient design
   - Product grid with ratings and pricing
   - Smooth animations

2. **Search Screen**
   - Auto-focus search input
   - Category filters
   - Recent searches with chips
   - Popular products section
   - Quick add to cart functionality

3. **Cart Screen**
   - Swipe to delete items
   - Quantity controls
   - Price breakdown (subtotal, tax, shipping)
   - Free shipping indicator
   - Secure checkout button
   - Empty cart state

4. **Profile Screen**
   - User avatar with camera button
   - Gold member badge
   - User statistics (orders, spent, reviews)
   - Settings menu with icons
   - Premium membership highlight
   - Sign out option

### Key Features
- Bottom navigation with smooth transitions
- Consistent spacing and padding throughout
- Custom typography with proper hierarchy
- Shadow effects for depth
- Premium gold accents for special elements

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- iOS/Android development environment set up

### Installation

1. Navigate to the project directory:
   ```bash
   cd zefaza_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Supported Platforms
- iOS
- Android
- Web

## Project Structure

```
lib/
├── core/
│   ├── constants/      # App-wide constants
│   └── theme/          # Theme configuration
├── features/
│   ├── home/          # Home feature
│   ├── product/       # Product/Search feature
│   ├── cart/          # Shopping cart feature
│   └── profile/       # User profile feature
├── shared/
│   └── widgets/       # Shared widgets
└── main.dart          # App entry point
```

## Design Principles

1. **Minimalism**: Less is more - focus on content with clean layouts
2. **Premium Feel**: Gold accents and quality typography
3. **User-Centric**: Easy navigation and clear CTAs
4. **Performance**: Smooth animations and transitions
5. **Consistency**: Unified design language throughout

## Next Steps

To continue building this app, you might want to add:

1. **Backend Integration**: Connect to a real API
2. **Authentication**: User login/signup
3. **Product Details**: Detailed product pages
4. **Payment Integration**: Stripe or other payment gateways
5. **State Management**: Provider, Riverpod, or Bloc
6. **Animations**: More micro-interactions
7. **Dark Mode**: Complete dark theme implementation

## Color Palette

- Primary Black: `#0A0A0A`
- Premium Gold: `#D4AF37`
- Soft White: `#FAFAFA`
- Light Gray: `#F5F5F5`
- Medium Gray: `#E0E0E0`
- Dark Gray: `#757575`
- Accent Red: `#E53935`

## Contributing

Feel free to customize and expand upon this foundation to create your unique premium shopping experience!
