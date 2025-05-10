import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/app_colors.dart';
import 'package:graduation_project/features/auth/presentation/manager/auth_view_model.dart';
import 'package:graduation_project/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    var local =AppLocalizations.of(context);
    var size= MediaQuery.of(context).size;
    return Consumer2<AuthViewModel,LanguageProvider>(
      builder: (context, authVM, langProvider ,child) =>
          Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.gray,
              iconTheme: IconThemeData(color:AppColors.white ),
              title: Row(
                children: [
                  Spacer(),
                  Text(local!.profile,style: TextStyle(color: AppColors.white),),
                  Spacer(),
                  TextButton(
                      onPressed: () {

                      },
                      child: Text('save',style: TextStyle(color: AppColors.white),)
                  ),
                ],
              ),
              centerTitle: true,

            ),
            backgroundColor: AppColors.gray,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(local.name,style: TextStyle(color: AppColors.white,fontSize: 13),),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightGray
                    ),
                    child: TextFormField(
                      controller: authVM.usernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintStyle:  TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(local.email,style: TextStyle(color: AppColors.white,fontSize: 13),),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightGray
                    ),
                    child: TextFormField(
                      controller: authVM.emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.lightGray),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintStyle:  TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(local.language,style: TextStyle(color: AppColors.white,fontSize: 13),),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightGray,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: langProvider.lang,
                        dropdownColor: Colors.grey[850],
                        style: const TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.white,
                        alignment: AlignmentDirectional.centerEnd, // يخلي السهم في اليمين
                        items: langProvider.languages.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Align(
                              alignment: Alignment.centerLeft, // يخلي النص في الشمال
                              child: Text(
                                entry.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            langProvider.setLanguage(value);
                          }
                        },
                      ),
                    ),
                  )



                ],
              ),
            ),
          )
      ,
    );
  }
}
