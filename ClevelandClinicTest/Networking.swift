//
//  Networking.swift
//  ClevelandClinicTest
//
//  Created by Manish Reddy on 12/15/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    static let sharedInstance = Networking()
    let url = "https://test.appointmentpass.com/patients"
    //To test data comment above line and uncoment below line.
    //let url = "https://httpbin.org/post"
    
    //Completion Handlers
    typealias completionHandler = (_ success: Bool) -> Void

    //Post patientData function.
    func postPatientData(firstName: String, lastName: String, dateOfBirth: String, completionHandler: @escaping completionHandler ) {
        
        let dateIsoFormat = iso8601Format(date: dateOfBirth)
        
        //Converting Data to Json format.
        let parameters: Parameters = [
            "firstname": firstName,
            "lastname": lastName,
            "dateofbirth": dateIsoFormat as Any
        ]
        
        //Posting data using Alamofire
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.isSuccess {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
        }
    }
    
    //Convert a date to iso8601 format
    func iso8601Format(date: String) -> Date? {
        let dateString = "1991-03-11"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        let formatedDate = dateFormatter.date(from: dateString)
        return formatedDate
    }
    
}
