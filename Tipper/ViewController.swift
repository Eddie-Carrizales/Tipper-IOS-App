//
//  ViewController.swift
//  Prework - Tipper
//
//  Created by Eddie Carrizales on 12/21/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    
    //Declaration/Connections to labels, buttons, segments, switches, and slider
    @IBOutlet weak var firstTopLabel: UILabel!
    @IBOutlet weak var firstBottomLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSliderLabel: UILabel!
    @IBOutlet weak var splitCheckSwitch: UISwitch!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var howManyPeopleTextField: UITextField!
    {
        //Added a done and cancel button to the number/decimal pad
        didSet { howManyPeopleTextField?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var billedAmountTextField: UITextField!
    {
        //Added a done and cancel button to the number/decimal pad
        didSet { billedAmountTextField?.addDoneCancelToolbar() }
    }
    
    //---------------------Declaration of default Variables----------------------
    
    //Variable to simplify userDefaults for later use
    let userDefaults = UserDefaults.standard
    
    //Default currency symbol ( Saying that the default is a string)
    var currencySymbol = String()
    
    //Default currency Name
    var currencyName = String()
    
    //Defailt currencySymbolChange
    var currencySymbolChange = String()
    
    //Default color Name
    var colorName = String()
    
    //Default hex string (default is green)
    var hexString = "#00EBC0"
    
    //---------------------------------------------------------------------------
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Setting both as delegates to allow use of the decimal pad/keyboard on these fields
        billedAmountTextField.delegate = self
        howManyPeopleTextField.delegate = self
        
        //Setting the keyboard type as decimal pad for both text fields
        billedAmountTextField.keyboardType = .decimalPad
        howManyPeopleTextField.keyboardType = .decimalPad
        
        //-------------------Data pass from second view controller using singleton-------------------
        
        //Used singleton to pass the theme/color chosen by the user in the second view controller
        self.colorName = SecondViewController.sharedInstance.themeChanger
        
        //Used singletons to pass the currencySymbol and the currency Name chosen by the user in the second view controller
        self.currencySymbol = SecondViewController.sharedInstance.currency
        self.currencyName = SecondViewController.sharedInstance.currencyChanger
        
        //-------------------------------------------------------------------------------------------
        
        //Conditional statements to determine the currency name passed, set the currency symbol, and save to user defaults
        if (currencyName == "USD" || currencyName == "CAD" || currencyName == "MXN")
        {
            //Setting currency Symbol and saving it to the user defaults
            currencySymbolChange = "$"
            UserDefaults.standard.setCurrency(value: currencySymbolChange)
        }
        else if (currencyName == "CNY" || currencyName == "JPY")
        {
            //Setting currency Symbol and saving it to the user defaults
            currencySymbolChange = "¥"
            UserDefaults.standard.setCurrency(value: currencySymbolChange)
        }
        else if(currencyName == "EUR")
        {
            //Setting currency Symbol and saving it to the user defaults
            currencySymbolChange = "€"
            UserDefaults.standard.setCurrency(value: currencySymbolChange)
        }
        else if(currencyName == "GBP")
        {
            //Setting currency Symbol and saving it to the user defaults
            currencySymbolChange = "£"
            UserDefaults.standard.setCurrency(value: currencySymbolChange)
        }
        
        //-------------------------------------------------------------------------------------------
        
        //Conditional statements to determine the color name passed, set the color hex string, and save the hex string to user defaults
        if (colorName == "green" )
        {
            //Setting hexstring color and saving it to the user defaults
            hexString = "#00EBC0FF"
            UserDefaults.standard.setTheme(value: hexString)
            
        }
        else if (colorName == "blue")
        {
            //Setting hexstring color and saving it to the user defaults
            hexString = "#2D85C7FF"
            UserDefaults.standard.setTheme(value: hexString)
        }
        else if(colorName == "orange")
        {
            //Setting hexstring color and saving it to the user defaults
            hexString = "#FF8A44FF"
            UserDefaults.standard.setTheme(value: hexString)
        }
        else if(colorName == "purple")
        {
            //Setting hexstring color and saving it to the user defaults
            hexString = "#6F6CB9FF"
            UserDefaults.standard.setTheme(value: hexString)
        }

        //Debug print statements
        //print("hexString is:" + hexString)
        //print("firstTopLabel get:" + UserDefaults.standard.getTheme())
        
        //-------------------------------------------------------------------------------------------
        
        //Getting the color saved in user defaults and setting the top and bottom label backgrounds to that color
        firstTopLabel.backgroundColor = UIColor(hex: UserDefaults.standard.getTheme())
        firstBottomLabel.backgroundColor = UIColor(hex: UserDefaults.standard.getTheme())
        
        /*
        In the app in the main view, we see $0.00. I set this string in attributes. However, this attributes string
        can technically just be empty and the code below will still make it show $0.00 at runtime because it will get
        replaced. The reason, I am still leaving this string in attributes is to help visualize in the main view what
        the app will look like as well as see how constrains will fit together.
        */
        //Sets the tip amount back to zero when not in use
        tipAmountLabel.text = String(format: "\(UserDefaults.standard.getCurrency())0.00")
        //Sets total amount back to zero when not in use
        totalLabel.text = String(format: "\(UserDefaults.standard.getCurrency())0.00")
        //Sets the total amount per person back to zero when not in use
        totalPerPersonLabel.text = String(format: "\(UserDefaults.standard.getCurrency())0.00")

    } //end of viewDidLoad function
    
    
    //Function to calculate the tip amount, the total amount with tip included an the total per person
    @IBAction func calculateTip(_ sender: Any)
    {
        //Variable Declarations
        
        //Sets the segment controller tips to 0 (which is the slider), 15%, 18%, and 20%
        let tipPercentages = [0, 15, 18, 20]
        let segmentTip = tipPercentages[tipSegment.selectedSegmentIndex]
        
        //Gets the bill amount from the textfield input
        let bill = Double(billedAmountTextField.text!) ?? 0
        
        //The number of people we want to split the bill with (using int since there cannot be half a person).
        let numPeople = Int(howManyPeopleTextField.text!) ?? 0
        
        //casts the slider value to an integer and stores it in sliderValue
        var sliderValue = Int(tipSlider.value)
        
        //Conditional statement to automatically move the slider to the segment controller tip using an animation
        if (segmentTip == 15)
        {
            sliderValue = 15
            tipSlider.setValue(15, animated:true)
        }
        else if (segmentTip == 18)
        {
            sliderValue = 18
            tipSlider.setValue(18, animated:true)
        }
        else if (segmentTip == 20)
        {
            sliderValue = 20
            tipSlider.setValue(20, animated:true)
        }
        
        //Conditional statement to set the segment controller to 0 (which means "Slider") when the slider is touched
        if (tipSlider.isTouchInside)
        {
            //make segment move back to slider when the slider is clicked
            tipSegment.selectedSegmentIndex = 0
        }
        
        //----------------Calculations--------------------
        
        //Calculates tip
        let tip = bill * (Double(sliderValue)/100)

        //Calculates total
        let total = bill + Double(tip)
        
        //Calculate how much each person will pay (Casting to double so we can divide since total bill could be a decimal)
        let perPerson = total/Double(numPeople)
        
        //Changed the format for the tip, total, and total per person to allow thousands separators
        let tipFormated = tip.formattedWithSeparator
        let totalFormated = total.formattedWithSeparator
        let perPersonFormated = perPerson.formattedWithSeparator
        
        //Debug/test print statements
        //print("tip:$%.2f" ,tip)
        //print("tipFormated:%d" , tipFormated)

        //Updates the tip amount label as the slider is moved or the segment controller is selected
        tipAmountLabel.text = String(format: "\(UserDefaults.standard.getCurrency())" + tipFormated)
            
        //Update the slider percentage amount as the slider is moved or the segment controller is selected
        tipSliderLabel.text = String(format: "%d%%", sliderValue)
        
        //--------------Conditional Statment to allow for a calculate button and split check switch------------------
        
        //Updates the amount when the calculate button is clicked
        if(calculateButton.isTouchInside)
        {
            //Update total amount
            totalLabel.text = String(format: "\(UserDefaults.standard.getCurrency())" + totalFormated)
        }
        else
        {
            //Total amount back to zero
            totalLabel.text = String(format: "\(UserDefaults.standard.getCurrency())0.00")
        }
        
        //If the switch for split check is on but the text field for the number of people is empty or 0, then the total per peson amount is not updated
        //Also, if the text field is not empty, but the switch is not on, the total per person amount is not updated
        if(splitCheckSwitch.isOn && (howManyPeopleTextField.text != "") && (howManyPeopleTextField.text != "0") && calculateButton.isTouchInside)
        {

            //Update the total per person label
            totalPerPersonLabel.text = String(format: "\(UserDefaults.standard.getCurrency())" + perPersonFormated)
            
        }
        else
        {
            //Total per person back to zero
            totalPerPersonLabel.text = String(format: "\(UserDefaults.standard.getCurrency())0.00")
            
        }
        //-----------------------------------------------------------------------------------------------------------
        
    }// end of function calculateTip
    
} //end of class ViewController

