import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state/lives_state.dart';

/*
  Register the Providers here. 
  It may seem like this puts all the states globally, but essentially it is
  dependency injection. When needed, Riverpod allows us to inject the State 
  objects itself inside the Widget tree.
*/

final livesProvider = StateNotifierProvider((ref) => LivesState());
