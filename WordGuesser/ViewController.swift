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
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var switchModes: UIButton!
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var playerOptions: UISegmentedControl!
    
    
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
        fillLabel.isEnabled = true;
        showAnswer.isEnabled = true;
        progress.isHidden = false;
        progress.text = "\(currentElementIndex+1) / \(categoryQuestions.count)"
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
        fillLabel.isEnabled = true;
        showAnswer.isEnabled = true;
        progress.isHidden = false;
        progress.text = "\(currentElementIndex+1) / \(categoryQuestions.count)"
        fillLabel.becomeFirstResponder()
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
            progress.isHidden = true;
            overlayOn = false;
            fillLabel.isHidden = true
            showAnswer.isHidden = true
            nextQuestion.isHidden = true
            confirmQuestionButton.isHidden = true
            answer.isHidden = true
            playAgain.isHidden = true
            switchModes.isHidden = true;
            playerOptions.isHidden = false;
            playerOptions.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
            if(color=="red"){
                flashButton.tintColor = .systemRed
                fillButton.tintColor = .systemRed
                name.textColor = .systemRed
                question.textColor = .systemRed
                progress.textColor = .systemRed
                confirm.isHidden = true;
                logo.image = UIImage(named:"logo-rood")
                modeLabel.textColor = .systemRed
                fillLabel.backgroundColor = .systemRed
                playerOptions.selectedSegmentTintColor = .systemRed
            }
            else if(color=="green"){
                flashButton.tintColor = .systemGreen
                fillButton.tintColor = .systemGreen
                name.textColor = .systemGreen
                question.textColor = .systemGreen
                progress.textColor = .systemGreen
                confirm.isHidden = true;
                logo.image = UIImage(named:"logo-groen")
                modeLabel.textColor = .systemGreen
                fillLabel.backgroundColor = .systemGreen
                playerOptions.selectedSegmentTintColor = .systemGreen
            }
            else if(color=="yellow"){
                flashButton.tintColor = .systemYellow
                fillButton.tintColor = .systemYellow
                name.textColor = .systemYellow
                question.textColor = .systemYellow
                progress.textColor = .systemYellow
                confirm.isHidden = true;
                logo.image = UIImage(named:"logo-geel")
                modeLabel.textColor = .systemYellow
                fillLabel.backgroundColor = .systemYellow
                playerOptions.selectedSegmentTintColor = .systemYellow
            }
            else if(color=="blue"){
                flashButton.tintColor = .blue
                fillButton.tintColor = .blue
                name.textColor = .blue
                question.textColor = .blue
                progress.textColor = .blue
                confirm.isHidden = true;
                logo.image = UIImage(named:"logo-blauw")
                modeLabel.textColor = .blue
                fillLabel.backgroundColor  = .blue
                playerOptions.selectedSegmentTintColor = .blue
            }
            else if(color=="orange"){
                flashButton.isHidden = true
                fillButton.isHidden = true;
                fillLabel.isHidden = false
                confirmQuestionButton.isHidden = true;
                name.isHidden = true;
                name.text = "DEBUG MODE"
                fillLabel.isSecureTextEntry = true;
            }
        }
    }
    
    func endQuiz(){
        if(mode=="fill"){
            question.text = "😁 EINDE QUIZ"
            fillLabel.resignFirstResponder()
            answer.isHidden = false
            fillLabel.isHidden = true;
            showAnswer.isHidden = true;
            nextQuestion.isHidden = true;
            confirmQuestionButton.isHidden = true;
            playAgain.isHidden = false
            switchModes.isHidden = false
            answer.text = "🤟 Score: \(points) punt!"
        }
        if(mode=="flashcard"){
            question.text = "😁 EINDE FLASHCARDS"
            fillLabel.isHidden = true;
            showAnswer.isHidden = true;
            nextQuestion.isHidden = true;
            confirmQuestionButton.isHidden = true;
            playAgain.isHidden = false
            switchModes.isHidden = false
        }
    }
    
    func shuffle(){
        categoryQuestions.shuffle()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fillLabel.resignFirstResponder()
        enterPress()
        return true
    }

    func enterPress() {
        fillLabel.isEnabled = false;
        showAnswer.isEnabled = false;
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
    
    // MARK: - IB Actions
    
    @IBAction func redClick(_ sender: UIButton) {
        color = "red";
        categoryQuestions = quizQuestions.filter { $0.category == .red }
        shuffle()
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func greenClick(_ sender: UIButton) {
        color = "green";
        categoryQuestions = quizQuestions.filter { $0.category == .green }
        shuffle()
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func yellowClick(_ sender: Any) {
        color = "yellow";
        categoryQuestions = quizQuestions.filter { $0.category == .yellow }
        shuffle()
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    @IBAction func blueClick(_ sender: Any) {
        color = "blue";
        categoryQuestions = quizQuestions.filter { $0.category == .blue  }
        shuffle()
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        if(fillLabel.text == "admin"){
            print("welcome to debug mode")
            fillLabel.isSecureTextEntry = false;
            fillLabel.isHidden = true
            confirm.isHidden = true
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
        enterPress()
    }
    
    @IBAction func confirmQuestion(_ sender: Any) {
        fillLabel.resignFirstResponder()
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
        if(currentElementIndex < categoryQuestions.count){
            if(mode=="fill"){
                fillLabel.text = ""
                setFillQuestion()
            }
            if(mode=="flashcard"){
                setFlashCardQuestion();
            }
        }
        else{
            endQuiz();
        }
    }
    
    @IBAction func switchMode(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAgain(_ sender: Any) {
        shuffle()
        currentElementIndex = 0;
        points = 0;
        setupQuiz()
        overlayOn = true;
        answer.isHidden = true;
        playAgain.isHidden = true
        switchModes.isHidden = true;
        if(mode=="fill"){
            setFillQuestion()
        }
        else if(mode=="flashcard"){
            setFlashCardQuestion()
        }
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

