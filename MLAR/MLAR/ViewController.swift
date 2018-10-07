//
//  ViewController.swift
//  MLAR
//
//  Created by K on 10/6/18.
//  Copyright © 2018 K. All rights reserved.
//

import UIKit
//import SceneKit
import ARKit
import AVFoundation
import Vision

class ViewController: UIViewController, ARSCNViewDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    var sceneView: ARSCNView!
    
    @IBOutlet weak private var previewView: UIView!

    var rootLayer: CALayer! = nil

    private let session = AVCaptureSession()
    
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    private let videoDataOutput = AVCaptureVideoDataOutput()
    
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Implement this in the subclass.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Set the view's delegate
//        sceneView.delegate = self
//
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//
//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
        
        setupAVCapture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device and make an input.
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error).")
            return
        }
        
        session.beginConfiguration()
        
        // The model input size is smaller than 640x480, so better resolution won't help us.
        session.sessionPreset = .vga640x480
        
        // Add a video input.
        guard session.canAddInput(deviceInput) else {
            print("Could not add video device input to the session.")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            // Add a video data output.
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session.")
            session.commitConfiguration()
            return
        }
        let captureConnection = videoDataOutput.connection(with: .video)
        
        // Always process the frames.
        captureConnection?.isEnabled = true
        
        session.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = previewView.layer
        previewLayer.frame = rootLayer.bounds
        rootLayer.insertSublayer(previewLayer, at: 0)
    }
    
    func startCaptureSession() {
        session.startRunning()
    }
    
    // Clean up capture setup.
    func teardownAVCapture() {
        previewLayer.removeFromSuperlayer()
        previewLayer = nil
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("The capture output dropped a frame.")
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, Home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, Home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, Home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, Home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
////        // Create a session configuration
////        let configuration = ARWorldTrackingConfiguration()
////
////        // Run the view's session
////        sceneView.session.run(configuration)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
////        // Pause the view's session
////        sceneView.session.pause()
//    }
//
//    // MARK: - ARSCNViewDelegate
//    
///*
//    // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//     
//        return node
//    }
//*/
//    
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//        
//    }
//    
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//        
//    }
//    
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//        
//    }
}
