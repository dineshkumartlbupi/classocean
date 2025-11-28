import 'package:flutter/material.dart';

class SetScreen extends StatelessWidget {
  const SetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_accessibility_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 32),
                Text(
                  "Setting & Preferences",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Customize your classOcean experience and preference",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
                SizedBox(height: 40),
                OutlinedButton.icon(onPressed: (){},
                    icon: Icon(Icons.settings_outlined,size: 18,),
                    label: Text("Open setting",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24,vertical: 14),
                  side: BorderSide(
                    color: Colors.blue
                  ),
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
