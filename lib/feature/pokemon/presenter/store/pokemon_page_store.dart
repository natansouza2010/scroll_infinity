// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:scrollinfinity/feature/pokemon/domain/usecase/get_all_pokemons.dart';
import 'package:scrollinfinity/feature/pokemon/presenter/state/pokemon_state.dart';
import 'package:async/async.dart';
part 'pokemon_page_store.g.dart';

class PokemonPageStore = _PokemonPageStore with _$PokemonPageStore;

abstract class _PokemonPageStore with Store {
  final GetAllPokemonsContract getAllPokemonsContract;
   CancelableOperation? cancellableOperation;


  _PokemonPageStore({
    required this.getAllPokemonsContract,
  }) {
    reaction(pokemonState, )
  }

  @observable
  PokemonState pokemonState = InitialPokemonState();



   Future stateReaction(
      CancelableOperation cancellableOperation) async {
    await cancellableOperation.cancel();
    cancellableOperation =
        CancelableOperation<PokemonState>.fromFuture(makeSearch(text));
    if (text.isEmpty) {
      setState(StartState());
      return;
    }

    setState(LoadingState());

    setState(await cancellableOperation.valueOrCancellation(LoadingState()));
  }

   Future<PokemonState> findAllPokemons() async {
    var result = getAllPokemonsContract;
    return result.fold((l) => ErrorPokemonState(error: l), (r) => SucessPokemonState(pokemons: r));
  }


  @action
  Future<void> setPokemonState(PokemonState newState) async =>
      pokemonState = newState;
  
}
