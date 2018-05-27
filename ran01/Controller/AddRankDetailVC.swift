//
//  AddRankDetailVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/21.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit

class AddRankDetailVC: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var photoImage: UIButton!
    @IBOutlet weak var nameOfItemTextField: UITextField!
    @IBOutlet weak var explanationTextView: UITextView!
    
//    let rankAllay = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let rankAllay = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var rankingKey: String = ""
    var rank: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
//        print("rankingKey:")
//        print(rankingKey)
    }
    
    @IBAction func photoBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if nameOfItemTextField.text != nil && nameOfItemTextField.text != "" {
            DataService.instance.addRankingItemDetail(withRank: rank, title: nameOfItemTextField.text!, explanation: explanationTextView.text, image: "", withRankingKey: rankingKey) { (success) in
//                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "AddRankingVC", sender: self.rankingKey)
            }
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addRankingVC = segue.destination as? AddRankingVC {
            addRankingVC.rankingKey = sender as! String
        }
    }
}

extension AddRankDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rankAllay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return rankAllay[row]
        return "\(rankAllay[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let choice = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
        
        rank = Int(choice!)!
        print("\(choice!)")
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
}
