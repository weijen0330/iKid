//
//  ViewController.swift
//  iKid
//
//  Created by Wei-Jen Chiang on 5/9/16.
//  Copyright © 2016 Wei-Jen Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var jokeVC : JokeViewController!
    private var punchlineVC : PunchlineViewController!
    private var jokeCategory : String = ""
    
    @IBOutlet weak var welcomeLine1: UILabel!
    @IBOutlet weak var welcomeLine2: UILabel!
    
    @IBOutlet weak var toolbarItem: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    private var jokes : [String : [String]] = [
        "Puns" :
            ["What's the worst part about \n throwing a party in space?", "You have to planet."],
        "Dad" :
            ["Did you hear about the explosion at \n the cheese factory in France?", "I heard nothing was left except for de bries."],
        "Marriage" : [
            "Just read that 7,634,017 people got married last year.", "Not to cause any trouble, \n but shouldn't that be an even number?"]
    ]
    
    private func jokeBuilder() {
        if (jokeVC == nil) {
            jokeVC = storyboard?.instantiateViewControllerWithIdentifier("Joke")
                as! JokeViewController
        }
    }
    
    private func punchlineBuilder() {
        if (punchlineVC == nil) {
            punchlineVC = storyboard?.instantiateViewControllerWithIdentifier("Punchline")
                as! PunchlineViewController
        }
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        jokeBuilder()
        punchlineBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        /* punchline */
        if (sender.title == "Punchline" && jokeVC != nil && jokeVC.view.superview != nil) {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            punchlineVC.view.frame = view.frame
            punchlineVC.punchline.text = jokes[jokeCategory]![1]
            punchlineVC.punchline.lineBreakMode = .ByWordWrapping
            punchlineVC.punchline.numberOfLines = 0
            self.welcomeLine1.text = ""
            self.welcomeLine2.text = ""
            self.toolbarItem.title = "Home"
            switchViewController(jokeVC, to: punchlineVC)
        /* home screen */
        } else if (sender.title == "Home") {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            self.welcomeLine1.text = "Welcome to Wei-Jen's iKid app."
            self.welcomeLine2.text = "Select a category above and get ready to laugh! "
            punchlineVC.willMoveToParentViewController(nil)
            punchlineVC.view.removeFromSuperview()
            punchlineVC.removeFromParentViewController()
        /* joke */
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            jokeVC.view.frame = view.frame
            self.jokeCategory = sender.title!
            jokeVC.joke.text = jokes[jokeCategory]![0]
            jokeVC.joke.lineBreakMode = .ByWordWrapping
            jokeVC.joke.numberOfLines = 0
            self.welcomeLine1.text = ""
            self.welcomeLine2.text = ""
            self.toolbarItem.title = "Punchline"
            switchViewController(punchlineVC, to: jokeVC)
        }
        
        UIView.commitAnimations()
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if (from != nil) {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if (to != nil) {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

