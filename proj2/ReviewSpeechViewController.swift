//
//  ReviewSpeechViewController.swift
//  proj2
//
//  Created by admin on 5/18/21.
//

import UIKit
import Speech
class ReviewSpeechViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    let audioEng = AVAudioEngine()
    let speechRec = SFSpeechRecognizer()
    let req = SFSpeechAudioBufferRecognitionRequest()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    
    @IBOutlet weak var textLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startRec(_ sender: UIButton) {
            isStart = !isStart
            if isStart {
                startSpeechRecog()
                sender.setTitle("click here to stop speech rec", for: .normal)
            }
            else{
                cancelSpeechRecog()
                sender.setTitle("click here to start speech rec", for: .normal)
            }
    }
    
    @IBAction func submitRev(_ sender: Any) {
        if(self.textLab.text != nil && self.textLab.text!.count > 2){
            DBHelper.inst.addNewReview(object: self.textLab.text!)
        }
    }
    
    func cancelSpeechRecog(){
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()
        
        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
    }
    
    func startSpeechRecog(){
        let nd = audioEng.inputNode
        let recordF = nd.outputFormat(forBus: 0)
        
        nd.installTap(onBus: 0, bufferSize: 1024, format: recordF){ (buffer, _) in
                self.req.append(buffer)
        }
        audioEng.prepare()
        do{
            try audioEng.start()
        }
        catch let err {
            print(err)
        }
        
        rTask = speechRec?.recognitionTask(with: req, resultHandler: { (resp, error) in
            guard let resps = resp else{
                if error != nil {
                    ///Users/admin/Downloads/Rating File
                    print(error.debugDescription)
                }else{
                    print("problem in response")
                }
                return
            }
            let msg = resp?.bestTranscription.formattedString
            print(msg)
            self.textLab.text = msg
            
            var lastStr = ""
            for seg in resp!.bestTranscription.segments{
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                lastStr = String(msg![indexTo...])
            }
           
            
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
