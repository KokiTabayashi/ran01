//
//  CreateRankingVC.swift
//  ran01
//
//  Created by Koki Tabayashi on 2018/05/24.
//  Copyright © 2018年 Koki Tabayashi. All rights reserved.
//

import UIKit
import Firebase

class CreateRankingVC: UIViewController {
    
    @IBOutlet weak var rankingNameTextField: UITextField!
    @IBOutlet weak var errorMessageLbl: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var numberOfItemsInRanking = 10
    var numberSelection: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLbl.isHidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self

        for i in 1...100 {
            numberSelection.append(i)
        }
        pickerView.selectRow(9, inComponent: 0, animated: true)
    }
    
    @IBAction func createBtnWasPressed(_ sender: Any) {
        if rankingNameTextField.text != nil && rankingNameTextField.text != "" {
            
            if let userID = Auth.auth().currentUser?.uid {
                
                DataService.instance.registerRankingTmp(withTitle: rankingNameTextField.text!, userId: userID, numberOfItems: numberOfItemsInRanking) { (success, rankingKey) in
                    if success && rankingKey != "" {

                        let rankingKey: String = rankingKey
                        self.performSegue(withIdentifier: "AddRankDetailVC", sender: rankingKey)

                    } else {
                        self.errorMessageLbl.isHidden = false
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addRankDetailVC = segue.destination as? AddRankDetailVC {
            addRankDetailVC.rankingKey = sender as! String
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateRankingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberSelection[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let choice = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
        
        numberOfItemsInRanking = Int(choice!)!
    }
}
