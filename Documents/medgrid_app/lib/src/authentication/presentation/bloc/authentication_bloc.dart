// import 'package:equatable/equatable.dart';
// import 'package:bloc/bloc.dart';
// import 'package:medgrid_app/src/authentication/domain/entities/user.dart';
// import 'package:medgrid_app/src/authentication/domain/usecases/create_user.dart';
// import 'package:medgrid_app/src/authentication/domain/usecases/get_users.dart';

// part 'authentiication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   AuthenticationBloc({
//     required GetDrugDetail getDrugDetail,
//     required GetUsers getUsers,
//   })  : _getDrugDetail = getDrugDetail,
//         _getUsers = getUsers,
//         super(const AuthenticationInitial()) {
//     on<GetDrugDetailEvent>(_getDrugDetailHandler);
//     on<GetUserEvent>(_getUserHandler);
//   }

//   final GetDrugDetail _getDrugDetail;
//   final GetUsers _getUsers;

//   Future<void> _getDrugDetailHandler(
//     GetDrugDetailEvent event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(const CreatingUser());

//     final result = await _getDrugDetail(DrugDetailParams(txharsh: event.txharsh));

//     result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
//         (_) => emit(const UserCreated()));
//   }

//   Future<void> _getUserHandler(
//     GetUserEvent event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     emit(const GettingUsers());

//     final result = await _getUsers();

//     result.fold((failure) => emit(AuthenticationError(failure.errorMessage)),
//         (users) => emit(UsersLoaded(users)));
//   }
// }
