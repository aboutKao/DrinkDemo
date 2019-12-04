//
//  AddDrinkTableViewController.swift
//  DrinkDemo_pt
//
//  Created by Kao on 2019/11/14.
//  Copyright © 2019 Kao Che. All rights reserved.
//

import UIKit

class AddDrinkTableViewController: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
   
    override func viewDidLoad() {
           super.viewDidLoad()
           picker.delegate = self
           picker.dataSource = self
           nameTextField.inputView = picker
          
       }
    //-----------------品名----------------
   
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var namePickerView: UIPickerView!
    
    var drinks = ["紅茶","綠茶","奶茶"]
    var picker = UIPickerView()
    
   

    //顯示有幾個軸
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
              return 1
          }
    
    //顯示有幾列
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return drinks.count
        
    }
    //顯示名稱
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            return drinks[row]
        
    
    }
    //執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameTextField.text = drinks[row]
        self.view.endEditing(false)
        
        switch drinks[row] {
        case "紅茶":
            totalLabel.text = "\(1)"
            priceLabel.text = "\(20)"
            case "綠茶":
            totalLabel.text = "\(1)"
            priceLabel.text = "\(25)"
            case "奶茶":
            totalLabel.text = "\(1)"
            priceLabel.text = "\(30)"
        default:
            break
        }
    }
    //------------------品名--------------------
    
    //------------------冰量--------------------
    @IBOutlet weak var iceSegmentedControl: UIView!
    
    
    var ice = ""
    @IBAction func iceSCAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            ice = "熱"
        }else if sender.selectedSegmentIndex == 1{
            ice = "去冰"
        }else if sender.selectedSegmentIndex == 2{
            ice = "微冰"
        }else if sender.selectedSegmentIndex == 3{
            ice = "少冰"
        }else{
            ice = "正常冰"
        }
    }
    //------------------冰量--------------------
    
    
    
    
    //------------------甜度--------------------
  
    var suger = ""
    @IBAction func sugerSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            suger = "無糖"
        }else if sender.selectedSegmentIndex == 1{
            suger = "微糖"
        }else if sender.selectedSegmentIndex == 2{
            suger = "半糖"
        }else if sender.selectedSegmentIndex == 3{
            suger = "少糖"
        }else{
            suger = "正常甜"
        }
    }
    //------------------甜度--------------------
    
   
    //-------備註--------
    
    @IBOutlet weak var remarkTextField: UITextField!
    
    
    
   
    
    //-------備註--------
    
    
    
    
    //-----總數-------
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBAction func totalChange(_ sender: UIStepper) {
        let total = Int(sender.value)
        totalLabel.text = "\(total)"
       
        if nameTextField.text == "紅茶"{
            priceLabel.text = "\(total * 20)"
        
        }else if nameTextField.text == "綠茶"{
            priceLabel.text = "\(total * 25)"
        }else {
            priceLabel.text = "\(total * 30)"
        }
       

    }
    //-------小計--------
    
    @IBOutlet weak var pricelb: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    //-----總數-------
    
    
    //------送出------
    @IBAction func done(_ sender: UIBarButtonItem) {
        let drink = Drink(name: nameTextField.text!, ice: ice, suger: suger, remark: remarkTextField.text!, price: priceLabel.text!,total: totalLabel.text!)
        //搭配 JSONEncoder 將⾃訂型別變成JSON 格式的 Data
    let drinkData = DrinkData(data: drink)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(drinkData){
            //請求送資料至sheetDB端，上傳 JSON 格式資料記得要設定 POST & content type
            var request = URLRequest(url: URL(string: "https://sheetdb.io/api/v1/k03kyzmjyti8p")!)
            request.httpMethod = "post"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //利用子執行緒上傳資料
            let task = URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
                //要在主執行緒執行UI相關的程式，上傳資料後利用主執行緒回到上一頁
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            //------送出------
            task.resume()
        }else{
            print("b")
        }
            
        }
    
    
    
   

    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
