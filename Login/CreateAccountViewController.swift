

import UIKit
import Firebase
class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    // Hide error label
    
    func setUpElements(){
        errorLabel.alpha = 0
        
    }
    
    // Check that all fields are filled in
    func validateFields()->String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            
        {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    @IBAction func signupClicked(_ sender: UIButton) {
        // Validate the fields
        let error = validateFields()
        if error != nil{
            // there was an error
            showError(error!)
        
        }
        else{
            //create user
            
            // Prevent craeting two accounts with the same email
            guard let email = emailTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            
            Auth.auth().createUser(withEmail: email, password: password){(result,err) in
                // Check for errors
                if  err != nil {
                    //there was an error
                    self.showError("Email already in use")
                }
                else{
                    // Go to home screen
                    self.performSegue(withIdentifier: "goToNext", sender: self)
                    // Clear inputs
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    
                    
                }
            }
        
        }

    }
    
    // Show the error message
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
}
