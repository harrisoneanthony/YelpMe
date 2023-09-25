//
//  YelpMeDelegate.swift
//  YelpMe
//
//  Created by Harrison Anthony on 8/2/23.
//

import UIKit

extension YelpMe {
    
    func setupTable() {
        
        self.tableView.delegate     = self
        self.tableView.dataSource   = self
        
        tableView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell {
            
            let business = self.businesses[indexPath.row]
            
            cell.name.text          = business.name
            cell.address1.text      = business.location.address1
            cell.cityStateZip.text  =
                String(format: "%@ %@  %@",
                       business.location.city,
                       business.location.state,
                       business.location.zip_code)
            cell.url.text           = "Website"
            cell.url.textColor      = .systemBlue
            createUrl(label: cell.url, urlString: business.url)
            
            return cell
            
        }

//        if let businesses = ourRestaurants?.businesses, indexPath.row < businesses.count {
//                let business = businesses[indexPath.row]
//            } else {
//                cell.restaurantLabel.text = "No data available"
//            }
//            return cell
        return UITableViewCell()
    }
    
    func createUrl(label: UILabel, urlString: String) {
        let tap = TapUrl(target: self, action: #selector(tapped(_:)))
        tap.urlString                   = urlString
        label.isUserInteractionEnabled  = true
        label.addGestureRecognizer(tap)
        
    }
    
    @objc func tapped(_ sender: TapUrl) {
        print(sender.urlString)
        if let url = URL(string: sender.urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                
                success in
                
                if success {
                    print("Success!")
                } else {
                    print(String(format: "Can't open url: %@", sender.urlString))
                }
                
            })
        }
    }
}

