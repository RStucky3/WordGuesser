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
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var fillLabel: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var nextQuestion: UIButton!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var confirmQuestionButton: UIButton!
    
    var color = "orange";
    var overlayOn = false

    var currentElementIndex = 0
    
    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions: [QuizQuestion] = []
    var points = 0;
    var mode = "";
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetail",
           let ViewController = segue.destination as? ViewController {
            ViewController.color = color;
            ViewController.overlayOn = true;
            ViewController.categoryQuestions = categoryQuestions;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getLocalQuizData()
    }
    
    // MARK: - Functions
    
    func setupQuiz() {
        
        //print("Questions array is: \(quizQuestions)")
        
        setColor()
    }
    
    func setFlashCardQuestion() {
        mode = "flashcard"
        modeLabel.isHidden = false;
        modeLabel.text = "Flashcard";
        flashButton.isHidden = true;
        fillButton.isHidden = true;
        showAnswer.isHidden = false
        nextQuestion.isHidden = false
        question.isHidden = false;
        
        let currentQuestion = categoryQuestions[currentElementIndex]
        question.text = currentQuestion.question;
    }
    
    func setFillQuestion(){
        mode = "fill"
        question.isHidden = false;
        modeLabel.isHidden = false;
        modeLabel.text = "Fill";
        flashButton.isHidden = true;
        fillButton.isHidden = true;
        fillLabel.isHidden = false;
        showAnswer.isHidden = false
        nextQuestion.isHidden = true
        confirmQuestionButton.isHidden = false
        
        let currentQuestion = categoryQuestions[currentElementIndex]
        question.text = currentQuestion.question;
    }
     
    func setColor(){
        if(overlayOn){
            overlayOn = false;
            fillLabel.isHidden = true
            showAnswer.isHidden = true
            nextQuestion.isHidden = true
            confirmQuestionButton.isHidden = true
            answer.isHidden = true
            if(color=="red"){
                flashButton.tintColor = .systemRed
                fillButton.tintColor = .systemRed
                name.textColor = .systemRed
                question.textColor = .systemRed
                logo.image = UIImage(named:"logo-rood")
                modeLabel.textColor = .systemRed
                fillLabel.backgroundColor = .systemRed
            }
            else if(color=="green"){
                flashButton.tintColor = .systemGreen
                fillButton.tintColor = .systemGreen
                name.textColor = .systemGreen
                question.textColor = .systemGreen
                logo.image = UIImage(named:"logo-groen")
                modeLabel.textColor = .systemGreen
                fillLabel.backgroundColor = .systemGreen
            }
            else if(color=="yellow"){
                flashButton.tintColor = .systemYellow
                fillButton.tintColor = .systemYellow
                name.textColor = .systemYellow
                question.textColor = .systemYellow
                logo.image = UIImage(named:"logo-geel")
                modeLabel.textColor = .systemYellow
                fillLabel.backgroundColor = .systemYellow
            }
            else if(color=="blue"){
                flashButton.tintColor = .blue
                fillButton.tintColor = .blue
                name.textColor = .blue
                question.textColor = .blue
                logo.image = UIImage(named:"logo-blauw")
                modeLabel.textColor = .blue
                fillLabel.backgroundColor  = .blue
            }
            else if(color=="orange"){
                flashButton.isHidden = true
                fillButton.isHidden = true;
                fillLabel.isHidden = false
                confirmQuestionButton.isHidden = false
                name.isHidden = true;
                name.text = "DEBUG MODE"
                fillLabel.isSecureTextEntry = true;
            }
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func redClick(_ sender: UIButton) {
        color = "red";
        categoryQuestions = quizQuestions.filter { $0.category == .red }
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func greenClick(_ sender: UIButton) {
        color = "green";
        categoryQuestions = quizQuestions.filter { $0.category == .green }
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func yellowClick(_ sender: Any) {
        color = "yellow";
        categoryQuestions = quizQuestions.filter { $0.category == .yellow }
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func blueClick(_ sender: Any) {
        color = "blue";
        categoryQuestions = quizQuestions.filter { $0.category == .blue  }
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if(fillLabel.text == "admin"){
            print("welcome to debug mode")
            fillLabel.isSecureTextEntry = false;
            fillLabel.isHidden = true
            confirmQuestionButton.isHidden = true
            name.isHidden = false;
        }
    }
    
    @IBAction func fill(_ sender: UIButton) {
        setFillQuestion()
    }
    
    @IBAction func Flashcard(_ sender: Any) {
        setFlashCardQuestion()
    }
    
    @IBAction func showAnswer(_ sender: Any) {
        if(mode=="fill"){
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = "😔 \nCorrect Answer: " + currentQuestion.answer
            answer.isHidden = false
            confirmQuestionButton.isHidden = true
            nextQuestion.isHidden = false;
        }
        if(mode=="flashcard"){
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = currentQuestion.answer;
            answer.isHidden = false
        }
    }
    
    @IBAction func confirmQuestion(_ sender: Any) {
        let currentQuestion = categoryQuestions[currentElementIndex]
        confirmQuestionButton.isHidden = true;
        nextQuestion.isHidden = false;
        var givenAwnser = fillLabel.text
        if(givenAwnser?.lowercased()==currentQuestion.answer){
            points+=1
            answer.text = "😁, Goed gedaan!"
            answer.isHidden = false
        }
        else{
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = "😔 \nCorrect Answer: " + currentQuestion.answer
            answer.isHidden = false
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        answer.isHidden = true
        currentElementIndex+=1;
        if(mode=="fill"){
            fillLabel.text = ""
            setFillQuestion()
        }
        if(mode=="flashcard"){
            setFlashCardQuestion();
        }
        
    }
    
    func textFieldShouldReturn(_ fillLabel:UITextField) -> Bool {

        print("hier komt dingen als je op enter drukt")
        return true
    }
    
    // MARK: - JSON Functions
    
    func getLocalQuizData() {
        // Call readLocalFile function with the name of the local file (localQuizData)
        if let localData = self.readLocalFile(forName: "localQuizData") {
            // File exists, now parse 'localData' with the parse function
            self.parse(jsonData: localData)
            
            setupQuiz()
        }
    }

    // Read local file

    private func readLocalFile(forName name: String) -> Data? {
        do {
            // Check if file exists in application bundle, then try to convert it to a string, if that works return that
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error) // Something went wrong, show an alert
        }
        
        return nil
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([QuizQuestion].self,
                                                       from: jsonData)
            /*
            print("Question: ", decodedData[0].question)
            print("Answer: ", decodedData[0].answer)
            print("===================================")
            */
            
            self.quizQuestions = decodedData
        } catch {
            print("decode error")
        }
    }

    
}

