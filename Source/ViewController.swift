//
//  ViewController.swift
//  Ovo
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // Variaveis
    var timer : Timer?
    var time = 210
    var player: AVAudioPlayer!
    
    // Link com btPlay
    @IBOutlet weak var playBtn: UIButton!

    let formatter = DateComponentsFormatter()

    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        let timeStr = formatter.string(from: TimeInterval(time))!
        timerLabel.text = String(timeStr)

        let path = Bundle.main.path(forResource: "chicken", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
        
    }

    
    // Função para refresh da tela
    @objc func decreaseTimer() {
        if time > 0 {
            time -= 1
            
            let timeStr = formatter.string(from: TimeInterval(time))!
            timerLabel.text = String(timeStr)
            
        } else {
            
            timer!.invalidate()
            let image = UIImage(named: "play")
            self.playBtn.setImage(image, for: .normal)

            player.play()

        }
    }

    // Bt Play
    @IBAction func playBtnClk(_ sender: Any) {
        
        if(timer == nil) {
            // Inicia thread
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
            playBtn.setTitle("pause", for: .normal)
            
            let image = UIImage(named: "pause")
            self.playBtn.setImage(image, for: .normal)
            
        } else {
            // Para thread
            timer!.invalidate()
            timer = nil

            let image = UIImage(named: "play")
            self.playBtn.setImage(image, for: .normal)
            
        }

    }
    
    // Link com label principal
    @IBOutlet weak var timerLabel: UILabel!
    
    // Bt MINUS
    @IBAction func minusTen(_ sender: Any) {
        if time > 10 {
            time -= 10
            let timeStr = formatter.string(from: TimeInterval(time))!
            timerLabel.text = String(timeStr)
        }
    }
    
    // Bt PLUS
    @IBAction func plusTen(_ sender: Any) {
        time += 10
        let timeStr = formatter.string(from: TimeInterval(time))!
        timerLabel.text = String(timeStr)
    }
    
    // Bt RESET
    @IBAction func reset(_ sender: Any) {
        time = 210
        let timeStr = formatter.string(from: TimeInterval(time))!
        timerLabel.text = String(timeStr)
    }
    


}

