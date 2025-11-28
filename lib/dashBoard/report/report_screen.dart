import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🟣 Circle Avatar with Report Logo
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(4, 6),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-4, -4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.grey,
                    size: 64,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Reports & Analytics",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                "Generate comprehensive reports\n   and gain valuable insights",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 60),

              // 📄 Generate Report Button
              OutlinedButton.icon(onPressed: (){},
                icon: Icon(Icons.report,size: 18,),
                label: Text("Generate Reports",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
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
    );
  }
}
