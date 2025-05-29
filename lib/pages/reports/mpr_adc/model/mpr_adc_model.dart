import 'package:flutter_riverpod/flutter_riverpod.dart';

class MprAdcState {
  final List<String> machineList;
  final List<String> modelList;
  final String selectedMachine;
  final String selectedModel;
  final DateTime? selectedMonth;

  MprAdcState({
    required this.machineList,
    required this.modelList,
    required this.selectedMachine,
    required this.selectedModel,
    this.selectedMonth,
  });

  MprAdcState copyWith({
    List<String>? machineList,
    List<String>? modelList,
    String? selectedMachine,
    String? selectedModel,
    DateTime? selectedMonth,
  }) {
    return MprAdcState(
      machineList: machineList ?? this.machineList,
      modelList: modelList ?? this.modelList,
      selectedMachine: selectedMachine ?? this.selectedMachine,
      selectedModel: selectedModel ?? this.selectedModel,
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }
}

class MprAdcStateNotifier extends StateNotifier<MprAdcState> {
  MprAdcStateNotifier()
      : super(MprAdcState(
    machineList: ['Machine 1', 'Machine 2', 'Machine 3', 'Machine 4'],
    modelList: ['Model A', 'Model B', 'Model C', 'Model D'],
    selectedMachine: 'Machine 1',
    selectedModel: 'Model A',
    selectedMonth: null,
  ));

  void setSelectedMachine(String value) {
    state = state.copyWith(selectedMachine: value);
  }

  void setSelectedModel(String value) {
    state = state.copyWith(selectedModel: value);
  }

  void setSelectedMonth(DateTime? value) {
    state = state.copyWith(selectedMonth: value);
  }
}

final mprAdcStateProvider = StateNotifierProvider<MprAdcStateNotifier, MprAdcState>(
      (ref) => MprAdcStateNotifier(),
);