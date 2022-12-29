//
//  ViewController.swift
//  Yeasir_30021
//
//  Created by bjit on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    var downloadQ = DispatchQueue(label: "com.downlaodq.concurrent", attributes: .concurrent)
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var downloadsTitle: UILabel!
    
    @IBOutlet weak var tasksView: UIView!
    @IBOutlet weak var downloadsView: UIView!
    
    @IBOutlet weak var mainDownloadPrgress: UIProgressView!
    @IBOutlet weak var taskProgressOne: UIProgressView!
    @IBOutlet weak var taskProgressTwo: UIProgressView!
    @IBOutlet weak var taskProgressThree: UIProgressView!
    @IBOutlet weak var taskProgressFour: UIProgressView!
    
    
    var progressValue: Float  = 0.00
    var taskOneProgressValue: Float = 0.00
    var taskTwoProgressValue: Float = 0.00
    var taskThreeProgressValue: Float = 0.00
    var taskFourProgressValue: Float = 0.00
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @IBAction func downloadButtonPressed(_ sender: Any) {
    self.resetProgress()
    showAlert()
    }

}



// MARK: - Q config
extension ViewController{
    // MARK: Reset Progress
    fileprivate func resetProgress() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{return}
            self.taskProgressOne.progressTintColor = UIColor.red
            self.taskProgressTwo.progressTintColor = UIColor.red
            self.taskProgressThree.progressTintColor = UIColor.red
            self.taskProgressFour.progressTintColor = UIColor.red
        }
        
        self.progressValue = 0.0
        self.mainDownloadPrgress.progress = self.progressValue
        
        self.taskOneProgressValue = 0.00
        self.taskProgressOne.progress = self.taskOneProgressValue
        
        self.taskTwoProgressValue = 0.00
        self.taskProgressTwo.progress = self.taskTwoProgressValue
        
        self.taskThreeProgressValue = 0.00
        self.taskProgressThree.progress = self.taskThreeProgressValue
        
        self.taskFourProgressValue = 0.00
        self.taskProgressFour.progress = self.taskFourProgressValue
    }
    
    
    func startDonwload(){
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.setProgress(progessRate: 0.1, progressInd: self.taskProgressOne, taskProgressVal: &self.taskOneProgressValue)
            self.setOverallProgress(progessRate: 1.0/40.0)
            
            self.setProgress(progessRate: 0.1, progressInd: self.taskProgressTwo, taskProgressVal: &self.taskTwoProgressValue)
            self.setOverallProgress(progessRate: 1.0/40.0)
            
            self.setProgress(progessRate: 0.1, progressInd: self.taskProgressThree, taskProgressVal: &self.taskThreeProgressValue)
            self.setOverallProgress(progessRate: 1.0/40.0)
            
            self.setProgress(progessRate: 0.1, progressInd: self.taskProgressFour, taskProgressVal: &self.taskFourProgressValue)
            self.setOverallProgress(progessRate: 1.0/40.0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            timer.invalidate()
        }
    }
    
    
    // MARK: Queue functions
    func qAsync(Q: DispatchQueue){
        downloadQ.async {
            Q.async {
                
                
//                for _ in 1...100{
//                    DispatchQueue.main.async {[weak self] in
//                        guard let self = self else{return}
//
//                        self.setProgress(progessRate: 0.01, progressInd: self.taskProgressOne, taskProgressVal: &self.taskOneProgressValue)
//
//                        self.setOverallProgress(progessRate: 1.0/400.0)
//                    }
//                    Thread.sleep(forTimeInterval: 0.03)
//                }
            }
            
            Q.async {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else{return}
                        
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressTwo, taskProgressVal: &self.taskTwoProgressValue)
                        
                        self.setOverallProgress(progessRate: 1.0/400.0)
                        
                    }
                    Thread.sleep(forTimeInterval: 0.05)
                }
                
            }
            Q.async {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        
                        guard let self = self else{return}
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressThree, taskProgressVal: &self.taskThreeProgressValue)
                        
                        self.setOverallProgress(progessRate: 1.0/400.0)
                        
                    }
                    Thread.sleep(forTimeInterval: 0.04)
                }
                
            }
            Q.async {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else{return}
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressFour, taskProgressVal: &self.taskFourProgressValue)
                        self.setOverallProgress(progessRate: 0.0025)
                        
                    }
                    Thread.sleep(forTimeInterval: 0.02)
                }
               
            }
        }
    }
    
    
    func qSync(Q: DispatchQueue){
        
        downloadQ.async {
            Q.sync {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else{return}
                        
                        self.setProgress(progessRate: 0.01, progressInd: self.taskProgressOne, taskProgressVal: &self.taskOneProgressValue)
                        
                        self.setOverallProgress(progessRate: 1.0/400.0)
                    }
                    Thread.sleep(forTimeInterval: 0.03)
                }
            }
            
            Q.sync {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else{return}
                        
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressTwo, taskProgressVal: &self.taskTwoProgressValue)
                        
                        self.setOverallProgress(progessRate: 1.0/400.0)
                        
                    }
                    Thread.sleep(forTimeInterval: 0.05)
                }
            }
            
            Q.sync {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        
                        guard let self = self else{return}
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressThree, taskProgressVal: &self.taskThreeProgressValue)
                        
                        self.setOverallProgress(progessRate: 1.0/400.0)
                        
                    }
                    Thread.sleep(forTimeInterval: 0.04)
                }
            }
            
            
            
            Q.sync {
                for _ in 1...100{
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else{return}
                        self.setProgress(progessRate: 1.0/100, progressInd: self.taskProgressFour, taskProgressVal: &self.taskFourProgressValue)
                        self.setOverallProgress(progessRate: 0.0025)
                        
                        
                    }
                    Thread.sleep(forTimeInterval: 0.02)
                }
            }
        }
    }
    
    
    func setProgress(progessRate: Float, progressInd: UIProgressView, taskProgressVal: inout Float){
       
            taskProgressVal += progessRate
        
        progressInd.setProgress(Float(taskProgressVal), animated: false)
        if taskProgressVal >= 0.99{
            progressInd.progressTintColor = UIColor.systemGreen
        }
    }
    
    func setOverallProgress(progessRate: Double){
        
        progressValue = progressValue + Float(progessRate)
        mainDownloadPrgress.setProgress(Float(progressValue), animated: false)
    }
    
}




