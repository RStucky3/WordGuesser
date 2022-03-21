//
//  ViewController.swift
//  WordGuesser
//
//  Created by SD on 21/03/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var welcomeMessage: UITextView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var fillButton: UIButton!
    
    var color = "test";
    
    var currentElementIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var questions: [String] = []
    var answers: [String] = []
    
    @IBAction func redClick(_ sender: UIButton) {
        color = "red";
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func greenClick(_ sender: UIButton) {
        color = "green";
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func yellowClick(_ sender: Any) {
        color = "yellow";
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func blueClick(_ sender: Any) {
        color = "blue";
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetail",
           let ViewController = segue.destination as? ViewController {
            ViewController.color = color;
        }
    }
     
    
    @IBAction func fill(_ sender: UIButton) {
        question.isHidden = false;
        question.text = "Hoe groot is de zon?";
        modeLabel.isHidden = false;
        modeLabel.text = "Fill";
        flashButton.isHidden = true;
        fillButton.isHidden = true;
        
        
    }
    @IBAction func Flashcard(_ sender: Any) {
        question.isHidden = false;
        question.text = "Hoe groot is de zon?";
        modeLabel.isHidden = false;
        modeLabel.text = "Flashcard";
        flashButton.isHidden = true;
        fillButton.isHidden = true;
    }
    
 
    
    
}

