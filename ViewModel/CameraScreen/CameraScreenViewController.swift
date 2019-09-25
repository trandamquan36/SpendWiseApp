//
//  CameraScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit
import AVFoundation

class CameraScreenViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    var captureDevice:AVCaptureDevice!

    @IBAction private func doneBarButton(_ sender: UIBarButtonItem) {
        if TempData.comeFromLoginScreen == true {
            performSegue(withIdentifier: "CameraScreen_LoginScreen", sender: self)
            TempData.comeFromLoginScreen = false
        }
        
        if TempData.comeFromSignupScreen == true {
            TempData.facialRecognitionAdded = true
            TempData.comeFromSignupScreen = false
            performSegue(withIdentifier: "CameraScreen_Signup3", sender: self)
          
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
    }
    

    // ---------------------------------------------------
    // Normal functions
    private func prepareCamera(){
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInWideAngleCamera],mediaType: AVMediaType.video, position: .back).devices
        
        captureDevice = availableDevices.first
        
        beginSession()
        
    }
    
    private func beginSession() {
        let captureDevice = AVCaptureDevice.default(for: .video)
//        let captureDeviceInput = AVCaptureDeviceInput(device: captureDevice)
        do {
            guard let captureDevice = captureDevice else { return }
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        
        captureSession.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)] as [String : Any]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if captureSession.canAddOutput(dataOutput){
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "camera")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        <#code#>
//    }
    
}
