//
//  extensions.swift
//  Chat_Socket_Practice
//
//  Created by Ahmad Ellashy on 20/09/2024.
//

import UIKit



extension UIView {
    
    var height: CGFloat {
        return self.frame.height
    }
    var width: CGFloat {
        return self.frame.width
    }
    var right: CGFloat {
        return left + width
    }
    var left: CGFloat {
        return self.frame.origin.x
    }
    var top: CGFloat {
        return self.frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
   
}
