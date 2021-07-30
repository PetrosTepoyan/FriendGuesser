//
//  Question.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/17/21.
//

import Foundation

enum QuestionType {
	case selfDescribing, basic
}

class Question {
	var type: QuestionType!
	var content: String!
	var answer: String?
}
