//
//  ViewController.swift
//  api
//
//  Created by Apple MacBook Pro on 2/17/20.
//  Copyright © 2020 Apple MacBook Pro. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    var modelView = [MyModel]()
        var imageArray = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            fatechData()
        }
        func fatechData()  {
                let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
                URLSession.shared.dataTask(with: url!){(data,response,error) in
                    if error == nil{
                        do{
                            let myData = try! JSONDecoder().decode([MyModel].self, from: data!)
                            DispatchQueue.main.async {
                                for n in myData{
                                    //self.titleName.append(n.title)
                                    self.imageArray.append(n.url)
                                }
                                self.tableView.reloadData()
                            }
                        }catch{
                            print("Nothing Found")
                        }
                    }
                    
                }.resume()
                
            }

    }
    extension ViewController: UITableViewDataSource,UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return imageArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
                   let url = URL(string: imageArray[indexPath.row])
                   DispatchQueue.global().async {
                                       let data = try?Data(contentsOf: url!)
                                       DispatchQueue.main.async {
                                           cell.imageView1.image = UIImage(data: data!)
                                       }
                                   }
                   return cell
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 350
        }
        
    }

