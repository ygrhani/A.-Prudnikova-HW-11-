//
//  FillInfVC.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 1.11.22.
//

import UIKit

class FillInfVC: UIViewController {
    
    @IBOutlet weak var positionSettingButton: UIButton!
    @IBOutlet weak var buttForAddSt: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var stNameField: UITextField!
    @IBOutlet weak var stLastNameField: UITextField!
    @IBOutlet weak var stAgeField: UITextField!
    @IBOutlet weak var emailStField: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    var personalInf = Student(nameSt: "", lastName: "", ageSt: 0, emailSt: "", coordinatesSt: "")
    var closureInfStudent: ((Student) -> Bool)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stNameField.placeholder = "First Name"
        stLastNameField.placeholder = "Last Name"
        stAgeField.placeholder = "Age"
        emailStField.placeholder = "Email"
        
        buttForAddSt.setTitle("Enrol the student", for: .normal)
        positionSettingButton.setTitle("Set your coordinates", for: .normal)
        exitButton.setTitle("Complete registration", for: .normal)
       
        
        
        buttForAddSt.setGradient(button: buttForAddSt)
        positionSettingButton.setGradient(button: positionSettingButton)
        exitButton.setGradient(button: exitButton)
        stNameField.setShades(textField: stNameField)
        stLastNameField.setShades(textField: stLastNameField)
        stAgeField.setShades(textField: stAgeField)
        emailStField.setShades(textField: emailStField)
        
       exitButton.isEnabled = false
       
    }
    @IBAction func setPosition(_ sender: Any) {
        guard let coordinatesVC = storyboard?.instantiateViewController(withIdentifier: "UserCoordinatesVC") as? UserCoordinatesVC else {return}
        
        coordinatesVC.setCoordinates = { [self] latitude, longitude in
            latitudeLabel.text = String(latitude)
            longitudeLabel.text = String(longitude)
            let location = ("\(latitude); \(longitude)")
            personalInf.coordinatesSt = location
        }
        
        coordinatesVC.modalPresentationStyle = .overFullScreen
        present(coordinatesVC, animated: true)
    }
    
    @IBAction func closeTheFillInForm(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sendInf(_ sender: Any) {
        
        if let number = stAgeField.text,
           let name = stNameField.text,
           let lastName = stLastNameField.text,
           let email = emailStField.text,
           let latitude = latitudeLabel.text,
           let longitude = longitudeLabel.text,
           let age = Int(number),
           let locationLatitude = Double(latitude),
           let locationLongitude = Double(longitude) {
            if age >= 18 && age <= 90 && name != "" && lastName != "" && email != "" && locationLatitude != 0.0 && locationLongitude != 0.0 && (closureInfStudent != nil) == true {
                
                personalInf = Student(nameSt: name, lastName: lastName, ageSt: age, emailSt: email, coordinatesSt: personalInf.coordinatesSt)
                
                closureInfStudent?(personalInf)
              
                
                
                view.addBlur()
                let congratsAlert = UIAlertController(title: "Congrats!", message: "You were successfully added to the course.A manager will contact you shortly.", preferredStyle: .alert)
               let okButton = UIAlertAction(title: "OK", style: .cancel) {_ in
                    self.exitButton.isEnabled = true
                    self.stNameField.isEnabled = false
                    self.stLastNameField.isEnabled = false
                    self.stAgeField.isEnabled = false
                    self.emailStField.isEnabled = false
                    self.buttForAddSt.isEnabled = false
                    self.positionSettingButton.isEnabled = false
                    self.view.removeBlur()
                }
                present(congratsAlert, animated: true)
                congratsAlert.addAction(okButton)
                
            } else {
                stAgeField.placeholder = "Please enter your age"
                stNameField.placeholder = "Please enter your name"
                stLastNameField.placeholder = "Please enter your last name"
                emailStField.placeholder = "Please enter your email"
                if age > 18 && age < 90 {
                    stAgeField.text?.removeAll()
                    stAgeField.placeholder = "Registration is available on reaching the age of majority"
                }
            }
        }
    }
}


