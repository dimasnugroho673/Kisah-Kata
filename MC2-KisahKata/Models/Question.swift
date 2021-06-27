//
//  Question.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import Foundation
class Question : Identifiable {
    let questionImage: String
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let correctAnswer: Int
    let jawabanQuiz : String
    
    init(image: String, questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, answer: Int, jawaban: String){
        self.questionImage = image
        self.question = questionText
        self.optionA = choiceA
        self.optionB = choiceB
        self.optionC = choiceC
        self.optionD = choiceD
        self.correctAnswer = answer
        self.jawabanQuiz = jawaban
    }
}
