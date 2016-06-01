
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
    static var story: Page {
        let returnTrip = Page(story: .ReturnTrip)
        let touchdown = returnTrip.addChoice("Stop and investigate", story: .TouchDown)
        let homeward = returnTrip.addChoice("Continue Home to Earth", story: .Homeward)
        let rover = returnTrip.addChoice("Explore the rover", story: .Rover)
        let crate = returnTrip.addChoice("Open the crate", story: .Crate)
        
        homeward.addChoice("Head back to mars", page: touchdown)
        let home = rover.addChoice("Continue towards", story: .Home)
        
        let cave = rover.addChoice("Explore the Coordinates", story: .Cave)
        rover.addChoice("Return to Earth", page: home)
        
        cave.addChoice("Continue towards faint", story: .Droid)
        cave.addChoice("Refill the ship", page: rover)
        
        crate.addChoice("Explore the Rover", page: rover)
        crate.addChoice("Use the key", story: .Monster)
        
        return returnTrip
    }
}



















