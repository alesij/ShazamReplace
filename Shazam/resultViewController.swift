//
//  resultViewController.swift
//  Shazam
//
//  Created by Alessio Di Matteo on 13/12/2019.
//  Copyright © 2019 Alessio Di Matteo. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var xButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor.setGradientBackground(colorTop: .black, colorBottom: .darkGray)

        switch Session.sharedInstance.detectedSong {
        case "Agnes Obel - Familiar":
            self.artistLabel.text = "Agnes Obel"
            self.resultImage.image = UIImage(named: "Familiar")
            self.songLabel.text = "Familiar"
        case "Billie Eilish - bad guy":
            self.artistLabel.text = "Billie Eilish"
            self.resultImage.image = UIImage(named: "Bad Guy")
            self.songLabel.text = "Bad guy"
        case "Corona - The Rhythm Of The Night":
            self.artistLabel.text = "Corona"
            self.resultImage.image = UIImage(named: "Corona")
            self.songLabel.text = "The rhythm of the night"
        case "Elodie & Marracash - Margarita":
            self.artistLabel.text = "Elodie & Marracash"
            self.resultImage.image = UIImage(named: "Margarita")
            self.songLabel.text = "Margarita"
        case "Imagine Dragons - Radioactive":
            self.artistLabel.text = "Imagine Dragons"
            self.resultImage.image = UIImage(named: "Radioactive")
            self.songLabel.text = "Radioactive"
        case "Jess Glynne - I'll Be There":
            self.artistLabel.text = "Jess Glynne"
            self.resultImage.image = UIImage(named: "Jess")
            self.songLabel.text = "I'll Be There"
        case "Lana Del Rey - Doin' Time":
            self.artistLabel.text = "Lana Del Rey"
            self.resultImage.image = UIImage(named: "Lana")
            self.songLabel.text = "Doin' Time"
        case "Mabel - Don't Call Me Up":
            self.artistLabel.text = "Mabel"
            self.resultImage.image = UIImage(named: "Mabel")
            self.songLabel.text = "Don't Call Me Up"
        case "Mark Ronson - Late Night Feelings":
            self.artistLabel.text = "Mark Ronson"
            self.resultImage.image = UIImage(named: "Ronson")
            self.songLabel.text = "Late Night Feelings"
        case "Post Malone - Circles":
            self.artistLabel.text = "Post Malone"
            self.resultImage.image = UIImage(named: "Circles")
            self.songLabel.text = "Circles"
        case "Shawn Mendes & Camila Cabello - Señorita":
            self.artistLabel.text = "Shawn Mendes & Camila Cabello"
            self.resultImage.image = UIImage(named: "Senorita")
            self.songLabel.text = "Señorita"
        case "Steve Aoki - Are You Lonely":
            self.artistLabel.text = "Steve Aoki"
            self.resultImage.image = UIImage(named: "Steve Aoki")
            self.songLabel.text = "Are You Lonely"
        case "Takagi & Ketra - Amore e Capoeira (feat. Giusy Ferreri)":
            self.artistLabel.text = "Takagi & Ketra feat. Giusy Ferreri"
            self.resultImage.image = UIImage(named: "Amore Capoeira")
            self.songLabel.text = "Amore e Capoeira"
        case "Tove Lo - Sweettalk my Heart":
            self.artistLabel.text = "Tove Lo"
            self.resultImage.image = UIImage(named: "Tove Lo")
            self.songLabel.text = "Sweettalk my Heart"
        case "twenty one pilots - My Blood":
            self.artistLabel.text = "Twenty One Pilots"
            self.resultImage.image = UIImage(named: "Twenty one pilots")
            self.songLabel.text = "My Blood"
            
        default:
            self.view.backgroundColor = UIColor.white
            self.artistLabel.text = " "
            self.resultImage.image = UIImage(named:"nessun risultato")
            self.songLabel.text = " "
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
