//
//  CameraScreenViewController.swift
//  SpendWiseApp
//
//  Created by Quan Tran on 15/9/19.
//  Copyright © 2019 Quan Tran. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

class CameraScreenViewController: UIViewController {
   
    let alert = Alert()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    private var photoOutput = AVCapturePhotoOutput()
    
    private var inputDevice:AVCaptureDeviceInput?
    private var flashMode: AVCaptureDevice.FlashMode = .off
    private var usingFrontCamera:Bool = false
    private var usingFlash:Bool = false
    private var takePhoto:Bool = false
    private var faceDetected:Bool = false
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var rotateButton: UIButton!
    @IBOutlet private weak var captureButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var flashButton: UIButton!
    @IBOutlet private weak var cameraPreview: UIView!
    
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        if TempData.comeFromLoginScreen == true {
            performSegue(withIdentifier: "CameraScreen_LoginScreen", sender: self)
            TempData.comeFromLoginScreen = false
        }
        
        if TempData.comeFromSignupScreen == true {
            TempData.comeFromSignupScreen = false
            performSegue(withIdentifier: "CameraScreen_Signup3", sender: self)
        }
    }
    
    
    @IBAction private func rotateAction(_ sender: Any) {
        self.usingFrontCamera = !self.usingFrontCamera
        self.prepareCamera()
    }
    
    @IBAction private func captureAction(_ sender: Any) {
        capture()
    }
    
    
    @IBAction private func flashAction(_ sender: Any) {
        self.usingFlash = !self.usingFlash
        
        if self.usingFlash == true {
            flashMode = .on
            flashButton.setTitleColor(Colors.getColor(redColor: 255.0, greenColor: 221.0, blueColor: 119.0, alpha: 100.0), for: .normal)
        } else {
            flashMode = .off
            flashButton.setTitleColor(Colors.getColor(redColor: 255.0, greenColor: 255.0, blueColor: 255.0, alpha: 100.0), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            alert.showNoCameraAvailableAlert(on: self)
        }
        
        checkCameraStatus()
        if TempData.comeFromLoginScreen {
            flashButton.isEnabled = false
            captureButton.isEnabled = false
            // a timer for every 1 sec, take a photo to recognize
        } else if TempData.comeFromSignupScreen {
            flashButton.isEnabled = true
            captureButton.isEnabled = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession?.stopRunning()
    }
    
    // Restrict user from rotating to landscape
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Change color of Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    // ---------------------------------------------------
    // Normal functions
    private func detectFace(image: UIImage?) -> Bool{
        let imageOptions =  NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
        let personciImage = CIImage(cgImage: (image?.cgImage)!)
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage, options: imageOptions as? [String : AnyObject])
        var faceDetected:Bool = false
        
        if (faces?.first as? CIFaceFeature) != nil {
            faceDetected = true
        } else {
            faceDetected = false
        }
        
        return faceDetected
    }
    
    private func checkCameraStatus() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.

            self.prepareCamera()
           
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.prepareCamera()
                  
                } else {
                    if TempData.comeFromLoginScreen == true {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "CameraScreen_LoginScreen", sender: self)
                        }
                        
                        TempData.comeFromLoginScreen = false
                    }
                    
                    if TempData.comeFromSignupScreen == true {
                        TempData.comeFromSignupScreen = false
                        self.performSegue(withIdentifier: "CameraScreen_Signup3", sender: self)
                    }
                }
            }
            
        case .denied: // The user has previously denied access.
           showDeniedAlert(title: "Camera Access Denied", message: "You have denied access to camera. This can be changed in Settings")
        
            
        case .restricted: // The user can't grant access due to restrictions.
            return
            
        }
    
        
    }
    
    private func showDeniedAlert(title: String, message: String) {
        let alertBox = alert.createAlert(vc: self, title: title, message: message)
        alertBox.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if TempData.comeFromLoginScreen == true {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "CameraScreen_LoginScreen", sender: self)
                }
                
                TempData.comeFromLoginScreen = false
            }
            
            if TempData.comeFromSignupScreen == true {
                TempData.comeFromSignupScreen = false
                self.performSegue(withIdentifier: "CameraScreen_Signup3", sender: self)
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alertBox, animated: true)
        }
    }
    
    
    
    private func prepareCamera(){
        var isFirst = false

        DispatchQueue.global().async {
            if self.captureSession == nil {
                isFirst = true
                self.captureSession = AVCaptureSession()
                self.captureSession!.sessionPreset = AVCaptureSession.Preset.high
            }


            var error: NSError?
            var input: AVCaptureDeviceInput!

            let currentCaptureDevice = self.usingFrontCamera ?
                                       self.getBackCamera() : self.getFrontCamera()

            do {
                input = try AVCaptureDeviceInput(device: currentCaptureDevice!)
            } catch let NSError as NSError {
                error = NSError
                input = nil
                print(error!.localizedDescription)
            }

            for i : AVCaptureDeviceInput in (self.captureSession?.inputs as! [AVCaptureDeviceInput]) {
                    self.captureSession?.removeInput(i)
            }

            for i : AVCaptureOutput in (self.captureSession!.outputs) {
                self.captureSession?.removeOutput(i)
            }

            if error == nil && self.captureSession!.canAddInput(input) {
                self.captureSession!.addInput(input)
            }

            if (self.captureSession?.canAddOutput(self.photoOutput))! {
                self.captureSession?.addOutput(self.photoOutput)
            } else {
                print("Error: Couldn't add meta data output")
                return
            }
            
            DispatchQueue.main.async {
                if isFirst {
                    self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
                    self.videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
                    self.videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                    self.videoPreviewLayer?.frame = self.cameraPreview.layer.bounds
                    self.cameraPreview.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                    self.cameraPreview.layer.addSublayer(self.videoPreviewLayer!)
                    self.captureSession!.startRunning()
                }
            }
        }
    }

    @objc func capture() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = flashMode
        
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                             kCVPixelBufferWidthKey as String: 160,
                             kCVPixelBufferHeightKey as String: 160,
        ]
        settings.previewPhotoFormat = previewFormat
        
        photoOutput.capturePhoto(with: settings, delegate: self)
        
    }
    
    private func getFrontCamera() -> AVCaptureDevice?{
        return AVCaptureDevice.default(.builtInWideAngleCamera, for:AVMediaType.video, position: AVCaptureDevice.Position.front)!
    }
    
    private func getBackCamera() -> AVCaptureDevice{
        return AVCaptureDevice.default(.builtInWideAngleCamera, for:AVMediaType.video, position: AVCaptureDevice.Position.back)!
    }
    
  
}

extension CameraScreenViewController : AVCapturePhotoCaptureDelegate {
   
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        let imageData = photo.fileDataRepresentation()
        let image = UIImage(data: imageData!)
        let imagedata = UIImageJPEGRepresentation(image!, 0.0)
        let base64String : String = imagedata!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        let imageStr : String = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!


        if detectFace(image: image) {
            if TempData.comeFromSignupScreen {
                TempData.facial_img = imageStr
                imageView.image = image

                DispatchQueue.main.asyncAfter(deadline: .now() +  2.0) {
                    TempData.facialRecognitionAdded = true
                    TempData.comeFromSignupScreen = false
                    self.performSegue(withIdentifier: "CameraScreen_Signup3", sender: self)
                
                }
            } else if TempData.comeFromLoginScreen {
                // try network request pull back data
                // see if the subject_id matches with any in core data
            }
        } else {
            if TempData.comeFromSignupScreen {
                imageView.image = image
                alert.showInvalidPhotoAlert(on: self)
            } else {
                // a counter to 5 .
                // if it goes to 5, print no face alert , reset counter
                // this counter is in detectFace above as well, if subject_id doesnt match
            }
        }
    }
}

