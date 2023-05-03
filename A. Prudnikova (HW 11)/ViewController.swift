//
//  ViewController.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 1.11.22.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let tabelViewController = UITableViewController(style: .plain)
    var cellID = "ListOfStudentTableViewCell"
    
    @IBOutlet weak var stackInformSt: UIStackView!
    @IBOutlet weak var listOfEnrolledButton: UIButton!
    @IBOutlet weak var labNumberOfPlacesAvailable: UILabel!
    @IBOutlet weak var labEnrolledStudents: UILabel!
    @IBOutlet weak var buttIndRegisterSt: UIButton!
    var setInf = Course(numberOfPlaces: 14, numberOfStudents: 0, enrolledStudents: [])
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labNumberOfPlacesAvailable.textColor = .white
        labEnrolledStudents.textColor = .white
        
        stackInformSt.backgroundColor = .systemPink
        stackInformSt.layer.cornerRadius = 25
        stackInformSt.alpha = 0.85
        stackInformSt.layer.borderColor = UIColor.black.cgColor
        stackInformSt.layer.borderWidth = 1
        
        
        playBackgroundGif()
        labNumberOfPlacesAvailable.text = ("Колличество свободных мест: \(setInf.numberOfPlaces)")
        
        buttIndRegisterSt.setTitle("Register a student", for: .normal)
        buttIndRegisterSt.setGradient(button: buttIndRegisterSt)
        listOfEnrolledButton.setGradient(button: listOfEnrolledButton)
        listOfEnrolledButton.setTitle("List Of Enrolled Students", for: .normal)
        listOfEnrolledButton.setTitleColor(.white, for: .normal)
        
    }
    
    
    @IBAction func registerStudent(_ sender: Any)  {
        
        
        guard let fillInf = storyboard?.instantiateViewController(withIdentifier: "FillInfVC") as? FillInfVC else {return}
        
        fillInf.closureInfStudent = { student in
            self.labEnrolledStudents.text = ("Последений зачисленный студент: \n\(student.nameSt) \(student.lastName); \(student.ageSt) года(лет). \nПочта: \(student.emailSt) \nАдресс студента: \(student.coordinatesSt)")
            
            if (fillInf.closureInfStudent != nil) == true {
                self.setInf.enrolledStudents.append(student)
            }
            
            let students =  self.setInf.enrolledStudents
            let isAvailable = students.contains { student in
                if students.contains(student) {
                    return false
                } else {
                    return true
                }
            }
            
            self.setInf.numberOfStudents = self.setInf.enrolledStudents.count
            
            var numberOfEnrolledSt: Int {
                get {
                    return self.setInf.numberOfPlaces - self.setInf.numberOfStudents
                }
            }
            
            self.labNumberOfPlacesAvailable.text = ("Колличество свободных мест: \(numberOfEnrolledSt)")
            
            self.buttIndRegisterSt.isEnabled = numberOfEnrolledSt <= 0 ? false : true
            return isAvailable
        }
        
        
        fillInf.modalPresentationStyle = .overFullScreen
        present(fillInf, animated: true)
    }
    
    
    @IBAction func openTheListOfEnrlSt(_ sender: Any) {
        
        guard let cellVC = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else {return}
        
        cellVC.students = setInf.enrolledStudents
        present(cellVC, animated: true)
        
    }
    
    func playBackgroundGif() {
        let path = Bundle.main.path(forResource: "circleBack", ofType: ".mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        player?.seek(to: CMTime.zero)
        player?.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        player?.seek(to: CMTime.zero)
    }
}
    
    
    extension Student: Equatable {
        static func  == (lhs: Student, rhs: Student) -> Bool {
            return lhs.coordinatesSt == rhs.coordinatesSt &&
            lhs.emailSt == rhs.emailSt &&
            lhs.nameSt == rhs.nameSt
        }
    }
    
