import UIKit

// MARK: - Data Model
struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

// MARK: - View Controller
class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    // MARK: - Properties
    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions()
        updateUI()
    }
    
    // MARK: - IBActions
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        // Ensure we still have a valid question
        guard currentQuestionIndex < questions.count else { return }
        
        let currentQuestion = questions[currentQuestionIndex]
        let selectedAnswerIndex = sender.tag
        
        // Visual Feedback: Save original background color
        let originalColor = sender.backgroundColor
        
        // Check if the answer is correct and change button color accordingly
        if selectedAnswerIndex == currentQuestion.correctAnswerIndex {
            score += 1
            sender.backgroundColor = UIColor.green
            print("Correct! Score: \(score)")
        } else {
            sender.backgroundColor = UIColor.red
            print("Incorrect. Score: \(score)")
        }
        
        // Disable answer buttons temporarily to prevent multiple taps
        setAnswerButtonsEnabled(false)
        
        // After a short delay, reset color, update the question, and re-enable buttons
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.backgroundColor = originalColor
            self.currentQuestionIndex += 1
            self.updateUI()
        }
    }
    
    @IBAction func restartQuiz(_ sender: UIButton) {
        // Reset quiz parameters and update UI
        currentQuestionIndex = 0
        score = 0
        updateUI()
    }
    
    // MARK: - Helper Methods
    func setupQuestions() {
        questions = [
            Question(
                text: "What is the capital of France?",
                answers: ["Berlin", "Madrid", "Paris", "Rome"],
                correctAnswerIndex: 2
            ),
            Question(
                text: "Which planet is known as the Red Planet?",
                answers: ["Earth", "Jupiter", "Mars", "Venus"],
                correctAnswerIndex: 2
            ),
            Question(
                text: "What is 2 + 2?",
                answers: ["3", "5", "4", "6"],
                correctAnswerIndex: 2
            )
        ]
    }
    
    func updateUI() {
        if currentQuestionIndex < questions.count {
            let currentQuestion = questions[currentQuestionIndex]
            questionLabel.text = currentQuestion.text
            
            answerButton1.setTitle(currentQuestion.answers[0], for: .normal)
            answerButton2.setTitle(currentQuestion.answers[1], for: .normal)
            answerButton3.setTitle(currentQuestion.answers[2], for: .normal)
            answerButton4.setTitle(currentQuestion.answers[3], for: .normal)
            
            scoreLabel.text = "Score: \(score)"
            progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
            
            // Ensure answer buttons are visible and enabled
            setAnswerButtonsHidden(false)
            setAnswerButtonsEnabled(true)
            
            // Hide restart button until the quiz is over
            restartButton.isHidden = true
        } else {
            // Quiz completed
            questionLabel.text = "Quiz Completed! Final Score: \(score)"
            scoreLabel.text = "Score: \(score)"
            progressLabel.text = "Quiz Completed"
            
            // Hide answer buttons and show the restart button
            setAnswerButtonsHidden(true)
            restartButton.isHidden = false
        }
    }
    
    func setAnswerButtonsHidden(_ hidden: Bool) {
        answerButton1.isHidden = hidden
        answerButton2.isHidden = hidden
        answerButton3.isHidden = hidden
        answerButton4.isHidden = hidden
    }
    
    func setAnswerButtonsEnabled(_ enabled: Bool) {
        answerButton1.isEnabled = enabled
        answerButton2.isEnabled = enabled
        answerButton3.isEnabled = enabled
        answerButton4.isEnabled = enabled
    }
}
