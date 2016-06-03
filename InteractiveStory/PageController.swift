
import UIKit
import AudioToolbox

class PageController: UIViewController {
    
    var page: Page?
    var sound: SystemSoundID = 0
    
    let artwork = UIImageView()
    let storyLabel = UILabel()
    let firstCButton = UIButton(type: .System)
    let secondCButton = UIButton(type: .System)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (page: Page){
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        if let page = page {
            artwork.image = page.story.artwork
            storyLabel.text = page.story.text
            
            if let firstChoice = page.firstChoice {
                firstCButton.setTitle(firstChoice.title, forState: .Normal)
                firstCButton.addTarget(self, action: Selector("loadFirstChoice"), forControlEvents: .TouchUpInside)
            } else {
                firstCButton.setTitle("Play Again", forState: .Normal)
                firstCButton.addTarget(self, action: Selector("playAgain"), forControlEvents: .TouchUpInside)
            }
            
            if let secondChoice = page.secondChoice {
                secondCButton.setTitle(secondChoice.title, forState: .Normal)
                secondCButton.addTarget(self, action: Selector("loadSecondChoice"), forControlEvents: .TouchUpInside)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(artwork)
        artwork.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            artwork.topAnchor.constraintEqualToAnchor(view.topAnchor),
            artwork.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            artwork.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            artwork.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
            ])
        
        view.addSubview(storyLabel)
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            storyLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 16),
            storyLabel.topAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -48)
            ])
        
        view.addSubview(firstCButton)
        firstCButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            firstCButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -86),
            firstCButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
            ])
        
        view.addSubview(secondCButton)
        secondCButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            secondCButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -40),
            secondCButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
            ])
    }
    
    func loadFirstChoice () {
        if let page = page, firstChoice = page.firstChoice{
            let nextPage = firstChoice.page
            let pageController = PageController(page: nextPage)
            
            playSound(nextPage.story.soundEffectURL)
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func loadSecondChoice () {
        if let page = page, secondChoice = page.secondChoice{
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)

            playSound(nextPage.story.soundEffectURL)
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func playAgain () {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func playSound(url: NSURL) {
        AudioServicesCreateSystemSoundID(url, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
}
