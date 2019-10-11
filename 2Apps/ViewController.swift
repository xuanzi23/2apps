//
//  ViewController.swift
//  2Apps
//
//  Created by YAP HAO XUAN on 11/10/2019.
//  Copyright © 2019 YAP HAO XUAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentIndex : Int = 0
    
    var charArray = [String]()
    
    let backgroundColorArraay = [String]()
    
    let uppercaseLetters = (65...90).map {String(UnicodeScalar($0))}
    
    @IBAction func addFunc(_ sender: Any) {
        
        var visibleRect    = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size   = collectionView.bounds.size
        let visiblePoint   = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        print(visibleIndexPath.row)
        
        charArray.insert(uppercaseLetters.randomElement()!, at: visibleIndexPath.row + 1)
        
        let indexPath = IndexPath(row: visibleIndexPath.row + 1, section: 0)

        print(indexPath)
        
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < charArray.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    @IBAction func deleteFunc(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Test App"
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
        
        charArray.append(self.uppercaseLetters.randomElement()!)
        charArray.append(self.uppercaseLetters.randomElement()!)
        charArray.append(self.uppercaseLetters.randomElement()!)
        
    }
}

extension ViewController :  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return charArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        cell.webView.loadHTMLString("<center>\(self.charArray[indexPath.row])</center>", baseURL: nil)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width)
        let height = (self.view.frame.size.height)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

