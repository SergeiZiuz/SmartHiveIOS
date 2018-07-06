//
//  XMLParse.swift
//  SmartHiveIOS
//
//  Created by Sergei Ziuzev on 7/4/18.
//  Copyright © 2018 Sergei Ziuzev. All rights reserved.
//

import UIKit

class XMLParse: NSObject, XMLParserDelegate {

    private var roomsWGOC = [Room]()
    private var roomsKHBP = [Room]()
    private var currentElement: String?
    private var currentTitle: String?
    private var currentTitleEn: String?
    private var currentLocation: String?
    
    public func getRooms(_ office: String) -> [Room]? {
        getXML()
        
        if office == "wgoc" {
            return roomsWGOC
        }
        if office == "khbp" {
            return roomsKHBP
        }
        return nil
    }
    
    private func getXML() {
//        let connection = Connection()
//        guard let data = connection.getData("https://mtcscheduleboard.azurewebsites.net/rooms.xml") else { return }
        guard let url = URL(string: "https://mtcscheduleboard.azurewebsites.net/rooms.xml") else { return }
        
//        let xml = XMLParser(data: data)
        guard let xml = XMLParser(contentsOf: url) else { return }
        xml.delegate = self
        xml.parse()
    }
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if data.count != 0 {
            switch currentElement {
            case "Title": currentTitle = data
            case "Title_En": currentTitleEn = data
            case "ServiceBusTopic": currentLocation = data
            default:
                break
            }
        }
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Room" {
            var room = Room()
            room.title = currentTitle
            room.titleEn = currentTitleEn
            room.location = currentLocation
            switch currentLocation {
            case "wgoc":
                roomsWGOC.append(room)
            default:
                roomsKHBP.append(room)
            }
        }
    }
}
