//
//  SecondViewController.swift
//  Tipper
//
//  Created by Macbook Pro on 12/24/21.
//

import UIKit
import Combine

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    //Declaration/Connections to labels, buttons, segments, and pickerView
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var secondTopLabel: UILabel!
    @IBOutlet weak var secondBottomLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //Part of Singleton which allows us to use second view controller as chared instance
    static let sharedInstance = SecondViewController()
    
    //Variable to simplify userDefaults for later use
    let userDefaults = UserDefaults.standard
    
    //---------------------Declaration of default Variables----------------------
    
    //Default currency Name ( Saying that the default is a string)
    var currencyName : String!
    
    //default color for all themes (green)
    var theme = UIColor(red: 0/255, green: 235/255, blue: 192/255, alpha: 1.0)
    
    //Default color name
    var themeChanger = "Green"
    
    //Default currency symbol
    var currency = "$"
    
    //Default symbol for the currencyChanger
    var currencyChanger = "$"
    
    //---------------------------------------------------------------------------

    //Declaration of Theme Keys to use for user Defaults
    let THEME_KEY = "themeKey"
    let THEME_ONE = "themeOne"
    let THEME_TWO = "themeTwo"
    let THEME_THREE = "themeThree"
    let THEME_FOUR = "themeFour"
    
    //Array declartion which stores the titles of the pickerView
    let countries = ["United States Dollar","Canadian Dollar", "Chinese Yuan","Japanese Yen","Mexican Peso","European Euro", "British Pound"]
    
    //-------------------------------------------Currency Picker View Set UP-----------------------------------------------
    //Sets the number of components and row in the picker view, allows to set the titles in the array above to our picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return countries[row]
    }
    //----------------------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Setting dataSource and delegate for pickerView
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        //get the currencyName from user defalts
        currencyName = userDefaults.string(forKey: "symbol")
        
        //Selects the pickerview row according to currencySymbol
        switch currencyName
        {
                case "USD":
                    self.pickerView.selectRow(0, inComponent: 0, animated: true)
                case "CAD":
                    self.pickerView.selectRow(1, inComponent: 0, animated: true)
                case "CNY":
                    self.pickerView.selectRow(2, inComponent: 0, animated: true)
                case "JPY":
                    self.pickerView.selectRow(3, inComponent: 0, animated: true)
                case "MXN":
                    self.pickerView.selectRow(4, inComponent: 0, animated: true)
                case "EUR":
                    self.pickerView.selectRow(5, inComponent: 0, animated: true)
                case "GBP":
                    self.pickerView.selectRow(6, inComponent: 0, animated: true)
                default:
                    self.pickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        //Calls function to update theme after user selection as well as save to user Defaults
        updateTheme()
        
    }//end of viewDidLoad function
    
    //PickerView function to set(save) the selected row to user defaults and load the currency symbol
    //This function also sends the symbol and the name of the currency to the first view controller using a singleton
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        //Conditionals to save, get and send data of the currency name and symbol
        if(row == 0)
        {
            //United States
            userDefaults.set("USD", forKey: "symbol") // saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller ("USD")
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "$"

        }
        else if(row == 1)
        {
            //Canada
            userDefaults.set("CAD", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "$"
            
        }
        else if(row == 2)
        {
            //China
            userDefaults.set("CNY", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "¥"
            
        }
        else if(row == 3)
        {
            //Japan
            userDefaults.set("JPY", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "¥"
            
        }
        else if(row == 4)
        {
            //Mexico
            userDefaults.set("MXN", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "$"
            
        }
        else if(row == 5)
        {
            //Europe
            userDefaults.set("EUR", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "€"
            
        }
        else if(row == 6)
        {
            //British Pound
            userDefaults.set("GBP", forKey: "symbol") //saves
            userDefaults.synchronize()
            self.currencyName = userDefaults.string(forKey: "symbol") //gets
            
            //Sends currencyName to first view controller
            SecondViewController.sharedInstance.currencyChanger = currencyName
            //Sends the currency Symbol to the first view controller
            SecondViewController.sharedInstance.currency = "£"
            
        }
        
    } //end of function pickerview
    
    //Function to update the theme/color of the second view controller as well as send the color name back to the first view controller
    func updateTheme()
    {
        //get the theme name from user defaults ("THEME_ONE, THEME_TWO, OR THEME_THREE, ETC)
        let theme = userDefaults.string(forKey: THEME_KEY)
        
        //Conditional to determine which theme was selected
        if (theme == THEME_ONE)
        {
            //sets the selectedSegmentIndex to know which one was selected
            themeSegment.selectedSegmentIndex = 0
            
            //Sends the color to the first view controller (in this case "green")
            SecondViewController.sharedInstance.themeChanger = "green"
    
            //Sets the theme/color of the second view controller (sets background colors of top and bottom labels)
            secondTopLabel.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 192/255, alpha: 1.0)
            
            secondBottomLabel.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 192/255, alpha: 1.0)
        }
        else if (theme == THEME_TWO)
        {
            //sets the selectedSegmentIndex to know which one was selected
            themeSegment.selectedSegmentIndex = 1

            //Sends the color to the first view controller
            SecondViewController.sharedInstance.themeChanger = "blue"
            
            //Sets the theme/color of the second view controller (sets background colors of top and bottom labels)
            secondTopLabel.backgroundColor = UIColor(red:45/255, green: 133/255, blue: 199/255, alpha: 1.0)
            
            secondBottomLabel.backgroundColor = UIColor(red:45/255, green: 133/255, blue: 199/255, alpha: 1.0)
        }
        else if (theme == THEME_THREE)
        {
            //sets the selectedSegmentIndex to know which one was selected
            themeSegment.selectedSegmentIndex = 2
            
            //Sends the color to the first view controller
            SecondViewController.sharedInstance.themeChanger = "orange"
            
            //Sets the theme/color of the second view controller (sets background colors of top and bottom labels)
            secondTopLabel.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 68/255, alpha: 1.0)
            
            secondBottomLabel.backgroundColor = UIColor(red: 255/255, green: 138/255, blue: 68/255, alpha: 1.0)
        }
        else if (theme == THEME_FOUR)
        {
            //sets the selectedSegmentIndex to know which one was selected
            themeSegment.selectedSegmentIndex = 3

            //Sends the color to the first view controller
            SecondViewController.sharedInstance.themeChanger = "purple"
            
            //Sets the theme/color of the second view controller (sets background colors of top and bottom labels)
            secondTopLabel.backgroundColor = UIColor(red: 111/255, green: 108/255, blue: 185/255, alpha: 1.0)
            
            secondBottomLabel.backgroundColor =  UIColor(red: 111/255, green: 108/255, blue: 185/255, alpha: 1.0)
        }
                 
    }//end of updateTheme function

    //function to save the selected segment controller to user defaults
    @IBAction func themeSegment(_ sender: Any)
    {
        switch themeSegment.selectedSegmentIndex
        {
            case 0:
                userDefaults.set(THEME_ONE, forKey: THEME_KEY)

            case 1:
                userDefaults.set(THEME_TWO, forKey: THEME_KEY)
            
            case 2:
                userDefaults.set(THEME_THREE, forKey: THEME_KEY)
            
            case 3:
                userDefaults.set(THEME_FOUR, forKey: THEME_KEY)
            
            default:
                userDefaults.set(THEME_ONE, forKey: THEME_KEY)
                
        }
        updateTheme()
        
    } //end of themeSegment function
} //end of class


