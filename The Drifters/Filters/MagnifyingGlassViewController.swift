//
//  MagnifyingGlassViewController.swift
//  The Drifters
//
//  Created by Graziella Caputo on 10/02/2018.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class MagnifyingGlassViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

   
    var plantArray: [Plant] = []
    var plantImage: [UIImage] = []
    var imageNoResult = UIImageView()
    
    
    var resultSearchController = UISearchController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
       
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = UIColor.clear
        
         resultSearchController.searchBar.delegate = self
        
        searchBar.delegate = self
        setUpSearchBar()
        
        plantArray = ricercaPerFiltri(arrayFiltri: filtri)
        for each in plantArray{
        plantImage.append(generaImmagine(istanzaPianta: each))
        }
        
        searchBar.autocapitalizationType = .none
        self.hideKeyboardWhenTappedAround()
        
        imageNoResult.frame = CGRect(x: 116, y: 307, width: 140, height: 26)
        imageNoResult.contentMode = .scaleAspectFit
        imageNoResult.image = #imageLiteral(resourceName: "imageNoResultFound")
        imageNoResult.isHidden = true
        self.view.addSubview(imageNoResult)

       
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        view.endEditing(true)
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return plantArray.count
    }
    

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! SearchTableViewCell
 
  
    
        cell.namePlantLabel.text = (plantArray[indexPath.row].commonName)?.firstUppercased
        
        cell.plantImageView.image = generaImmagine(istanzaPianta: plantArray[indexPath.row]) 

        
        cell.plantImageView.layer.cornerRadius = 10
        cell.plantImageView.layer.masksToBounds = true
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }

    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let garderStoryboard: UIStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "detailsID") as! DetailsViewController
        
    
        destinationView.plantObject = plantArray[indexPath.row]
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            plantArray = ricercaPerFiltri(arrayFiltri: filtri)
            
            svuotaFiltri()
            
            self.tableView.reloadData()
        } else {
            
            aggiungiFiltri(nomeFiltro: "commonName", valoreFiltro: searchText)
            plantArray = ricercaPerFiltri(arrayFiltri: filtri)
            svuotaFiltri()
            
            self.tableView.reloadData()
           
        }
    }
 
    


    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        self.hideKeyboardWhenTappedAround()
        return true
    }
    
    
    private func setUpSearchBar(){
        
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if plantArray.isEmpty {
            tableView.isHidden = true
            imageNoResult.isHidden = false
        } else{
            tableView.isHidden = false
            imageNoResult.isHidden = true
        }
    }
 
}


