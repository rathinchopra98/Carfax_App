//
//  CarTableViewController.swift
//  Carfax_App
//
//  Created by Rathin Chopra on 2022-01-06.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

class CarTableViewController: UITableViewController {
    
    var carListinfo = [Car]()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestDataFromAPI(completion: {_ in
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carListinfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarListCell", for: indexPath) as! CarTableViewCell

        // Configure the cell...
        DispatchQueue.global().async {
            let url = NSURL(string: self.carListinfo[indexPath.row].carImage)
            if let data = try? Data(contentsOf: url as! URL) {
                
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    cell.carImageView.image = UIImage(data: data)
                }
            }
        }
        cell.carNameLabel.text = self.carListinfo[indexPath.row].carMakeYear + " " + self.carListinfo[indexPath.row].carMake + " " + self.carListinfo[indexPath.row].carModel
        cell.priceLabel.text = String(format: "$%.2f", self.carListinfo[indexPath.row].carPrice) + " | " + (Int(self.carListinfo[indexPath.row].carMileage)).roundedWithAbbreviations + " | " + self.carListinfo[indexPath.row].carLocation
        cell.dealerPhoneBtn.setTitle(("+1"+self.carListinfo[indexPath.row].carDealerPhone), for: .normal)
        cell.actionBlock = {
            if let  CallURL:NSURL = NSURL(string:"tel://\(self.carListinfo[indexPath.row].carDealerPhone)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL( CallURL as URL)) {
                    application.open( CallURL as URL);
                }
                else
                {
                    // your number not valid
                    let tapAlert = UIAlertController(title: "Alert!!!", message: "Your mobile number is invalid", preferredStyle: UIAlertController.Style.alert)
                    tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    self.present(tapAlert, animated: true, completion: nil)
                }
            }
        }
        return cell
    }
    
    func requestDataFromAPI(completion: @escaping ([Car]) -> Void){
        let url = "https://carfax-for-consumers.firebaseio.com/assignment.json"
        var carList = [Car]()
        var carInfoJson:JSON?
        AF.request(url).validate().responseJSON {
            response in
            switch response.result {
                case .success:
                    if let value = response.data {
                        carInfoJson = JSON(value)
                        if(carInfoJson!["listings"].count != 0){
                            for i in 0...carInfoJson!["listings"].count - 1{
                                let item = Car(carMake: carInfoJson!["listings"][i]["make"].stringValue, carModel: carInfoJson!["listings"][i]["model"].stringValue, carLocation: (carInfoJson!["listings"][i]["dealer"]["city"].stringValue + " " + carInfoJson!["listings"][i]["dealer"]["state"].stringValue), carImage: carInfoJson!["listings"][i]["images"]["firstPhoto"]["medium"].stringValue, carMakeYear: carInfoJson!["listings"][i]["year"].stringValue, carTrim: carInfoJson!["listings"][i]["trim"].stringValue, carPrice: carInfoJson!["listings"][i]["listPrice"].doubleValue, carMileage: carInfoJson!["listings"][i]["mileage"].doubleValue, carDealerPhone: carInfoJson!["listings"][i]["dealer"]["phone"].stringValue)
                                carList.append(item)
                            }
                            self.carListinfo = carList
                            completion(carList)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
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