//Extension to dismiss the keyboard when return is pressed (might not be used anymore due to keyboard to decimal pad change)
extension ViewController: UITextViewDelegate
{
    func textField1(_ billedAmountTextField: UITextField) -> Bool
    {
        billedAmountTextField.resignFirstResponder() //dismiss keyboard
        return true
    }
    
    func textField2(_ howManyPeopleTextField: UITextField) -> Bool
    {
        howManyPeopleTextField.resignFirstResponder() //dismiss keyboard
        return true
    }
} //end of ViewController extension

//Extension to add a done and cancel button on top of the decimal pad
extension UITextField
{
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil)
    {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
                            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
                            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
                        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
} // end of UITextField extension

//Extension to allow for easier User defualt setting and getting
extension UserDefaults
{
    //Setting(saving) and getting(retreiving) for the currency name that was passed
    func setCurrency(value: String)
    {
        set(value, forKey: UserDefaultKeys.currencyType.rawValue)
    }
    func getCurrency() -> String
    {
        return string(forKey: UserDefaultKeys.currencyType.rawValue) ?? "$"
    }
    
    //Setting(saving) and getting(retreiving) for the theme/color name that was passed
    func setTheme(value:String)
    {
        set(value, forKey: UserDefaultKeys.themeType.rawValue)
    }
    
    func getTheme() -> String
    {
        return string(forKey: UserDefaultKeys.themeType.rawValue) ?? "blue"
    }
    
    //userDefault Keys
    enum UserDefaultKeys : String
    {
        case currencyType
        case themeType
    }
    
} //end of UserDefaults extension

//UIColor extension to convert an 8 digit hex string to UIcolor
extension UIColor
{
    public convenience init?(hex: String)
    {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#")
        {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8
            {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber)
                {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
} //end of UIColor extension

//----------Both Extensions used to format numbers and add a thousands separator-----
extension Formatter
{
    static let withSeparator: NumberFormatter =
    {
        let formatter = NumberFormatter()
        
        // used to prevent rounding
        formatter.roundingMode = .down
        
        //sets the fraction digits to 2
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        //sets the number style to decima.
        formatter.numberStyle = .decimal
        
        //Sets the separator to a comma
        formatter.groupingSeparator = ","
        return formatter
    }()
}//end of formatter extension

extension Numeric
{
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}//end of numeric extension

//------------------------------------------------------------------------------------
