import 'dart:convert';

class APIRequestBuilder {
   Map<String, dynamic> RequestJSON(
    String SPName,
    String IID,
    String Text1,
    String Text2,
    String Text3,
    String Text4,
    String Text5,
    String Text6,
    String Text7,
    String Text8,
    String Text9,
    String Text10,
    String Text11,
    String Text12,
    String Text13,
    String Text14,
    String Text15,
  ) {
    return {
       "HasReturnData": "T",
    "Parameters": [
      {
            "Para_Data": IID,
            "Para_Direction": "Input",
            "Para_Lenth": 1,
            "Para_Name": "@Iid",
            "Para_Type": "int"
        },
        {
            "Para_Data": Text1, //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text1",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text2,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text2",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text3,
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text3",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text4, //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text4",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text5,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text5",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text6,
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text6",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text7, //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text7",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text8,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text8",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text9,
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text9",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text10, //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text10",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text11,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text11",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text12,
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text12",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text13, //DD69FDE3-3B6E-4897-8231-61B40EFEA73C , DeviceInfo.getUniqueId()
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text13",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text14,
            "Para_Direction": "Input",
            "Para_Lenth": 100,
            "Para_Name": "@Text14",
            "Para_Type": "varchar"
        },
        {
            "Para_Data": Text15,
            "Para_Direction": "Input",
            "Para_Lenth": 5000,
            "Para_Name": "@Text15",
            "Para_Type": "varchar"
        }
      ],
      "SpName": SPName,
    "con": 1
    };
    }
    }