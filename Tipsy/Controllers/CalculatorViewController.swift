import UIKit

class CalculatorViewController: UIViewController {

    var pct = 1.1
    var pctText = "10%"
    var stepper = 2
    var billTotal = 0.0
    var resultTo2DecimalPlaces = " "
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tecPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        pctText = sender.currentTitle!
        
        if pctText == "0%"{
            pct = 1.0
            zeroPctButton.isSelected = true
            tecPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }else if pctText == "10%"{
            pct = 1.1
            tecPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }else {
            pct = 1.2
            twentyPctButton.isSelected = true
            tecPctButton.isSelected = false
            zeroPctButton.isSelected = false
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepper = Int(sender.value)
        splitNumberLabel.text = String(stepper)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
                    billTotal = Double(bill)!
                    
                    let result = billTotal * pct / Double(stepper)
                    
                    resultTo2DecimalPlaces = String(format: "%.2f", result)
            
                }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destVC = segue.destination as! ResultsViewController
            
            destVC.bill = resultTo2DecimalPlaces
            destVC.settings = "Split between \(stepper) people, with \(pctText) tip."
//            destVC.bmiValue = calbBrain.getBMIValue()
//            destVC.advice = calbBrain.getAdvice()
//            destVC.color = calbBrain.getColor()
        }
    }
}

