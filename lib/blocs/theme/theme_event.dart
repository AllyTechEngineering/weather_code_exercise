part of 'theme_bloc.dart';

/// BLoC "event" represents an occurrence or an action that is dispatched to the BLoC to trigger a state change. Events are used to convey user interactions, external inputs, or any other action that should be handled by the business logic in the BLoC.
/// Purpose of Events: events are a way to communicate user actions, such as button clicks, text input changes, network requests, etc., to the BLoC.Events act as triggers for the BLoC to perform certain operations or computations based on the received events.
/// Dispatching Events: Events are dispatched to the BLoC by calling methods on the BLoC, typically through a method like add or dispatch. The BLoC listens for these events and reacts by updating its state accordingly.
/// Handling Events: The BLoC defines how to handle each type of event. This is typically done in the mapEventToState method, where events are mapped to new states. The logic for processing events and transitioning to new states is encapsulated within the BLoC.
///
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;
  ChangeThemeEvent({
    required this.appTheme,
  });
}
