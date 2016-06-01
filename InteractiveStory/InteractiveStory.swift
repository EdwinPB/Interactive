
import Foundation

import UIKit

enum Story: String {
    case ReturnTrip
    case TouchDown
    case Homeward
    case Rover
    case Cave
    case Crate
    case Monster
    case Droid
    case Home
}

extension Story {
    var artwork: UIImage {
    return UIImage(named: self.rawValue)!
    }
    
    var text: String {
        switch self {
        case .ReturnTrip:
            return "thing"
        case .TouchDown:
            return "thing"
        case .Homeward:
            return "thing"
        case .Rover:
            return "thing"
        case .Cave:
            return "thing"
        case .Crate:
            return "thing"
        case .Monster:
            return "thing"
        case .Droid:
            return "thing"
        case .Home:
            return "thing"
        }
    }

}


class Page {
    let story: Story
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    init (story: Story){
        self.story = story
    }
}





















