import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';

part 'temp_settings_state.dart';

// TempSettingsEvent and TempSettingsState define the types of events and states handled by this BloC
class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingsState> {
  TempSettingsBloc() : super(TempSettingsState.initial()) {
    on<ToggleTempUnitEvent>(_toggleTempUnit);
    // Registers an event handler for the ToggleTempUnitEvent.
    // When this event is dispatched, the _toggleTempUnit method will be called.
  }

// this is the event handling method
// _toggleTempUnit takes ToggleTempUnitEvent event, Emitter<TempSettingsState> emit, as parameters.
// ToggleTempUnitEvent event: this parameter represents the incoming event object.
// Emitter<TempSettingsState> emit: The emit parameter is a callback function provided by the BLoC library. It is used to emit new states in response to the handled event. In this case, it is specifically an Emitter for the TempSettingsState type, indicating that the method can emit states corresponding to the TempSettingsState class.

  void _toggleTempUnit(
    ToggleTempUnitEvent event,
    Emitter<TempSettingsState> emit,
  ) {
    // copyWith of the current state. Commonly used for immutable objects,
    // and it creates a new instance of the
    // object with some fields updated while keeping the original object unchanged.
    // This emit method is toggling the between c and f
    emit(
      state.copyWith(
        temperatureUnit: state.temperatureUnit == TemperatureUnit.celsiusStatus
            ? TemperatureUnit.fahrenheitStatus
            : TemperatureUnit.celsiusStatus,
      ), // ternary operator: condition ? trueValue : falseValue
    );
  }
}
