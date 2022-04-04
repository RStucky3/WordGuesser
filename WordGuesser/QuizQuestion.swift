import Foundation
import CoreVideo

struct QuizQuestion: Codable {
    var category: QuizCategory
    var qaNumber: Int
    var question: String
    var answer: String
}

enum QuizCategory: String, Codable{
    case red
    case green
    case blue
    case yellow
    case orange
}

