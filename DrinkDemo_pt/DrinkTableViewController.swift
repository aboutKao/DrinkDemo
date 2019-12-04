//
//  DrinkTableViewController.swift
//  DrinkDemo_pt
//
//  Created by Kao on 2019/11/15.
//  Copyright © 2019 Kao Che. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {

    var drinks = [Drink]()
    override func viewDidAppear(_ animated: Bool) {
        
        let urlSrt = "https://sheetdb.io/api/v1/k03kyzmjyti8p"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        //網址後面是為了解決網址內有中文的，都先打起來以備不時之需
        if  let url = URL(string: urlSrt){
            //使用子執行緒抓資料
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                //↓背！！ 更新抓資料下來需要解碼。利⽤ JSONDecoder 將型別 Data 的JSON 資料變成型別 [Drink]
                let decoder = JSONDecoder()
                if let data = data,let drinks = try? decoder.decode([Drink].self, from: data){
                    self.drinks = drinks
                    //⇡背！！ 更新抓資料下來需要解碼。利⽤ JSONDecoder 將型別 Data 的JSON 資料變成型別 [Drink]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    // MARK: - Table view data source
//一個區塊
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    //顯示cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        
        //這兩串是UI屬性的東西
        cell.textLabel?.text = drinks[indexPath.row].name
        cell.detailTextLabel?.text = drinks[indexPath.row].total
        
        // Configure the cell...

        return cell
    }
    

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
