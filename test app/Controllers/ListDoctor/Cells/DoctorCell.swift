//
//  DoctorCell.swift
//  test app
//
//  Created by iosnuk on 29.05.2018.
//  Copyright © 2018 PlatinumKiller. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DoctorCell: UITableViewCell {
    
    static let imageCache = AutoPurgingImageCache()
    var docData:DoctorInfo?
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photo.layer.cornerRadius = 5.0
        photo.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setData(data:DoctorInfo){
        docData = data
        name.text = data.Name
        rating.text = data.RatingLabel
        
        if let img = DoctorCell.imageCache.image(withIdentifier: (docData?.Img)!) {
            self.photo.image = img
        } else {
            
            Alamofire.request(data.Img).responseImage {[weak self, data]  response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    DoctorCell.imageCache.add(image, withIdentifier: data.Img)
                    if data.Img.compare((self?.docData?.Img)!) == ComparisonResult.orderedSame {
                        self?.photo.image = image
                    }
                }
            }
        }
    }
}
