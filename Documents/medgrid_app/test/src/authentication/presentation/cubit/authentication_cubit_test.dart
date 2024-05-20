import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medgrid_app/core/errors/failure.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drug.dart';
import 'package:medgrid_app/src/authentication/domain/entities/drugDetail.dart';
import 'package:medgrid_app/src/authentication/domain/entities/manufacturer.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/drug_info.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/get_drug_detail.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/manufacturer_usecase.dart';
import 'package:medgrid_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockGetManufacturerDetail extends Mock implements GetManufacturerDetail {}
class MockGetDrugDetailInfo extends Mock implements GetDrugDetailInfo {}
class MockGetDrugDetail extends Mock implements GetDrugDetail {}

void main() {
  late GetManufacturerDetail getManufacturerDetail;
  late GetDrugDetailInfo getDrugDetailInfo;
  late GetDrugDetail getDrugDetail;
  late AuthenticaationCubit cubit;

  const tManufacturerDetailParams = ManufacturerDetailParams.empty();
  const tDrugDetailParams = DrugDetailParams.empty();
  const tDrugInfoDetailParams = DrugInfoDetailParams.empty();
  const tAPIFailure = APIFailure(message: '400 Error: message', statusCode: 400);

  setUp(() {
    getManufacturerDetail = MockGetManufacturerDetail();
    getDrugDetailInfo = MockGetDrugDetailInfo();
    getDrugDetail = MockGetDrugDetail();
    cubit = AuthenticaationCubit(
      getDrugDetail: getDrugDetail,
      getDrugDetailInfo: getDrugDetailInfo,
      getManufacturerDetail: getManufacturerDetail,
    );

    registerFallbackValue(tManufacturerDetailParams);
    registerFallbackValue(tDrugDetailParams);
    registerFallbackValue(tDrugInfoDetailParams);
  });

  tearDown(() => cubit.close());

  const drug = [Drug.empty()];
  const drugDetailInfo = DrugDetail.empty();
  const drugManufacturerDetail = Manufacturer.empty();

  test('initial state should be [AuthenticationInitial]', () {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('getDrugDetail', () {
    blocTest<AuthenticaationCubit, AuthenticationState>(
      'should emit [CreatingUser, GettingDrug, LoadedDrugDetail, LoadedManufacturer, GetDrug] when successful',
      build: () {
        when(() => getDrugDetail(any())).thenAnswer((_) async => const Right(drug));
        when(() => getDrugDetailInfo(any())).thenAnswer((_) async => const Right(drugDetailInfo));
        when(() => getManufacturerDetail(any())).thenAnswer((_) async => const Right(drugManufacturerDetail));

        return cubit;
      },
      act: (cubit) => cubit.getDrugDetailFromDB(txharsh: 'some_txharsh'),
      expect: () => [
        const GettingDrug(),
        const GettingDrugInfo(),
        const LoadedDrugDetail(drugDetailInfo),
        const GettingManufacturer(),
        const LoadedManufacturer(drugManufacturerDetail),
        const GetDrug(drug, drugDetailInfo, drugManufacturerDetail),
      ],
      verify: (_) {
        verify(() => getDrugDetail(any())).called(1);
        verify(() => getDrugDetailInfo(any())).called(1);
        verify(() => getManufacturerDetail(any())).called(1);
      },
    );

    blocTest<AuthenticaationCubit, AuthenticationState>(
      'should emit [GettingDrug, AuthenticationError] when failure',
      build: () {
        when(() => getDrugDetail(any())).thenAnswer((_) async => const Left(tAPIFailure));

        return cubit;
      },
      act: (cubit) => cubit.getDrugDetailFromDB(txharsh: 'some_txharsh'),
      expect: () => [
        const GettingDrug(),
        AuthenticationError(tAPIFailure.message),
      ],
      verify: (_) {
        verify(() => getDrugDetail(any())).called(1);
      },
    );
  });

  group('getDrugDetailInfo', () {
      blocTest<AuthenticaationCubit, AuthenticationState>(
        'should emit [GettingDrugInfo, LoadedDrugDetail] when successful',
        build: () {
          when(() => getDrugDetailInfo(any())).thenAnswer((_) async => const Right(drugDetailInfo));

          return cubit;
        },
        act: (cubit) => cubit.getDrugDetailInfo(txharsh: 'some_txharsh'),
        expect: () => [
          const GettingDrugInfo(),
          const LoadedDrugDetail(drugDetailInfo),
        ],
        verify: (_) {
          verify(() => getDrugDetailInfo(any())).called(1);
        },
      );

      // blocTest<AuthenticaationCubit, AuthenticationState>(
      //   'should emit [GettingDrugInfo, AuthenticationError] when failure',
      //   build: () {
      //     when(() => getDrugDetailInfo(any())).thenAnswer((_) async => const Left(tAPIFailure));

      //     return cubit;
      //   },
      //   act: (cubit) => cubit.getDrugDetailInfo(txharsh: 'some_txharsh'),
      //   expect: () => [
      //     const GettingDrugInfo(),
      //     AuthenticationError(tAPIFailure.message),
      //   ],
      //   verify: (_) {
      //     verify(() => getDrugDetailInfo(any())).called(1);
      //   },
      // );

      test('should throw Exception with correct message when failure', () async {
        when(() => getDrugDetailInfo(any())).thenAnswer((_) async => const Left(tAPIFailure));

        expect(
          () async => await cubit.getDrugDetailInfo(txharsh: 'some_txharsh'),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('400 Error: message'))),
        );
      });
    });

    group('getManufacturerDetail', () {
      blocTest<AuthenticaationCubit, AuthenticationState>(
        'should emit [GettingManufacturer, LoadedManufacturer] when successful',
        build: () {
          when(() => getManufacturerDetail(any())).thenAnswer((_) async => const Right(drugManufacturerDetail));

          return cubit;
        },
        act: (cubit) => cubit.getManufacturerDetail(txharsh: 'some_txharsh'),
        expect: () => [
          const GettingManufacturer(),
          const LoadedManufacturer(drugManufacturerDetail),
        ],
        verify: (_) {
          verify(() => getManufacturerDetail(any())).called(1);
        },
      );

      // blocTest<AuthenticaationCubit, AuthenticationState>(
      //   'should emit [GettingManufacturer, AuthenticationError] when failure',
      //   build: () {
      //     when(() => getManufacturerDetail(any())).thenAnswer((_) async => const Left(tAPIFailure));

      //     return cubit;
      //   },
      //   act: (cubit) => cubit.getManufacturerDetail(txharsh: 'some_txharsh'),
      //   expect: () => [
      //     const GettingManufacturer(),
      //     AuthenticationError(tAPIFailure.message),
      //   ],
      //   verify: (_) {
      //     verify(() => getManufacturerDetail(any())).called(2);
      //   },
      // );

      test('should throw Exception with correct message when failure', () async {
        when(() => getManufacturerDetail(any())).thenAnswer((_) async => const Left(tAPIFailure));

        expect(
          () async => await cubit.getManufacturerDetail(txharsh: 'some_txharsh'),
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('400 Error: message'))),
        );
      });
    });

}