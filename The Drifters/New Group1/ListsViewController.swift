//
//  ListsViewController.swift
//  The Drifters
//
//  Created by Mariapia Pansini on 14/02/18.
//  Copyright © 2018 Graziella Caputo. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let buttonBar = UIView()
    class Responder: NSObject {
        @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControll.frame.width / CGFloat(self.segmentedControll.numberOfSegments)) * CGFloat(self.segmentedControll.selectedSegmentIndex)
        }
    }
    
    let imageArrayTest1 = [UIImage(named: "001.jpg"), UIImage(named: "001.jpg"), UIImage(named: "Picture"), UIImage(named: "SecondOnB")]
    let imageArrayTest2 = [UIImage(named: "Picture"), UIImage(named: "plant-on-a-hand-2"), UIImage(named: "searching-magnifying-glass")]
    let textArray1 = ["One", "Two", "Three"] //array di prova per le sezioni di garden
    let textArray2 = ["1", "2", "3"] //array di prova per le sezioni di favorite

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    var selectedSegment = 1
    
    @IBAction func SelectSegmentedControll(_ sender: UISegmentedControl) {
    
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
        } else {
            selectedSegment = 2
        }
        
        self.tableView.reloadData()        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let responder = Responder()
        
        segmentedControll.backgroundColor = .clear
        segmentedControll.tintColor = .clear
        segmentedControll.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedControll.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.black
            ], for: .selected)
        
       
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor(red: 175.0/255.0, green: 65.0/255.0, blue: 55.0/255.0, alpha: 1.00)
        view.addSubview(buttonBar)
        buttonBar.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControll.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControll.widthAnchor, multiplier: 1 / CGFloat(segmentedControll.numberOfSegments)).isActive = true
        
        segmentedControll.addTarget(responder, action: #selector(responder.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

    }
    
    //  override function viewWillAppear to hidden FOREVER navigationBar in Lists view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell

        cell.clCollectionView.reloadData()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        return objects.count
        if selectedSegment == 1 {
            return textArray1.count
        } else {
            return textArray2.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //   collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedSegment == 1 {
            return imageArrayTest1.count
        } else {
            return imageArrayTest2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsideCollectionViewCell", for: indexPath) as! InsideCollectionViewCell
        
        if selectedSegment == 1 {
            cell.imageCell.image = imageArrayTest1[indexPath.row]
        } else {
            cell.imageCell.image = imageArrayTest2[indexPath.row]
        }
        //        impostazioni per la struttura grafica delle immagini delle collectionView

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinazioneVC = mainStoryboard.instantiateViewController(withIdentifier: "DatailViewController") as! DatailViewController
//        destinazioneVC.image = imageArray[indexPath.row]!
//        self.navigationController?.pushViewController(destinazioneVC, animated: true)
        
        let garderStoryboard: UIStoryboard = UIStoryboard(name: "MyGarden", bundle: nil)
        let destinationView = garderStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if selectedSegment == 1 {
            destinationView.image = imageArrayTest1[indexPath.row]!
        } else {
            destinationView.image = imageArrayTest2[indexPath.row]!
        }
        self.navigationController?.pushViewController(destinationView, animated: true)
    }
    
    
    //    header tableView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
//        sectionView.backgroundColor = UIColor(red: 175.0/255.0, green: 65.0/255.0, blue: 55.0/255.0, alpha: 0.30)
        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "backgroundSection")
        backgroundImage.frame = CGRect(x: 7, y: 6, width: 361, height: 25)
        sectionView.addSubview(backgroundImage)
        let titleSectionLabel = UILabel()
    if selectedSegment == 1 {
    titleSectionLabel.text = textArray1[section]
    } else {
    titleSectionLabel.text = textArray2[section]
    }
        sectionView.addSubview(titleSectionLabel)
        titleSectionLabel.frame = CGRect(x: 20, y: 1, width: 100, height: 35)
        titleSectionLabel.textColor = .white
        titleSectionLabel.font = UIFont.boldSystemFont(ofSize: 18)

        return sectionView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedSegment == 1 {
            return textArray1[section]
        } else {
            return textArray2[section]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }

}