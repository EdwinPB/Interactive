
import Foundation

import UIKit

enum Story {
    case ReturnTrip(String)
    case TouchDown
    case Homeward
    case Rover(String)
    case Cave
    case Crate
    case Monster
    case Droid(String)
    case Home
    
    var rawValue: String {
        switch self {
        case .ReturnTrip: return "ReturnTrip"
        case .TouchDown: return "TouchDown"
        case .Homeward: return "Homeward"
        case .Rover: return "Rover"
        case .Cave: return "Cave"
        case .Crate: return "Crate"
        case .Monster: return "Monster"
        case .Droid: return "Droid"
        case .Home: return "Home"

        }
    }
}

extension Story {
    var artwork: UIImage {
        return UIImage(named: self.rawValue)!
    }
    
    var text: String {
        switch self {
        case .ReturnTrip(let name):
            return "thing1\(name)"
        case .TouchDown:
            return "thing2"
        case .Homeward:
            return "thing3"
        case .Rover(let name):
            return "thing4\(name)"
        case .Cave:
            return "thing5"
        case .Crate:
            return "thing6"
        case .Monster:
            return "thing7"
        case .Droid(let name):
            return "thing8\(name)"
        case .Home:
            return "thing9"
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

extension Page {
    
    func addChoice (title: String, story: Story) -> Page{
        let page = Page(story: story)
        return addChoice(title, page: page)
        
    }
    
    func addChoice(title: String, page: Page) -> Page {
        switch (firstChoice, secondChoice){
        case (.Some, .Some): break
        case (.None, .None), (.None, .Some):
            firstChoice = (title, page)
        case (.Some, .None):
            secondChoice = (title, page)
            
        }
        return page
    }
}

struct Adventure {
    static func story (name: String) -> Page {
        let returnTrip = Page(story: .ReturnTrip(name))
        let touchdown = returnTrip.addChoice("Stop and investigate", story: .TouchDown)
        let homeward = returnTrip.addChoice("Continue Home to Earth", story: .Homeward)
        let rover = touchdown.addChoice("Explore the rover", story: .Rover(name))
        let crate = touchdown.addChoice("Open the crate", story: .Crate)
        
        homeward.addChoice("Head back to mars", page: touchdown)
        let home = rover.addChoice("Continue towards", story: .Home)
        
        let cave = rover.addChoice("Explore the Coordinates", story: .Cave)
        rover.addChoice("Return to Earth", page: home)
        
        cave.addChoice("Continue towards faint", story: .Droid(name))
        cave.addChoice("Refill the ship", page: rover)
        
        crate.addChoice("Explore the Rover", page: rover)
        crate.addChoice("Use the key", story: .Monster)
        
        return returnTrip
    }
}



















