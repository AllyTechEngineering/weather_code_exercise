part of 'temp_settings_bloc.dart';

/// BLoC "event" represents an occurrence or an action that is dispatched to the BLoC to trigger a state change. Events are used to convey user interactions, external inputs, or any other action that should be handled by the business logic in the BLoC.
/// Purpose of Events: events are a way to communicate user actions, such as button clicks, text input changes, network requests, etc., to the BLoC.Events act as triggers for the BLoC to perform certain operations or computations based on the received events.
/// Dispatching Events: Events are dispatched to the BLoC by calling methods on the BLoC, typically through a method like add or dispatch. The BLoC listens for these events and reacts by updating its state accordingly.
/// Handling Events: The BLoC defines how to handle each type of event. This is typically done in the mapEventToState method, where events are mapped to new states. The logic for processing events and transitioning to new states is encapsulated within the BLoC.
///
//A sealed class is a class hierarchy in which you define a limited set of subclasses, and no other subclasses can be added. Sealed classes are often used in BLoC patterns to represent a finite set of events or states.
sealed class TempSettingsEvent extends Equatable {
  const TempSettingsEvent(); //default constructor and created at compile time (uses const)

  @override
  List<Object> get props => []; // props getter for checking equality
}

// subclass to indicate the type of event related to toggling the temperature unit
class ToggleTempUnitEvent extends TempSettingsEvent {}
