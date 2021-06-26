//
//  Question.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import Foundation
class Question {
    let questionImage: String
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let correctAnswer: Int
    let jawabanQuiz : String
    
    init(image: String, questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, answer: Int, jawaban: String){
        questionImage = image
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        correctAnswer = answer
        jawabanQuiz = jawaban
    }
}
