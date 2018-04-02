//
//  DetailViewController.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 01/04/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    static let ListData = ["O3 Sub Index", "O3 8 Hours", "PM10 Sub Index", "PM10 24 Hours", "CO Sub Index", "CO 8 Hours", "SO2 Sub Index", "SO2 24 Hours", "PM25 Sub Index", "PM25 24 Hours", "NO2 1 Hour", "PSI 24 Hours"] as [String]
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRegion: Region!{
        didSet{
//            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailViewController.ListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.titleLabel.text = DetailViewController.ListData[indexPath.row]
        var str: String = ""
        switch indexPath.row {
        case 0:
            str = String(self.selectedRegion.o3SubIndex)
            break
        case 1:
            str = String(self.selectedRegion.o3Eight)
            break
        case 2:
            str = String(self.selectedRegion.pm10SubIndex)
            break
        case 3:
            str = String(self.selectedRegion.pm10TwentyFour)
            break
        case 4:
            str = String(self.selectedRegion.coSubIndex)
            break
        case 5:
            str = String(self.selectedRegion.coEight)
            break
        case 6:
            str = String(self.selectedRegion.so2SubIndex)
            break
        case 7:
            str = String(self.selectedRegion.so2TwentyFour)
            break
        case 8:
            str = String(self.selectedRegion.pm25SubIndex)
            break
        case 9:
            str = String(self.selectedRegion.pm25TwentyFour)
            break
        case 10:
            str = String(self.selectedRegion.no2One)
            break
        case 11:
            str = String(self.selectedRegion.psiTwentyFour)
            break
        default:
            break
        }
        cell.detailLabel.text = str
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate{
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width/2 - 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

class DetailCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorderToEdge(edge: .all, color: UIColor.black, height: 1.0)
    }
}
