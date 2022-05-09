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
    @IBOutlet weak var announcePlayer: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score3: UILabel!
    @IBOutlet weak var addScore1: UIButton!
    @IBOutlet weak var addScore2: UIButton!
    @IBOutlet weak var addScore3: UIButton!
    @IBOutlet weak var buttons: UIView!
    @IBOutlet weak var back: UIButton!
    
    var debuglength = 1000;
    var currentPlayer = 0;
    
    var color = "orange";
    var overlayOn = false

    var currentElementIndex = 0
    
    var quizQuestions: [QuizQuestion] = []
    var categoryQuestions: [QuizQuestion] = []
    var points = [0, 0, 0];
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
        setColor()
    }
    
    func setFlashCardQuestion() {
        mode = "flashcard"
        showScore()
        updateScore()
        buttons.isHidden = false;
        fillLabel.isEnabled = true;
        showAnswer.isEnabled = true;
        progress.isHidden = false;
        playerOptions.isHidden = true
        progress.text = "\(currentElementIndex+1) / \(categoryQuestions.count)"
        modeLabel.isHidden = false;
        modeLabel.text = "Kaarten";
        flashButton.isHidden = true;
        fillButton.isHidden = true;
        showAnswer.isHidden = false
        nextQuestion.isHidden = false
        question.isHidden = false;
        
        let currentQuestion = categoryQuestions[currentElementIndex]
        question.text = currentQuestion.question;
    }
    
    func setFillQuestion() {
        buttons.isHidden = false
        self.mode = "fill"
        showScore()
        updateScore()
        flashButton.isHidden = true;
        fillButton.isHidden = true;
        self.modeLabel.isHidden = false;
        self.modeLabel.text = "Invullen";
        let seconds = 1.5
        UIView.transition(with: announcePlayer, duration: 0.6,
                            options: .transitionCrossDissolve,
                            animations: {
                            self.announcePlayer.isHidden = false;
                        })
        announcePlayer.text = "Speler \(currentPlayer+1)"
        if(playerOptions.selectedSegmentIndex>0) {
            playerOptions.isHidden = true;
            fillLabel.isHidden = true
            nextQuestion.isHidden = true;
            showAnswer.isHidden = true;
            question.isHidden = true;
            self.progress.text = "\(self.currentElementIndex+1) / \(self.categoryQuestions.count)"
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                UIView.transition(with: self.announcePlayer, duration: 10,
                                  options: .transitionCrossDissolve,
                                    animations: {
                                    self.announcePlayer.isHidden = true;
                                })
                self.fillLabel.isEnabled = true;
                self.showAnswer.isEnabled = true;
                self.progress.isHidden = false;
                self.fillLabel.becomeFirstResponder()
                self.question.isHidden = false;
                self.fillLabel.isHidden = false;
                self.showAnswer.isHidden = false
                self.nextQuestion.isHidden = true
                self.confirmQuestionButton.isHidden = false
                
                let currentQuestion = self.categoryQuestions[self.currentElementIndex]
                self.question.text = currentQuestion.question;
            }
        } else {
            playerOptions.isHidden = true;
            self.announcePlayer.isHidden = true;
            self.fillLabel.isEnabled = true;
            self.showAnswer.isEnabled = true;
            self.progress.isHidden = false;
            self.progress.text = "\(self.currentElementIndex+1) / \(self.categoryQuestions.count)"
            self.fillLabel.becomeFirstResponder()
            self.mode = "fill"
            self.question.isHidden = false;
            self.modeLabel.isHidden = false;
            self.modeLabel.text = "Invullen";
            
            self.fillLabel.isHidden = false;
            self.showAnswer.isHidden = false
            self.nextQuestion.isHidden = true
            self.confirmQuestionButton.isHidden = false
            
            let currentQuestion = self.categoryQuestions[self.currentElementIndex]
            self.question.text = currentQuestion.question;
        }
    }
     
    func setColor() {
        if(overlayOn) {
            hideScore()
            buttons.isHidden = true;
            announcePlayer.isHidden = true;
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
            if(color=="red") {
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
                score1.textColor = .systemRed
                score2.textColor = .systemRed
                score3.textColor = .systemRed
                back.tintColor = .systemRed
            } else if(color=="green") {
                flashButton.tintColor = .green
                fillButton.tintColor = .green
                name.textColor = .green
                question.textColor = .green
                progress.textColor = .green
                confirm.isHidden = true;
                logo.image = UIImage(named:"logo-groen")
                modeLabel.textColor = .green
                fillLabel.backgroundColor = .green
                playerOptions.selectedSegmentTintColor = .green
                score1.textColor = .green
                score2.textColor = .green
                score3.textColor = .green
                back.tintColor = .green
            } else if(color=="yellow") {
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
                score1.textColor = .systemYellow
                score2.textColor = .systemYellow
                score3.textColor = .systemYellow
                back.tintColor = .systemYellow
            } else if(color=="blue") {
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
                score1.textColor = .blue
                score2.textColor = .blue
                score3.textColor = .blue
                back.tintColor = .blue
            } else if(color=="orange") {
                flashButton.isHidden = true
                playerOptions.isHidden = true;
                fillButton.isHidden = true;
                fillLabel.isHidden = false
                fillLabel.isEnabled = true;
                fillLabel.becomeFirstResponder()
                confirmQuestionButton.isHidden = true;
                name.isHidden = true;
                confirm.isHidden = false;
                fillLabel.isSecureTextEntry = true;
            }
            
        } else {
            var debuglength = 1000;
        }
    }
    
    func endQuiz() {
        if(mode=="fill") {
            question.text = "😁 EINDE QUIZ"
            fillLabel.resignFirstResponder()
            answer.isHidden = false
            fillLabel.isHidden = true;
            showAnswer.isHidden = true;
            nextQuestion.isHidden = true;
            confirmQuestionButton.isHidden = true;
            playAgain.isHidden = false
            switchModes.isHidden = false
            if (playerOptions.selectedSegmentIndex==0) {
                answer.text = "🏆 Score: \(points[0]) punt(en)!"
            }
            if (playerOptions.selectedSegmentIndex==1) {
                answer.text = "🏆 Scores: \n Speler 1: \(points[0]) punt(en)! \n Speler 2: \(points[1]) punt(en)!"
            }
            if (playerOptions.selectedSegmentIndex==2) {
                answer.text = "🏆 Scores: \n Speler 1: \(points[0]) punt(en)! \n Speler 2: \(points[1]) punt(en)! \n Speler 3: \(points[2]) punt(en)!"
            }
            
        }
        if(mode=="flashcard") {
            question.text = "😁 EINDE FLASHCARDS"
            fillLabel.isHidden = true;
            showAnswer.isHidden = true;
            nextQuestion.isHidden = true;
            confirmQuestionButton.isHidden = true;
            playAgain.isHidden = false
            switchModes.isHidden = false
        }
    }
    
    func shuffle() {
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
        var checkGivenAnswer = givenAwnser?.lowercased()
        var checkAnswer = currentQuestion.answer.lowercased()
        if(givenAwnser?.lowercased()==currentQuestion.answer.lowercased()) {
            points[currentPlayer]+=1
            updateScore()
            answer.text = "😁, Goed gedaan!"
            answer.isHidden = false
        } else if(mode=="flashcard") {
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = "🙃 \nAntwoord: " + currentQuestion.answer
            answer.isHidden = false
        } else {
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = "😔 \nJuiste antwoord: " + currentQuestion.answer
            answer.isHidden = false
        }
    }
    
    func switchPlayer(){
        if(currentPlayer<playerOptions.selectedSegmentIndex){
            currentPlayer+=1
        } else {
            currentPlayer=0;
        }
    }
    
    func showScore(){
        if (playerOptions.selectedSegmentIndex==0) {
            score1.isHidden = false;
            if (mode=="flashcard") {
                addScore1.isHidden = false;
            }
        }
        if (playerOptions.selectedSegmentIndex==1) {
            score1.isHidden = false;
            score2.isHidden = false;
            if (mode=="flashcard") {
                addScore1.isHidden = false;
                addScore2.isHidden = false;
            }
        }
        if (playerOptions.selectedSegmentIndex==2) {
            score1.isHidden = false;
            score2.isHidden = false;
            score3.isHidden = false;
            score1.text = mode
            if (mode=="flashcard") {
                addScore1.isHidden = false;
                addScore2.isHidden = false;
                addScore3.isHidden = false;
            }
        }
    }
    func hideScore() {
        score1.isHidden = true;
        score2.isHidden = true;
        score3.isHidden = true;
        addScore1.isHidden = true;
        addScore2.isHidden = true;
        addScore3.isHidden = true;
    }
    
    func updateScore() {
        score1.text = "Speler 1: \(points[0])"
        score2.text = "Speler 2: \(points[1])"
        score3.text = "Speler 3: \(points[2])"
        if(playerOptions.selectedSegmentIndex>0) {
            if(currentPlayer==0) {
                if(color=="red") {
                    score1.textColor = .systemRed
                    score2.textColor = .systemRed
                    score3.textColor = .systemRed
                } else if(color=="green") {
                    score1.textColor = .green
                    score2.textColor = .green
                    score3.textColor = .green
                } else if(color=="yellow") {
                    score1.textColor = .systemYellow
                    score2.textColor = .systemYellow
                    score3.textColor = .systemYellow
                } else if(color=="blue") {
                    score1.textColor = .blue
                    score2.textColor = .blue
                    score3.textColor = .blue
                }
                if(mode=="fill") {
                    score1.textColor = .orange
                }
            }
            if(currentPlayer==1) {
                if(color=="red") {
                    score1.textColor = .systemRed
                    score2.textColor = .systemRed
                    score3.textColor = .systemRed
                } else if(color=="green") {
                    score1.textColor = .green
                    score2.textColor = .green
                    score3.textColor = .green
                } else if(color=="yellow") {
                    score1.textColor = .systemYellow
                    score2.textColor = .systemYellow
                    score3.textColor = .systemYellow
                } else if(color=="blue") {
                    score1.textColor = .blue
                    score2.textColor = .blue
                    score3.textColor = .blue
                }
                if(mode=="fill") {
                    score2.textColor = .orange
                }
            }
            if(currentPlayer==2) {
                if(color=="red") {
                    score3.textColor = .systemRed
                    score2.textColor = .systemRed
                    score1.textColor = .systemRed
                } else if(color=="green") {
                    score3.textColor = .green
                    score2.textColor = .green
                    score1.textColor = .green
                } else if(color=="yellow") {
                    score3.textColor = .systemYellow
                    score2.textColor = .systemYellow
                    score1.textColor = .systemYellow
                } else if(color=="blue") {
                    score3.textColor = .blue
                    score2.textColor = .blue
                    score1.textColor = .blue
                }
                if(mode=="fill") {
                    score3.textColor = .orange
                }
            }
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
            debuglength = 3;
            fillButton.isHidden = false;
            flashButton.isHidden = false
            categoryQuestions = quizQuestions
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
        showAnswer.isEnabled = false;
        fillLabel.isEnabled = false;
        fillLabel.resignFirstResponder()
        let currentQuestion = categoryQuestions[currentElementIndex]
        confirmQuestionButton.isHidden = true;
        nextQuestion.isHidden = false;
        var givenAwnser = fillLabel.text
        if(givenAwnser?.lowercased()==currentQuestion.answer){
            points[currentPlayer]+=1
            updateScore()
            answer.text = "😁, Goed gedaan!"
            answer.isHidden = false
        } else {
            let currentQuestion = categoryQuestions[currentElementIndex]
            answer.text = "😔 \nJuiste antwoord: " + currentQuestion.answer
            answer.isHidden = false
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        answer.isHidden = true
        currentElementIndex+=1;
        switchPlayer();
        updateScore();
        
        if(currentElementIndex < categoryQuestions.count && currentElementIndex < debuglength){
            if (mode=="fill"){
                fillLabel.text = ""
                setFillQuestion()
            }
            if (mode=="flashcard"){
                setFlashCardQuestion();
            }
        } else {
            endQuiz();
        }
    }
    
    @IBAction func switchMode(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playAgain(_ sender: Any) {
        shuffle()
        currentElementIndex = 0;
        points[0] = 0;
        points[1] = 0;
        points[2] = 0;
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
    
    @IBAction func addScore1(_ sender: Any) {
        points[0]+=1
        updateScore()
    }
    @IBAction func addScore2(_ sender: Any) {
        points[1]+=1
        updateScore()
    }
    @IBAction func addScore3(_ sender: Any) {
        points[2]+=1
        updateScore()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

