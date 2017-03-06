//
//  UserInfoTableVC.swift
//  UserInfoApp
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Freeman. All rights reserved.
//

import UIKit

class UserInfoTableVC: UITableViewController {
    
    
    var jsonUsers = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fileUrl =  Bundle.main.url(forResource: "users", withExtension: "json")  {
            do{
                let data = try Data(contentsOf: fileUrl, options: Data.ReadingOptions.mappedIfSafe)
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [[String:Any]]
                else{
                    return
                }
                for item in json!{
                    if let curent = User(json: item){
                        jsonUsers.append(curent)
                    }
                    
                }
                
            }catch let error{
                print(error.localizedDescription)
            }
            
        }
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonUsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath)
        if let curentCell = cell as? UserInfoTVCell{
            curentCell.firstNameLbl.text = jsonUsers[indexPath.row].firstName
            curentCell.lastNameLbl.text = jsonUsers[indexPath.row].lastName
            curentCell.emailLbl.text = jsonUsers[indexPath.row].email
        
        // Configure the cell...
        
        if let hashString = jsonUsers[indexPath.row].email.md5(){
           let imageUrlString = "https://www.gravatar.com/avatar/" + hashString
            let imageUrl = URL(string: imageUrlString)
            curentCell.photoView.downloadAsync(from: imageUrl!, defaultNamedImage: "NoPhoto")
        }else{
            curentCell.photoView.image = UIImage(named: "NoPhoto")
        }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
