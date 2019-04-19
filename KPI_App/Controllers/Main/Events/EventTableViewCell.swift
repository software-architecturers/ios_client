//
//  EventTableViewCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 2/14/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var userImg1: UIImageView!
    @IBOutlet weak var userImg2: UIImageView!
    @IBOutlet weak var userImg3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventImage.layer.cornerRadius = 8.0
        eventImage.clipsToBounds = true
        
        likeButton.setImage(UIImage(named: "customLike"), for: .normal)
        setCircleImg(image: userImg1,imgName: "dexter")
        setCircleImg(image: userImg2,imgName: "house")
        setCircleImg(image: userImg3,imgName: "hanibal")
        // Initialization code
    }

    @IBAction func didSelectLikeButton(_ sender: Any) {
        
        if (likeButton.imageView?.image == UIImage(named: "customLike")) {
            //set default
            likeButton.setImage(UIImage(named: "customNonlike"), for: .normal)
        } else{
            // set like
            likeButton.setImage(UIImage(named: "customLike"), for: .normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureEvent(event: Events){
        
//        eventImage.image = event.image
//        eventTitle.text = event.title
        
    }
    
//    func configureEventCell (event : EventProtocol){
//        
//        if event.returnTypeOfEvent() == "SimpleEvent" {
//            
//            let simpleEvent = event as! SimpleEvent
//            eventTitle.text = simpleEvent.eventName
//            if let eventImg = simpleEvent.image {
//                eventImage.image = eventImg
//            }
//        }
//    }
    
    func setCircleImg(image: UIImageView, imgName: String){
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.image = UIImage(named: imgName)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }

}
