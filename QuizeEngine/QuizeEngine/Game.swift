//
//  Game.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation

public class Game<Question: Hashable,
                  Answer: Hashable,
                  R: Router> where R.Question == Question,
                                   R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question: Hashable,
                      Answer: Hashable,
                      R: Router>(questions: [Question],
                                 router: R,
                                 correctAnswers: [Question: Answer]
                      )-> Game<Question, Answer, R> where R.Question == Question,
                                                          R.Answer == Answer
{
    let flow = Flow(questions: questions,
                    router: router,
                    scoring: { scoring(answers: $0,
                                       correctAnswers: correctAnswers) })
    let game = Game(flow: flow)
    flow.start()
    return game
}

private func scoring<Question: Hashable,
                     Answer: Hashable>(answers: [Question: Answer],
                                        correctAnswers: [Question: Answer])-> Int {
    return answers.reduce(0) { partialResult, answer in
        return partialResult + (correctAnswers[answer.key] == answer.value ? 1 : 0)
    }
}
