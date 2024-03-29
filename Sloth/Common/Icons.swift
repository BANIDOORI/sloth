//
//  Icons.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit

extension UIImage {
    static var todayTab: UIImage {
        UIImage(named: "ic_bottom_tap_bar_menu01_off")!
    }
    
    static var todayTabSelected: UIImage {
        UIImage(named: "ic_bottom_tap_bar_menu01_on")!
    }
    
    static var lectureListTab: UIImage {
        UIImage(named: "ic_bottom_tap_bar_menu02_off")!
    }
    
    static var lectureListTabSelected: UIImage {
        UIImage(named: "ic_bottom_tap_bar_menu02_on")!
    }
    
    static var myPageTab: UIImage {
        UIImage(named:  "ic_bottom_tap_bar_menu03_off")!
    }
    
    static var myPageTabSelected: UIImage {
        UIImage(named: "ic_bottom_tap_bar_menu03_on")!
    }
    
    static var alertConfirm: UIImage {
        UIImage(named: "ic_alert_confirm")!
    }
    
    static var alertError: UIImage {
        UIImage(named: "ic_alert_error")!
    }

    static var actionBell: UIImage {
        UIImage(named: "ic_action_bell")!
    }
    
    static var failureStamp: UIImage {
        UIImage(named: "ic_failure")!
    }
    
    static var successStamp: UIImage {
        UIImage(named: "ic_success")!
    }
    
    static var profile: UIImage {
        UIImage(named: "img_personal_thum")!
    }

    static var activationPlus: UIImage {
        UIImage(named: "activation_plus")!
    }

    static var disableMinus: UIImage {
        UIImage(named: "disable_minus")!
    }

    static var activationPlusWhite: UIImage {
        UIImage(named: "activation_plus_white")!
    }

    static var activationMinusWhite: UIImage {
        UIImage(named: "activation_minus_white")!
    }
    
    static var back: UIImage {
        UIImage(named: "ic_navi_arrow_back")!
    }
    
    static var expandMore: UIImage {
        UIImage(named: "ic_expand_more")!
    }
    
    static var actionPlus: UIImage {
        UIImage(named: "ic_action_plus")!
    }
    
    static var right: UIImage {
        UIImage(named: "ic_navi_chevron_right")!
    }
    
    struct Sloth {
        static var inProgress: UIImage {
            UIImage(named: "img_sloth_in_progess")!
        }
        
        static var login: UIImage {
            UIImage(named: "img_sloth_login")!
        }
        
        static var lose: UIImage {
            UIImage(named: "img_sloth_lose")!
        }
        
        static var noLessons: UIImage {
            UIImage(named: "img_sloth_no_lessons")!
        }
        
        static var push: UIImage {
            UIImage(named: "img_sloth_push")!
        }
        
        static var register: UIImage {
            UIImage(named: "img_sloth_register")!
        }
        
        static var todayDone: UIImage {
            UIImage(named: "img_sloth_today_done")!
        }
        
        static var todayWill: UIImage {
            UIImage(named: "img_sloth_today_will")!
        }
        
        static var todayLose: UIImage {
            UIImage(named: "img_sloth_today_lose")!
        }
    }
    
    struct Login {
        static var google: UIImage {
            UIImage(named: "btn_google_login")!
        }
        
        static var kakao: UIImage {
            UIImage(named: "btn_kakao_login")!
        }
        
        static var apple: UIImage {
            UIImage(named: "btn_apple_login")!
        }
    }
}
