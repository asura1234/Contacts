//
//  JsonParsingTest.swift
//  JsonParsingTest
//
//  Created by Yang Liu on 2/20/20.
//  Copyright © 2020 Yang Liu. All rights reserved.
//
@testable import Contacts
import XCTest

class JsonParsingTest: XCTestCase {

    func testJsonMapping() {
        if let data = "[{\"first_name\": \"Allan\",\"last_name\": \"Munger\",\"avatar_filename\":\"Allan Munger.png\",\"title\": \"Writer\",\"introduction\": \"Ut malesuada sollicitudin tincidunt. Maecenas volutpat suscipit efficitur. Curabitur ut tortor sit amet lacus pellentesque convallis in laoreet lectus. Curabitur lorem velit, bibendum et vulputate vulputate, commodo in tortor. Curabitur a dapibus mauris. Vestibulum hendrerit euismod felis at hendrerit. Pellentesque imperdiet volutpat molestie. Nam vehicula dui eu consequat finibus. Phasellus sed placerat lorem. Nulla pretium a magna sit amet iaculis. Aenean eget eleifend elit. Ut eleifend aliquet interdum. Cras pulvinar elit a dapibus iaculis. Nullam fermentum porttitor ultrices.\"}]".data(using: .utf8) {
            let decoder = JSONDecoder()
            if let profiles = try? decoder.decode([Profile].self, from: data) {
                XCTAssertEqual(profiles.count, 1)
                XCTAssertEqual(profiles[0].firstName, "Allan")
                XCTAssertEqual(profiles[0].lastName, "Munger")
                XCTAssertEqual(profiles[0].imageName, "Allan Munger.png")
                XCTAssertEqual(profiles[0].title, "Writer")
                XCTAssertEqual(profiles[0].information, "Ut malesuada sollicitudin tincidunt. Maecenas volutpat suscipit efficitur. Curabitur ut tortor sit amet lacus pellentesque convallis in laoreet lectus. Curabitur lorem velit, bibendum et vulputate vulputate, commodo in tortor. Curabitur a dapibus mauris. Vestibulum hendrerit euismod felis at hendrerit. Pellentesque imperdiet volutpat molestie. Nam vehicula dui eu consequat finibus. Phasellus sed placerat lorem. Nulla pretium a magna sit amet iaculis. Aenean eget eleifend elit. Ut eleifend aliquet interdum. Cras pulvinar elit a dapibus iaculis. Nullam fermentum porttitor ultrices.")
            } else {
                XCTFail("Not able to decode json. ")
            }
        } else {
            XCTFail("Not able to create data.")
        }
    }
    
    func testJsonFile() {
        if let path = Bundle.main.path(forResource: "contacts", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            let decoder = JSONDecoder()
            if let profiles = try? decoder.decode([Profile].self, from: data) {
                XCTAssertEqual(profiles.count, 28)
                XCTAssertEqual(profiles[5].firstName, "Cecil")
                XCTAssertEqual(profiles[5].lastName, "Folk")
                XCTAssertEqual(profiles[5].imageName, "Cecil Folk.png")
                XCTAssertEqual(profiles[5].title, "Territory Sales Manager")
                XCTAssertEqual(profiles[5].information, "Praesent pellentesque, sapien ut lobortis lacinia, erat magna venenatis turpis, eu maximus magna lectus a sapien. Aenean luctus tellus vel dui euismod bibendum. Aenean at elementum neque. Integer non aliquam risus. Ut porta, lectus et finibus sodales, mi nulla hendrerit dui, finibus consectetur arcu ligula ac velit. Suspendisse eu mollis diam. Vestibulum porta, elit a dignissim mollis, dolor risus sagittis sapien, quis tristique nunc massa interdum ligula. Duis a turpis nulla. Vivamus a consequat justo.")
            } else {
                XCTFail("Not able to decode contacts.json file. ")
            }
        } else {
            XCTFail("Not able to locate contacts.json file in the bundle.")
        }
    }
}
