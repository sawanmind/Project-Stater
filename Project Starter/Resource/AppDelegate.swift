


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        
        ThemeManager.applyTheme(theme: .light)
        
        if isUserLoggedIn() {
             window?.rootViewController =  TabBarVC()
        } else {
             UIApplication.shared.keyWindow?.rootViewController = LoginVC()
        }
        
        return true
    }

}



extension UIViewController {
    @objc public func didTapLogout(){
        UserDefaults.removeUserMobileNumber()
        UIApplication.shared.keyWindow?.rootViewController = LoginVC()
    }
}

public func isUserLoggedIn() -> Bool {
    if UserDefaults.getUserMobileNumber() == "" || UserDefaults.getUserMobileNumber() == nil {
        return false
    } else {
        return true
    }
}


