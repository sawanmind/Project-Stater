

import UIKit
import Foundation


protocol drawerProtocolNew{
   
    func show()
    func dissmiss()

    var backgroundView : UIView{set get}
    var drawerView : UIView{set get}
}



protocol DrawerControllerDelegate: class {
    
    func pushTo(viewController : UIViewController)
    
    func didTapButton(type:ButtonType)
}


extension drawerProtocolNew where Self:UIView{
    
  
    func show(){
        self.drawerView.frame.origin = CGPoint(x:-self.frame.size.width, y:0)
        backgroundView.alpha = 0.0

        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            
            self.backgroundView.alpha = 0.6
            self.drawerView.frame.origin = CGPoint(x:0, y:0)
           
        }
    }
    
    
    func dissmiss(){
       UIView.animate(withDuration: 0.2, animations: {
        self.drawerView.frame.origin = CGPoint(x:-self.frame.size.width, y:0)
        self.backgroundView.alpha = 0.0
        
       }) { (completion) in
            self.removeFromSuperview()
        }
    }
    
}
