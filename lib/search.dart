import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> dataStation = [
    "ประตูมาลัยแมน",
    "อาคารศูนย์มหาวิทยาลัย",
    "ศูนย์เรียนรวม 2-3 , โรงอาหารกลาง 1",
    "ศูนย์เรียนรวม 1 , คณะศึกษาศาสตร์และพัฒนศาสตร์ , คณะสิ่งแวดล้อม",
    "คณะวิทยาศาสตร์การกีฬา , ศูนย์เรียนรวม 4",
    "คณะสัตวแพทยศาสตร์",
    "คณะวิศวกรรมศาสตร์",
    "ภาควิชาเกษตรกลวิธาน",
    "เกษตรอภิรมย์",
    "หอสมุด",
    "สระพระพิรุณ , คณะศิลปศาสตร์และวิทยาศาสตร์",
    "ท่ารถนนทรี8",
    "หอพักหญิง(แอร์)",
    "หอพักชาย",
    "ร้าน7-11 สาขาหอพัก , ร้านสหกรณ์หอพัก , โรงส้ม",
    "หอพักหญิง",
    "คณะอุตสาหกรรมบริการ",
    "คณะเกษตร",
    "ตลาดนัด"
  ];
  List<String> dataStationLine1 = [
    "ประตูมาลัยแมน",
    "อาคารศูนย์มหาวิทยาลัย",
    "ศูนย์เรียนรวม 2-3 , โรงอาหารกลาง 1",
    "ศูนย์เรียนรวม 1 , คณะศึกษาศาสตร์และพัฒนศาสตร์ , คณะสิ่งแวดล้อม",
    "คณะวิทยาศาสตร์การกีฬา , ศูนย์เรียนรวม 4",
    "คณะสัตวแพทยศาสตร์",
    "คณะวิศวกรรมศาสตร์",
    "ภาควิชาเกษตรกลวิธาน",
    "เกษตรอภิรมย์",
    "หอสมุด",
    "สระพระพิรุณ , คณะศิลปศาสตร์และวิทยาศาสตร์",
    "ท่ารถนนทรี8",
  ];
  List<String> dataStationLine2 = [
    "หอพักหญิง(แอร์)",
    "หอพักชาย",
    "ร้าน7-11 สาขาหอพัก , ร้านสหกรณ์หอพัก , โรงส้ม",
    "หอพักหญิง",
    "คณะอุตสาหกรรมบริการ",
    "เกษตรอภิรมย์",
    "หอสมุด",
    "คณะเกษตร",
    "คณะวิทยาศาสตร์การกีฬา , ศูนย์เรียนรวม 4",
    "ศูนย์เรียนรวม 1 , คณะศึกษาศาสตร์และพัฒนศาสตร์ , คณะสิ่งแวดล้อม",
    "ศูนย์เรียนรวม 2-3 , โรงอาหารกลาง 1",
    "สระพระพิรุณ , คณะศิลปศาสตร์และวิทยาศาสตร์",
    "ท่ารถนนทรี8",
    "ตลาดนัด"
  ];
  String? selectedStart;
  String? selectedEnd;
  String? resultSelect;

  String calculateStation() {
    if (selectedStart != null && selectedEnd != null) {
      if (dataStationLine1.contains(selectedStart) &&
          dataStationLine1.contains(selectedEnd) &&
          dataStationLine2.contains(selectedStart) &&
          dataStationLine2.contains(selectedEnd)) {
        return "สามารถเลือกใช้รถได้ทั้งสองสาย จนถึงสถานที่ที่ต้องการ";
      } else if (dataStationLine1.contains(selectedStart) &&
          dataStationLine1.contains(selectedEnd)) {
        return "ขึ้นรถสาย 1 จนถึงสถานที่ที่ต้องการ";
      } else if (dataStationLine2.contains(selectedStart) &&
          dataStationLine2.contains(selectedEnd)) {
        return "ขึ้นรถสาย 2 จนถึงสถานที่ที่ต้องการ";
      } else if (dataStationLine1.contains(selectedStart) &&
          dataStationLine2.contains(selectedEnd)) {
        List<String> Line1OutLine = dataStationLine1.sublist(5, 7);
        if (Line1OutLine.contains(selectedStart)) {
          return "ขึ้นรถสาย 1 จากนั้นเปลี่ยนรถเป็น สาย 2\n\nกรณี1 เปลี่ยนสายที่ท่ารถนนทรี8\n\nกรณี2 สามารถเปลี่ยนสายหอสมุดติดถนนติดกับเกษตรอภิรมย์";
        } else {
          return "ขึ้นรถสาย 1 จากนั้นเปลี่ยนรถเป็น สาย 2\n\nกรณี1 เปลี่ยนสายที่ท่ารถนนทรี8\n\nกรณี2 สามารถลงรถสาย1 ที่ศูนย์มหาวิทยาลัย เดินข้ามถนนอีกฝั่งเพื่อรอสาย 2 ได้\n\nกรณี3 สามารถเปลี่ยนสายที่โซนโรงอาหารกลาง 1 ได้";
        }
      } else if (dataStationLine2.contains(selectedStart) &&
          dataStationLine1.contains(selectedEnd)) {
        List<String> Line1OutLine = dataStationLine1.sublist(5, 7);
        if (Line1OutLine.contains(selectedEnd)) {
          return "ขึ้นรถสาย 2 จากนั้นเปลี่ยนรถเป็น สาย 1\n\nกรณี1 เปลี่ยนสายที่ศูนย์เรียนรวม 4\n\nกรณี2 โซนโรงอาหารกลาง 1";
        } else {
          return "ขึ้นรถสาย 2 จากนั้นเปลี่ยนรถเป็น สาย 1\n\nกรณี1 เปลี่ยนสายที่ท่ารถนนทรี8\n\nกรณี2 สามารถลงที่คณะศวท.เดินข้ามถนนไปรอรถสาย 1 ที่ศูนย์มหาวิทยาลัยได้ ";
        }
      } else {
        return "รอการอัปเดตข้อมูลเพิ่มเติม";
      }
    } else {
      return "กรุณาเลือกสถานที่เริ่มต้นและสถานที่ปลายทาง";
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ค้นหาเส้นทางสายตะลัย",style: TextStyle(fontSize: 24, color: const Color(0xFFEE008E), fontWeight: FontWeight.bold,),),
      ),
      body: SizedBox(
        height: deviceHeight,
        width: deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.05),
              child: CustomSingleSelectField<String>(
                items: dataStation,
                title: "สถานที่เริ่มต้น",
                onSelectionDone: (value) {
                  setState(() {
                    selectedStart = value;
                  });
                },
                itemAsString: (item) => item,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(deviceWidth * 0.05),
              child: CustomSingleSelectField<String>(
                items: dataStation,
                title: "สถานที่ปลายทาง",
                onSelectionDone: (value) {
                  setState(() {
                    selectedEnd = value;
                  });
                },
                itemAsString: (item) => item,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedStart != null && selectedEnd != null) {
                  // สร้างข้อความผลลัพธ์
                  setState(() {
                    resultSelect = calculateStation();
                  });
                } else {
                  // กรณีที่ผู้ใช้ยังไม่ได้เลือกทั้งสถานที่เริ่มต้นและสถานที่ปลายทาง
                  setState(() {
                    resultSelect = "กรุณาเลือกสถานที่เริ่มต้นและสถานที่ปลายทาง";
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFEE008E),
              ),
              child: Text(
                "ค้นหาเส้นทาง",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            if (resultSelect != null)
              Padding(
                padding: EdgeInsets.all(deviceWidth * 0.05),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF3EA97B),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    resultSelect ?? "",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
