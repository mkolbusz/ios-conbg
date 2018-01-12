//
//  ViewController.swift
//  Concurrency
//
//  Created by Użytkownik Gość on 12.01.2018.
//  Copyright © 2018 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var imagesDownloadingTableView: UITableView!
    
    let imagesData: [[String]] = [
        ["Anthony van Dyck - Family Portrait","https://upload.wikimedia.org/wikipedia/commons/0/04/Dyck,_Anthony_van_-_Family_Portrait.jpg"],
//        ["Portrait of a Fat Man","https://upload.wikimedia.org/wikipedia/commons/0/06/Master_of_Flémalle_-_Portrait_of_a_Fat_Man_-_Google_Art_Project_(331318).jpg"],
//        ["Petrus Christus - Portrait of a Young Woman","https://upload.wikimedia.org/wikipedia/commons/c/ce/Petrus_Christus_-_Portrait_of_a_Young_Woman_-_Google_Art_Project.jpg"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesDownloadingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ImageInfoCell")
        print("czesc")
        print(imagesData)
        imagesDownloadingTableView.reloadData();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesData.count
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let image = imagesData[indexPath.row]
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "ImageInfoCell")
        
        cell.textLabel?.text = image[0]
        cell.detailTextLabel?.text = image[1]
        return cell
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response);

            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    @IBAction func downloadImages(_ sender: UIButton) {
        for image in imagesData {
            if let url = URL(string: image[1]) {
                imageView.contentMode = .scaleAspectFit
                downloadImage(url: url)
            }
            print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
        }
        
    }
}

