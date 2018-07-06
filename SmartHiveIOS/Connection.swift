//
//  Connection.swift
//  SmartHiveIOS
//
//  Created by Sergei Ziuzev on 23/01/2018.
//  Copyright © 2018 Sergei Ziuzev. All rights reserved.
//

import Foundation

struct Connection {

    public func getData(_ connectionString: String) -> Data? {
        var xml: Data?
        guard let url = URL(string: connectionString) else { return xml }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if data != nil {
//                print(data)
                xml = data
            }
            if let err = error {
                print(err)
            }
            }.resume()
        return xml
    }
}

