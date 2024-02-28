import 'dart:convert';


List<Staffmodel> staffmodelFromJson(String str) => List<Staffmodel>.from(json.decode(str).map((x) => Staffmodel.fromJson(x)));

String staffmodelToJson(List<Staffmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Staffmodel {
    final int id;
    final String staffName;

    Staffmodel({
        required this.id,
        required this.staffName,
    });

    factory Staffmodel.fromJson(Map<String, dynamic> json) => Staffmodel(
        id: json["id"],
        staffName: json["staff_Name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "staff_Name": staffName,
    };
}


List<Goruppartmodel> grouppartmodelFromJson(String str) => List<Goruppartmodel>.from(json.decode(str).map((x) => Goruppartmodel.fromJson(x)));

String grouppartmodelToJson(List<Goruppartmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Goruppartmodel {
    final int id;
    final String name;
    final int locationId;
    final int miscMasterId;

    Goruppartmodel({
        required this.id,
        required this.name,
        required this.locationId,
        required this.miscMasterId,
    });

    factory Goruppartmodel.fromJson(Map<String, dynamic> json) => Goruppartmodel(
        id: json["id"],
        name: json["name"],
        locationId: json["locationId"],
        miscMasterId: json["miscMasterId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "locationId": locationId,
        "miscMasterId": miscMasterId,
    };
}


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    int? id;
    int? locationId;
    String? prefixName;
    int? refNo;
    String? refDate;
    String? refTime;
    int? titleId;
    String? genderName;
    String? customerName;
    String? contactName;
    String? sanOffName;
    String? addressDetails;
    dynamic address2;
    String? cityId;
    String? city;
    String? pinCode;
    String? mobNo;
    String? phonNo;
    String? stdCode;
    String? faxNo;
    String? emailId;
    String? birthdayDate;
    String? anniversaryDate;
    int? enqType;
    String? modeType;
    int? occupation;
    String? income;
    int? enqGenById;
    int? salesExId;
    int? sourceId;
    String? noOfVisitor;
    String? scheme;
    int? priority;
    String? interestIn;
    int? modelId;
    int? colourId;
    String? remarkInterest;
    int? modelTestId;
    String? modelTestDate;
    String? remarkModelTest;
    String? appointmentDate;
    String? appointmentTime;
    String? remarkAppointment;
    String? remarkSpecial;
    String? lastContactDate;
    String? lastRemark;
    dynamic lastActionTaken;
    String? currentAppointmentDate;
    int? enquiryStatus;
    dynamic reason;
    dynamic vehiclePurchase;
    dynamic booking;
    dynamic a;
    dynamic b;
    dynamic c;
    dynamic d;
    dynamic e;
    dynamic f;
    dynamic g;

    Welcome({
        this.id,
        this.locationId,
        this.prefixName,
        this.refNo,
        this.refDate,
        this.refTime,
        this.titleId,
        this.genderName,
        this.customerName,
        this.contactName,
        this.sanOffName,
        this.addressDetails,
        this.address2,
        this.cityId,
        this.city,
        this.pinCode,
        this.mobNo,
        this.phonNo,
        this.stdCode,
        this.faxNo,
        this.emailId,
        this.birthdayDate,
        this.anniversaryDate,
        this.enqType,
        this.modeType,
        this.occupation,
        this.income,
        this.enqGenById,
        this.salesExId,
        this.sourceId,
        this.noOfVisitor,
        this.scheme,
        this.priority,
        this.interestIn,
        this.modelId,
        this.colourId,
        this.remarkInterest,
        this.modelTestId,
        this.modelTestDate,
        this.remarkModelTest,
        this.appointmentDate,
        this.appointmentTime,
        this.remarkAppointment,
        this.remarkSpecial,
        this.lastContactDate,
        this.lastRemark,
        this.lastActionTaken,
        this.currentAppointmentDate,
        this.enquiryStatus,
        this.reason,
        this.vehiclePurchase,
        this.booking,
        this.a,
        this.b,
        this.c,
        this.d,
        this.e,
        this.f,
        this.g,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        locationId: json["location_Id"],
        prefixName: json["prefix_Name"],
        refNo: json["ref_No"],
        refDate: json["ref_Date"],
        refTime: json["ref_Time"],
        titleId: json["title_Id"],
        genderName: json["gender_Name"],
        customerName: json["customer_Name"],
        contactName: json["contact_Name"],
        sanOffName: json["sanOff_Name"],
        addressDetails: json["address_Details"],
        address2: json["address2"],
        cityId: json["city_Id"],
        city: json["city"],
        pinCode: json["pin_Code"],
        mobNo: json["mob_No"],
        phonNo: json["phon_No"],
        stdCode: json["std_Code"],
        faxNo: json["fax_No"],
        emailId: json["email_Id"],
        birthdayDate: json["birthday_Date"],
        anniversaryDate: json["anniversary_Date"],
        enqType: json["enq_Type"],
        modeType: json["mode_Type"],
        occupation: json["occupation"],
        income: json["income"],
        enqGenById: json["enqGenBy_Id"],
        salesExId: json["salesEx_id"],
        sourceId: json["source_Id"],
        noOfVisitor: json["noOfVisitor"],
        scheme: json["scheme"],
        priority: json["priority"],
        interestIn: json["interestIn"],
        modelId: json["model_Id"],
        colourId: json["colour_Id"],
        remarkInterest: json["remark_interest"],
        modelTestId: json["modelTest_Id"],
        modelTestDate: json["modelTest_Date"],
        remarkModelTest: json["remark_ModelTest"],
        appointmentDate: json["appointment_Date"],
        appointmentTime: json["appointment_Time"],
        remarkAppointment: json["remark_Appointment"],
        remarkSpecial: json["remark_Special"],
        lastContactDate: json["lastContact_Date"],
        lastRemark: json["last_Remark"],
        lastActionTaken: json["last_ActionTaken"],
        currentAppointmentDate: json["currentAppointmentDate"],
        enquiryStatus: json["enquiryStatus"],
        reason: json["reason"],
        vehiclePurchase: json["vehiclePurchase"],
        booking: json["booking"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        e: json["e"],
        f: json["f"],
        g: json["g"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "location_Id": locationId,
        "prefix_Name": prefixName,
        "ref_No": refNo,
        "ref_Date": refDate,
        "ref_Time": refTime,
        "title_Id": titleId,
        "gender_Name": genderName,
        "customer_Name": customerName,
        "contact_Name": contactName,
        "sanOff_Name": sanOffName,
        "address_Details": addressDetails,
        "address2": address2,
        "city_Id": cityId,
        "city": city,
        "pin_Code": pinCode,
        "mob_No": mobNo,
        "phon_No": phonNo,
        "std_Code": stdCode,
        "fax_No": faxNo,
        "email_Id": emailId,
        "birthday_Date": birthdayDate,
        "anniversary_Date": anniversaryDate,
        "enq_Type": enqType,
        "mode_Type": modeType,
        "occupation": occupation,
        "income": income,
        "enqGenBy_Id": enqGenById,
        "salesEx_id": salesExId,
        "source_Id": sourceId,
        "noOfVisitor": noOfVisitor,
        "scheme": scheme,
        "priority": priority,
        "interestIn": interestIn,
        "model_Id": modelId,
        "colour_Id": colourId,
        "remark_interest": remarkInterest,
        "modelTest_Id": modelTestId,
        "modelTest_Date": modelTestDate,
        "remark_ModelTest": remarkModelTest,
        "appointment_Date": appointmentDate,
        "appointment_Time": appointmentTime,
        "remark_Appointment": remarkAppointment,
        "remark_Special": remarkSpecial,
        "lastContact_Date": lastContactDate,
        "last_Remark": lastRemark,
        "last_ActionTaken": lastActionTaken,
        "currentAppointmentDate": currentAppointmentDate,
        "enquiryStatus": enquiryStatus,
        "reason": reason,
        "vehiclePurchase": vehiclePurchase,
        "booking": booking,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "e": e,
        "f": f,
        "g": g,
    };
}
