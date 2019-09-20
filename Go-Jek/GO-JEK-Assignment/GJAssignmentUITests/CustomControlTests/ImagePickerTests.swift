//
//  ImagePickerTests.swift
//  GJAssignmentUITests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest

class ImagePickerTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImagePickerActionSheet() {
        openImagePicker()
        
        let chooseImageSheet = app.sheets["Choose Image"]
        XCTAssertTrue(chooseImageSheet.exists, "Action sheet not presented.")
        
        //Camera button will not be available in Simulator
        if !isSimulartor() {
            let cameraButton = chooseImageSheet.buttons["Camera"]
            XCTAssertTrue(cameraButton.exists, "Camera button not available")
        }
        
        let galleryButton = chooseImageSheet.buttons["Gallery"]
        XCTAssertTrue(galleryButton.exists, "Gallery button not available")
        
        let cancelButton = chooseImageSheet.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists, "Cancel button not available")
    }
    
    func testCameraImage() {
        openImagePicker()
        
        let chooseImageSheet = app.sheets["Choose Image"]
        XCTAssertTrue(chooseImageSheet.exists, "Action sheet not presented.")
        
        if isSimulartor() {
            return
        }
        
        let cameraButton = chooseImageSheet.buttons["Camera"]
        cameraButton.tap()
        
        let permissionAlert = app.alerts["“GJAssignment” Would Like to Access the Camera"]
        if permissionAlert.exists {
            let allowPermissionButton = permissionAlert.buttons["OK"]
            allowPermissionButton.tap()
        }
        
        let photoCaptureButton = app.buttons["PhotoCapture"]
        XCTAssertTrue(photoCaptureButton.exists, "Photo capture button not exist.")
        photoCaptureButton.tap()
    }

    private func openImagePicker() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let selectimagebuttonButton = tablesQuery.buttons["selectImageButton"]
        selectimagebuttonButton.tap()
    }
    
    private func isSimulartor() -> Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}
