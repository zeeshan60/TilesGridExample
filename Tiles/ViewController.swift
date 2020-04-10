//
//  ViewController.swift
//  Tiles
//
//  Created by Zeeshan Tufail on 10/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: AlignedCollectionViewFlowLayout!
    
    var data : [Tile] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.loadingIndicator.hidesWhenStopped = true
        self.flowLayout.horizontalAlignment = .left
        self.loadingIndicator.startAnimating()
        TileService.service.getPriorityOrderedTiles { (optionalTiles, optionalError) in
            self.loadingIndicator.stopAnimating()
            
            guard let tiles = optionalTiles else {
                return
            }
            
            self.data = tiles
            
            self.collectionView.reloadData()
        }
    }

    //UICollectionView Delegate and Datasources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TileCell", for: indexPath) as! TileCell;
        cell.reloadData(tile: self.data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        TileService.service.submitTileSelection(id: self.data[indexPath.row].Id) { (optionalResponse: SubmitTileResponseModel?, error: Error?) in
            guard let response = optionalResponse else {
                let controller = UIAlertController(title: "Error", message: "Something Wrong. Ooops", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    controller.dismiss(animated: true, completion: nil)
                }))
                self.show(controller, sender: nil)
                return
            }
            let controller = UIAlertController(title: "Tile Tap", message: response.message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                controller.dismiss(animated: true, completion: nil)
            }))
            self.show(controller, sender: nil)
        }
    }
}

