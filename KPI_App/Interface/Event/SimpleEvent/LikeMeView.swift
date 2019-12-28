//
//  LikeMeView.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import UIKit

class LikeMeView: UIView {
    
    var Like: Bool = false
    var heartView = UIImageView()
    let shapeLayer = CAShapeLayer()
    let pulsingLayer = CAShapeLayer()
    
    var stars = [Star]()
    
    struct Star{
        var x : Double
        var y : Double
        
        var animated_x : Double
        var animated_y : Double
        var starView : UIImageView
        
        var width : Double
        var height : Double
    }
    
    //    func setupView(byParts: Int, radius: Int, animatedRadius: Int, viewWidth: Int, viewHeight: Int){
    //
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let heartSize = frame.height - frame.height/5 // - 20%
        let starSize = frame.height/4
        
        //cirleView.frame = CGRect(x: view.center.x - 10, y: view.center.y - 10, width: 20, height: 20)
        stars = configureStars(byParts: 6, radius: Double(heartSize/1.66), animatedRadius: Double(frame.height), viewWidth: Double(starSize), viewHeight: Double(starSize))
        //cirleView.backgroundColor = .blue
        heartView = UIImageView(frame: CGRect(x: self.center.x - heartSize/2, y: self.center.y - heartSize/2, width: heartSize, height: heartSize))
        
        //view.addSubview(cirleView)
        
        
        heartView.image = UIImage(named: "Love_Heart_SVG")
        heartView.contentMode = .scaleAspectFit
        
        //print()
        let path = UIBezierPath(arcCenter: .zero, radius: frame.height/1.42, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsingLayer.fillColor = UIColor.clear.cgColor
        pulsingLayer.path = path.cgPath
        pulsingLayer.lineWidth = (frame.height)*0.06
        pulsingLayer.strokeColor = UIColor.clear.cgColor
        pulsingLayer.position = self.center
        self.layer.addSublayer(pulsingLayer)
        
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = (frame.height)*0.06
        
        shapeLayer.position = self.center
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateHeart)))
        self.layer.addSublayer(shapeLayer)
        
        self.addSubview(heartView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func animateHeart(){
        
        if(!Like){
            
            
            pulsingLayer.fillColor = UIColor.red.cgColor
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            shapeLayer.fillColor = UIColor.white.cgColor
            
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.toValue = 1.2
            animation.duration = 0.8
            animation.autoreverses = true
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.repeatCount = 1
            
            heartView.layer.add(animation, forKey: "pulsingfv")
            pulsingLayer.add(animation, forKey: "pulsingfv1")
            
            
            for  i in 0...stars.count - 1{
                self.stars[i].starView.alpha = 1
                UIView.animate(withDuration: 0.5, animations:{
                    //self.cirleView.center.x = 350
                    //self.cirleView.center.y = 200
                    self.stars[i].starView.alpha = 1
                    
                    self.stars[i].starView.frame = CGRect(x: self.stars[i].x, y: self.stars[i].y, width: self.stars[i].width, height: self.stars[i].height)
                    self.stars[i].starView.center.x = CGFloat(self.stars[i].animated_x)
                    self.stars[i].starView.center.y = CGFloat(self.stars[i].animated_y)
                    
                    
                }
                    , completion: { _ in
                        // print("FINISHED")
                        
                        UIView.animate(withDuration: 0.5,
                                       animations: {
                                        self.stars[i].starView.frame = CGRect(x: self.stars[i].animated_x, y: self.stars[i].animated_y, width: 0, height: 0)
                                        self.stars[i].starView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                                        //self.stars[i].starView.alpha = 0
                                        
                        })
                        
                        //                    UIView.animate(withDuration: 1, animations: { () -> Void in
                        //
                        //                        //self.stars[i].starView.alpha = 0
                        ////                        self.stars[i].starView.frame = CGRect(x: self.stars[i].animated_x, y: self.stars[i].animated_y, width: 0, height: 0)
                        //
                        //
                        //
                        //
                        //                    })
                })
            }
            
        }
        else{
            pulsingLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = UIColor.clear.cgColor
            
            self.heartView.layer.removeAllAnimations()
            self.pulsingLayer.removeAllAnimations()
            self.layer.removeAllAnimations()
            self.layoutIfNeeded()
            
            //            self.cirleView.center.x = view.center.x
            //            self.cirleView.center.y = view.center.y
            for  i in 0...stars.count - 1{
                //                self.stars[i].starView.center.x = CGFloat(self.stars[i].x)
                //                self.stars[i].starView.center.y = CGFloat(self.stars[i].y)
                self.stars[i].starView.frame = CGRect(x: self.stars[i].x, y: self.stars[i].y, width: 0, height: 0)
                
                
            }
        }
        
        Like = !Like
        
    }
    
    func calculateCoordinates(byParts: Int, radius: Double)-> [(Double, Double)]{
        
        let devidedAngle = Double(360/byParts)
        var coordinates = [(Double, Double)]()
        for i in 0...byParts - 1{
            let angle = Double(i) * devidedAngle;
            let x = Double(self.center.x) + radius * cos(angle);
            let y = Double(self.center.y) + radius * sin(angle);
            coordinates.append((x, y))
        }
        //print(coordinates)
        return coordinates
    }
    
    func configureStars(byParts: Int, radius: Double, animatedRadius: Double, viewWidth: Double, viewHeight: Double) -> [Star]{
        
        
        var coordinates = [Star]()
        
        var startCoordinates = calculateCoordinates(byParts: byParts, radius: radius)
        var animatedCoordinates = calculateCoordinates(byParts: byParts, radius: animatedRadius)
        
        for i in 0...byParts - 1{
            let starView = UIImageView(frame: CGRect(x: startCoordinates[i].0 - viewWidth/3, y: startCoordinates[i].1 - viewWidth/3, width: viewWidth, height: viewHeight))
            starView.image = UIImage(named: "star")
            starView.backgroundColor = .clear
            starView.contentMode = .scaleAspectFit
            self.addSubview(starView)
            coordinates.append(Star(x: startCoordinates[i].0, y: startCoordinates[i].1,animated_x: animatedCoordinates[i].0, animated_y: animatedCoordinates[i].1, starView: starView, width: viewWidth, height: viewHeight))
        }
        
        return coordinates
        
    }
    
    /*
     
     опредиляем координаты звезд
     
     при нажатии likeButton - создаем звезды в 1м положении c с low приоритетом -> animate передвижения до 2й позиции -> transform до 0.01 -> completion REMOVE STARS FROM SUPERVIEW
     
     */
    
    
    /*
     
     func configureStars (byParts: Int, starRadiusesCount: Int,  coordinates : [Coordinate] или [[Double, Double]], innout srats: [Stars]) и его же возворащаем {
     
     if(coordinates.count < starRadiusesCount)
     for i in 0...byParts - 1{
     let angle = Double(i) * devidedAngle;
     let x = Double(self.center.x) + radius * cos(angle);
     let y = Double(self.center.y) + radius * sin(angle);
     coordinates.append((x, y))
     configureStars(......)
     
     }
     
     забираем с coodrinayes координаты звезд -> добавляем в stars
     или возвр coordinates и дальше добавляем в stars
     
     */
    
    
}

