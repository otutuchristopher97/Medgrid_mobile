import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medgrid_app/core/components/custom_elevated_button.dart';
import 'package:medgrid_app/core/components/texts/custom_text.dart';
import 'package:medgrid_app/core/routing/routes.dart';
import 'package:medgrid_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:medgrid_app/src/authentication/presentation/widget/add_user_dialog.dart';
import 'package:medgrid_app/src/authentication/presentation/widget/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.data});

  final String data;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getDrugs() {
    context.read<AuthenticaationCubit>().getDrugDetailFromDB(txharsh: widget.data);
  }

  @override
  void initState() {
    super.initState();
    getDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticaationCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } 
      // else if (state is UserCreated) {
      //   getUsers();
      // }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const CustomText(text: "Drug Detail", size: 20, weight: FontWeight.w600,),
        ),
        body: state is GettingDrug
            ? const LoadingColumn(
                message: 'Fetching Drug',
              )
            : state is GettingDrug
                ? const LoadingColumn(message: 'Creating User')
                : state is GetDrug
                    ? 
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset('assets/images/drug.png', height: 200,),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Company Name : ", size: 15, weight: FontWeight.w500,), 
                                    CustomText(text: state.manufacturer.name, size: 15,)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Email: ", size: 15, weight: FontWeight.w500,), 
                                    CustomText(text: state.manufacturer.email, size: 15, overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Company Address : ", size: 15, weight: FontWeight.w500,), 
                                    CustomText(text: state.manufacturer.address, size: 15,)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Package Number : ", size: 15, weight: FontWeight.w500,), 
                                    CustomText(text: state.drugDetail.packageNumber, size: 15,)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Expiration Data: ", size: 15, weight: FontWeight.w500,), 
                                    CustomText(text: state.drugDetail.expiration, size: 15)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "TrrxHarsh: ", size: 15, weight: FontWeight.w500,), 
                                    SizedBox(width: 40,),
                                    Expanded(child: Text(state.drugs[0].trxHash, style: TextStyle(overflow: TextOverflow.ellipsis),))
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(text: "Organization Cid: ", size: 15, weight: FontWeight.w500,), 
                                    SizedBox(width: 40,),
                                    Expanded(child: Text(state.drugs[0].orgCid, style: TextStyle(overflow: TextOverflow.ellipsis),))
                                  ],
                                ),
                                SizedBox(height: 20,),
                              ],
                              
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomElevatedButton(
                              height: 50,
                              label: 'View Contract',
                              onPressed: (){
                                context.push(RouteConstants.webViewScreen);
                              },
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    )
                    // Center(
                    //     child: ListView.builder(
                    //         itemCount: state.drugs.length,
                    //         itemBuilder: (context, index) {
                    //           final drug = state.drugs[index];
                    //           return ListTile(
                    //             // leading: Image.network(drug.cid),
                    //             title: Text(drug.trxHash),
                    //             subtitle: Text(drug.cid),
                    //           );
                    //         }),
                    //   )
                    : const SizedBox.shrink(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     await showDialog(
        //         context: context,
        //         builder: (context) => AddUserDialog(
        //               nameController: nameController,
        //             ));
        //   },
        //   child: const Icon(Icons.add),
        // ),
      );
    });
  }
}
