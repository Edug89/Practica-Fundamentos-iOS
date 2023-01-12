//
//  LoginViewController.swift
//  Proyecto-Fundamentos-iOS
//
//  Created by Eduardo Martinez Palomino on 31/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad() //creaamos addObserver para abrir y cerrar el teclado con aviso en cansola

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(openKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) //Aquí borraríamos todas las notificaciones ancladas en el Oserver
    }
        
    @objc func openKeyboard() {
        print("open Keyboard")
            
    }
    
    @objc func closeKeyboard() {
        print("close Keyboard")
        
    }
    
    override func viewDidAppear(_ animated: Bool) { //Con esta función le damos animación al login
        super.viewDidAppear(animated)
        
        emailTextField.center.x -= view.bounds.width //indicamos que email aparezca fuera de la pantalla
        passwordTextField.center.x -= view.bounds.width //indicamos que contraseña aparezca ffuera de la pantalla
        loginButton.alpha = 0 //Aquí indicamos que el botón es transparente(alpha corresponde a la visibilidad)
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: []) {
            self.emailTextField.center.x += self.view.bounds.width
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 3) {
            self.loginButton.alpha = 1 //En la animación le indicamos que se ponga opaco en 3segundos
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) { //Aquí deffinimos el botón para hacer ya la llamada con el login, toda la función de esta llamada,está en el NetworLayer.
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        
        guard let password  = passwordTextField.text, !password.isEmpty else {
            print("password is empty")
            return
        }
        
        NetworkLayer.shared.login(email: email, password: password) { token, error in
            if let token = token {
                LocalDataLayer.shared.save(token: token)
                
                DispatchQueue.main.async {//Aquí indicamos que una vez se compruebe el login si es correcto navegue hacia HomeTabBarController
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap{ ($0 as? UIWindowScene)?.keyWindow }
                        .first?
                        .rootViewController = HomeTabBarController()
                }
                
            } else {
                print("Login Error: ", error?.localizedDescription ?? "")
            }
        }
    }
    

}
