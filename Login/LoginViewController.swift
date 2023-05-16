
import UIKit
import Firebase
class LoginViewController: UIViewController {
    
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
    func validateFields()->String? {
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            
        {
            return "Please fill in all fields"
        }
        
        
        return nil
        
    }
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        // Validate the fields
        let error = validateFields()
        if error != nil{
            // There was an error
            showError(error!)
        
        }
        else{
            
            guard let email = emailTextField.text else {return}
            guard let password = passwordTextField.text else {return}
            
            Auth.auth().signIn(withEmail: email, password: password){(result,err) in
                // Check for errors
                if  err != nil {
                    //there was an error
                    self.showError("Error logging in ")
                }
                else{
                    // Go to home screen
                    self.performSegue(withIdentifier: "goToNext", sender: self)
                    
                    
                }
            }
        }
    }
    
}
