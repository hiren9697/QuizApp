//
//  QuestionType.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 30/09/23.
//

import Foundation

public enum QuestionType<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multiAnswer(T)
    
    public var value: T {
        switch self {
        case .singleAnswer(let value): return value
        case .multiAnswer(let value): return value
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value): hasher.combine(value.hashValue)
        case .multiAnswer(let value): hasher.combine(value.hashValue)
        }
    }
    
    public static func ==(lhs: Self, rhs: Self)-> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let lhsValue), .singleAnswer(let rhsValue)):
            return lhsValue == rhsValue
        case (.singleAnswer(let lhsValue), .multiAnswer(let rhsValue)):
            return lhsValue == rhsValue
        case (.multiAnswer(let lhsValue), .singleAnswer(let rhsValue)):
            return lhsValue == rhsValue
        case (.multiAnswer(let lhsValue), .multiAnswer(let rhsValue)):
            return lhsValue == rhsValue
        }
    }
}
