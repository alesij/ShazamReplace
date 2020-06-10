//
//  ViewController.swift
//  Shazam
//
//  Created by Alessio Di Matteo on 09/12/2019.
//  Copyright © 2019 Alessio Di Matteo. All rights reserved.
//

import UIKit
import CoreML
import SoundAnalysis
import AVFoundation


class ViewController: UIViewController, UIScrollViewDelegate {
    
    //statusBar hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var pulseLayers = [CAShapeLayer]()
    // Audio Engine
    var audioEngine = AVAudioEngine()
    
    // Streaming Audio Analyzer
    var streamAnalyzer: SNAudioStreamAnalyzer!
    
    // Serial dispatch queue used to analyze incoming audio buffers.
    let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
    
    
    var resultsObserver: ResultsObserver!
    var flag = false
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var shazamButton: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        
        let model1 = MySoundClassifier()
        let model: MLModel = model1.model
        
        // Get the native audio format of the engine's input bus.
        let inputFormat = self.audioEngine.inputNode.inputFormat(forBus: 0)
        
        // Create a new stream analyzer.
        streamAnalyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        // Create a new observer that will be notified of analysis results.
        // Keep a strong reference to this object.
        resultsObserver = ResultsObserver()
        
        do {
            // Prepare a new request for the trained model.
            let request = try SNClassifySoundRequest(mlModel: model)
            try streamAnalyzer.add(request, withObserver: resultsObserver)
        } catch {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
        
        // Install an audio tap on the audio engine's input node.
        self.audioEngine.inputNode.installTap(onBus: 0,
                                              bufferSize: 8192, // 8k buffer
        format: inputFormat) { buffer, time in
            // Analyze the current audio buffer.
            self.analysisQueue.async {
                self.streamAnalyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
            }
        }
    }
    
    func startAudioEngine() {
        do {
            // Start the stream of audio data.
            try self.audioEngine.start()
        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func shazamPressed(_ sender: UIButton) {
        
        UIButton.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn,
                         animations: {
                            self.photoButton.isHidden = true
                            self.label.isHidden = true
                            self.label2.isHidden = true
                            self.shazamButton?.transform = CGAffineTransform(translationX: 0, y: 40)
        },
                         completion: nil)
        
        
        shazamButton.layer.cornerRadius = shazamButton.frame.size.width/2.0
        createPulse()
        
        self.startAudioEngine()
        perform(#selector(goToNextView), with: nil, afterDelay: 9.0)
    }
    
    func createPulse(){
        
        for _ in 0...2 {
            
            let circularPath = UIBezierPath(arcCenter: .zero, radius: UIScreen.main.bounds.width/2.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            let pulseLayer =  CAShapeLayer()
            pulseLayer.path = circularPath.cgPath
            pulseLayer.lineWidth = 2.0
            pulseLayer.fillColor = UIColor.clear.cgColor
            pulseLayer.lineCap = CAShapeLayerLineCap.round
            pulseLayer.position = CGPoint(x: shazamButton.frame.size.width/2.0, y:shazamButton.frame.size.width/2.0)
            shazamButton.layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
        
        animatePulse(index: 1)
        animatePulse(index: 2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatePulse(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.animatePulse(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.animatePulse(index: 2)
                }
            }
        }
        
    }
    func animatePulse(index: Int){
        
        pulseLayers[index].strokeColor = UIColor.white.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.fromValue = 0.5
        scaleAnimation.toValue = 0.9
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleAnimation.repeatCount = .infinity
        //        scaleAnimation.autoreverses = true
        pulseLayers[index].add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.repeatCount = .infinity
        //        opacityAnimation.autoreverses = true
        pulseLayers[index].add(opacityAnimation, forKey: "opacity")
    }
    
    
    @objc func goToNextView() {
        if(Session.sharedInstance.detectedSong != "***Noise***"){
        performSegue(withIdentifier: "resultSegue", sender: self)
        }
        else {
           performSegue(withIdentifier: "notFound", sender: self)
        }
        self.audioEngine.stop()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setting()
    }
    
    func setting(){
        //animazione button
        UIButton.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction],
                         animations: {
                            self.shazamButton?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        },
                         completion: nil)
        /*
         aniazioni label
         */
        UILabel.animate(withDuration:1.5, delay:0, options:[.repeat,.autoreverse], animations:{
            self.label?.transform = CGAffineTransform(translationX: 0, y: -40)
            self.label?.alpha = 0.0
            self.label2?.alpha = 1.0
            self.label2?.transform = CGAffineTransform(translationX: 0, y: -20)
        },completion: nil)
    }
}
// Observer object that is called as analysis results are found.
class ResultsObserver : NSObject, SNResultsObserving {
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        
        /// Get the top classification.
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        /// Determine the time of this result.
        let formattedTime = String(format: "%.2f", result.timeRange.start.seconds)
        print("Analysis result for audio at time: \(formattedTime)")
        
        let confidence = classification.confidence * 100.0
        let percent = String(format: "%.2f%%", confidence)
        
        /// Print the result as Instrument: percentage confidence.
        print("\(classification.identifier): \(percent) confidence.\n")
        
        if (confidence >= 99.5 /*&& classification.identifier != "***Noise***"*/) {
            Session.sharedInstance.detectedSong = classification.identifier
            print(classification.identifier)
        }
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The the analysis failed: \(error.localizedDescription)")
    }
    
    @objc func requestDidComplete(_ request: SNRequest) {
        print("The request completed successfully!")
    }
}

