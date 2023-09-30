//
//  Question.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation

//enum QuestionType<T: Hashable>: Hashable {
//    case singleAnswer(T)
//    case multiAnswer(T)
//    
//    var value: T {
//        switch self {
//        case .singleAnswer(let value): return value
//        case .multiAnswer(let value): return value
//        }
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        switch self {
//        case .singleAnswer(let value): hasher.combine(value.hashValue)
//        case .multiAnswer(let value): hasher.combine(value.hashValue)
//        }
//    }
//    
//    static func ==(lhs: Self, rhs: Self)-> Bool {
//        switch (lhs, rhs) {
//        case (.singleAnswer(let lhsValue), .singleAnswer(let rhsValue)):
//            return lhsValue == rhsValue
//        case (.singleAnswer(let lhsValue), .multiAnswer(let rhsValue)):
//            return lhsValue == rhsValue
//        case (.multiAnswer(let lhsValue), .singleAnswer(let rhsValue)):
//            return lhsValue == rhsValue
//        case (.multiAnswer(let lhsValue), .multiAnswer(let rhsValue)):
//            return lhsValue == rhsValue
//        }
//    }
//}
