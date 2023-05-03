//
//  ListOfStudentTableViewCell.swift
//  A. Prudnikova (HW 11)
//
//  Created by Ann Prudnikova on 23.11.22.
//

import UIKit

class ListOfStudentTableViewCell: UITableViewCell {
        
    @IBOutlet weak var fullNameStLbl: UILabel!
    @IBOutlet weak var ageSt: UILabel!
    @IBOutlet weak var positionSt: UILabel!
    @IBOutlet weak var emailSt: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
  public  func refresh(_ student: Student) {
      fullNameStLbl.text = "Full name of the Student:\n\(student.nameSt) \(student.lastName)"
        ageSt.text = "Age: \(student.ageSt)"
        emailSt.text = "E-mail: \(student.emailSt)"
        positionSt.text = "City:\n\(student.coordinatesSt)"
    }
}
