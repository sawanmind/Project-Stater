





import UIKit


struct DrawerModel {
    
    var icon = UIImage()
    var text = String()
    var controller = UIViewController()
    
    init(icon:UIImage, text:String, controller:UIViewController) {
        self.icon = icon
        self.text = text
        self.controller = controller
    }
}


enum ButtonType {
    case editProfile
    case moreButton
}


