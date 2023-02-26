//
//  ViewController.swift
//  Picker View
//
//  Created by 라완 💕 on 20/04/1444 AH.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    
    var gameState:Int = Int()
    var pickerData = [String]()
    var selectedRange = Int()
    var chosenNum = Int()
    var guessedNum = Int()
    var gameResults = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restart()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonPress(_ sender: UIButton) {
        switch gameState {
        case 0:
            picker.isUserInteractionEnabled = true
            pickerData.removeAll()
            
            for i in 1..<selectedRange+1 {
                pickerData.append(String(i))
            }
            picker.reloadAllComponents()
            picker.selectRow(0, inComponent: 0, animated: true)
            
            label.text = "Player 1\n\nEnter your the number for player 2 to guess from 1 to \(selectedRange)"
            button.setTitle("enter number", for: .normal)
            gameState += 1
            button.isEnabled = false
            
        case 1:
            picker.selectRow(0, inComponent: 0, animated: true)
            let chances = Double(Float(1)/Float(selectedRange)*100)
            print(selectedRange, chances)
            label.text = "Player 2\n\nTake a guess (1 out of \(selectedRange) or \(round(chances * 100)) % chance)"
            button.setTitle("enter guess", for: .normal)
            gameState += 1
            button.isEnabled = false
            
        case 2:
            picker.isUserInteractionEnabled = false
            label.text = gameResults
            button.setTitle("play again", for: .normal)
            gameState += 1
            selectedRange = 5001
            
        case 3:
            restart()
        default:
            break
        }
    }
    func restart() {
        picker.isUserInteractionEnabled = true
        picker.selectRow(0, inComponent: 0, animated: true)
        label.text = "Please select the range for the gussing game"
        button.setTitle("enter range", for: .normal)
        button.isEnabled = false
        
        pickerData.removeAll()
        for i in 1..<5001 {
            pickerData.append(String(i))
        }
        gameState = 0
        
        picker.reloadAllComponents()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        button.isEnabled = true
        switch gameState {
        case 0:
            selectedRange = row + 1
        case 1:
            chosenNum = row + 1
        case 2:
            guessedNum = row + 1
            if chosenNum == guessedNum {
                gameResults = "Correct!\n\nThe chosen number was \(chosenNum) and you gussed \(guessedNum)"
            }else {
                gameResults = "Incorrect!\n\nThe chosen number was \(chosenNum) and you gussed \(guessedNum)"
            }
            
        default:
            break
        }
    }
}