// MARK: - Alert controller

extension ViewController{
    
    func showAlert(){
        let alertVC = UIAlertController(title: "Available Actions", message: "Select Actions",  preferredStyle: .actionSheet)
        
           let globalQueueConcurrentSync = UIAlertAction(title: "Global Sync", style: .default){ [weak self]_ in
            self?.startDonwload()
            }
        
            let globalQueueConcurrentAsync = UIAlertAction(title: "Global Async", style: .default){ [weak self]_ in
                self?.qAsync(Q: DispatchQueue.global())
            }
        
            let customPrivateQueueSerialSync = UIAlertAction(title: "Custom Serial Sync", style: .default){ [weak self]_ in
                self?.qSync(Q: DispatchQueue(label: "serial.sync"))
            }
        
            let customPrivateQueueSerialAsync = UIAlertAction(title: "Custom Serial Async", style: .default){ [weak self]_ in
                self?.qAsync(Q: DispatchQueue(label: "custom serial async"))
                
            }
        
            let customPrivateQueueConcurrentsync = UIAlertAction(title: "Custom Concurrent Sync", style: .default){ [weak self]_ in
                self?.qSync(Q: DispatchQueue(label: "Custom Concurrent Sync", attributes: .concurrent))
            }
        
        let customPrivateQueueConcurrentAsync = UIAlertAction(title: "Custom Concurrent Async", style: .default){ [weak self]_ in
            self?.qAsync(Q: DispatchQueue(label: "Custom Concurrent Aync", attributes: .concurrent))
        }
            let goBackAction = UIAlertAction(title: "Go Back", style: .default){_ in
                alertVC.dismiss(animated: true)
            }
            alertVC.addAction(globalQueueConcurrentSync)
            alertVC.addAction(globalQueueConcurrentAsync)
            alertVC.addAction(customPrivateQueueSerialSync)
            alertVC.addAction(customPrivateQueueSerialAsync)
            alertVC.addAction(customPrivateQueueConcurrentAsync)
            alertVC.addAction(customPrivateQueueConcurrentsync)
            alertVC.addAction(goBackAction)
            present(alertVC, animated: true)
        }
}



// MARK: - UI Configuration

extension ViewController{
    fileprivate func configUI() {
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tasksView.layer.cornerRadius = 8
        
        downloadsView.layer.cornerRadius = 8
        
        mainDownloadPrgress.transform = mainDownloadPrgress.transform.scaledBy(x: 1, y: 8)
        
        taskProgressOne.transform = taskProgressOne.transform.scaledBy(x: 1, y: 10)
        taskProgressTwo.transform = taskProgressTwo.transform.scaledBy(x: 1, y: 10)
        taskProgressThree.transform = taskProgressThree.transform.scaledBy(x: 1, y: 10)
        taskProgressFour.transform = taskProgressFour.transform.scaledBy(x: 1, y: 10)
    }
}





/**
 // create a timer for running the progress bar
     func createTimer(){
         timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
     }

 */

/**
 if taskOneProgressValue < 1.0 {
     taskOneProgressValue += 0.01
     taskProgressOne.progress = taskOneProgressValue
 }
 if taskTwoProgressValue < 1.0 {
     taskTwoProgressValue += 0.01
     taskProgressTwo.progress = taskTwoProgressValue
 }
 if taskThreeProgressValue < 1.0 {
     taskThreeProgressValue += 0.01
     taskProgressThree.progress = taskThreeProgressValue
 }
 if taskFourProgressValue < 1.0 {
     taskFourProgressValue += 0.01
     taskProgressFour.progress = taskFourProgressValue
 }
 
 
 
 func setProgressOne(progessRate: Double){
     taskOneProgressValue = taskOneProgressValue + Float(progessRate)
     taskProgressOne.setProgress(Float(taskOneProgressValue), animated: true)
     print(taskOneProgressValue)
     if taskOneProgressValue >= 0.99{
         taskProgressOne.progressTintColor = UIColor.green
     }
 }
 
 func setProgressTwo(progessRate: Double){
     taskTwoProgressValue = taskTwoProgressValue + Float(progessRate)
     taskProgressTwo.setProgress(Float(taskTwoProgressValue), animated: true)
     if taskTwoProgressValue >= 0.99{
         taskProgressTwo.progressTintColor = UIColor.green
     }
 }
 
 func setProgressThree(progessRate: Double){
     taskThreeProgressValue = taskThreeProgressValue + Float(progessRate)
     taskProgressThree.setProgress(Float(taskThreeProgressValue), animated: true)
     if taskThreeProgressValue >= 0.99{
         taskProgressThree.progressTintColor = UIColor.green
     }
 }
 
 func setProgressFour(progessRate: Double){
     taskFourProgressValue = taskFourProgressValue + Float(progessRate)
     taskProgressFour.setProgress(Float(taskFourProgressValue), animated: true)
     if taskFourProgressValue >= 0.99{
         taskProgressFour.progressTintColor = UIColor.green
     }
 }
 
 func setOverallProgress(progessRate: Double){
     progressValue = progressValue + Float(progessRate)
     mainDownloadPrgress.setProgress(Float(progressValue), animated: true)
 }
 */

