//
//  YelpMe.swift
//  YelpMe
//
//  Created by Steven Craig Sickles on 7/26/23.
//

import UIKit
import Alamofire
import CoreLocation

class YelpMe: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var viewAll: UITextView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var barSearch: UISearchBar!

    var businesses  = [Business]()
    
    var tableData = ["1", "2", "3", "4"]
    
    let token = "37ayPhhA3QBrYhKjSnEzolZvKwGowA4VkJWSro6dq09by_jXBL-db-2ygGCX4osuKI7MT-VPQZTHg48ohf7dac2gKVESPOAjOAehDLoAoZSnZXwqZCub2pJ6jJ7HZHYx"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupTable()
        
        self.barSearch.delegate = self
 
    }
    
    func fetchBusinessesFromAddress(_ address: String, completion:@escaping(_ success: Bool, _ businesses: [Business]?)->()) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            
            weak var weakSelf = self
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                
                let lat = location.coordinate.latitude
                let lng = location.coordinate.longitude
                
                weakSelf?.fetchBusinesses(lat: lat, lng: lng) {
                    success, businesses in
                    
                    if success {
                        completion(true, businesses)
                    } else {
                        completion(false, nil)
                    }
                    return
                }

            }
            completion(false, nil)
        }
        
    }
    
    func fetchBusinesses(lat: Double, lng: Double, completion: @escaping(_ success: Bool, _ businesses: [Business]?) -> ()) {
        
        let headers = [
            "Authorization" : String(format: "Bearer %@", token),
            "Content-Type": "application/json"
        ]
        Alamofire.request( "https://api.yelp.com/v3/businesses/search?sort_by=best_match&limit=20&latitude=\(lat)&longitude=\(lng)", headers: headers)
            .response { response in

            if let data = response.data,
               let jsonString = String(data: data, encoding: .utf8) {
                
                print(jsonString)

                if let jsonDecoded = try? JSONDecoder().decode(Businesses.self, from: data) {
                    
                    if let businesses = jsonDecoded.businesses {
                        self.businesses = businesses
                        completion(true, businesses)
                        return
                    }
                    
                }

            }
            completion(false, nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchValue = searchBar.searchTextField.text else {
            // Print Error Message
            return
        }
        
        fetchBusinessesFromAddress(searchValue) {
            success, businesses in
            
            if success,
               let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
            } else {
                //  Print Error Message
            }
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        self.businesses = [Business]()
        self.tableView.reloadData()
    }
}

