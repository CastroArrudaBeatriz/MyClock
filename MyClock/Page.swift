//
//  Page.swift
//  MyClock
//
//  Created by Beatriz Castro on 25/04/21.
//

import Foundation

enum Page: Int, CaseIterable {
    case pageOne
    case pageTwo
    case pageThree
    case pageFour

    var index: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .pageOne:
            return "Este é o MyClock! um timer de segundos, arraste para o lado para ver nossas funcionalidades!"
        case .pageTwo:
            return "Você pode escolher a quantidade de segundos do seu timer"
        case .pageThree:
            return "Ao término caso o MyClock esteja fechado será enviada uma notificação."
        case .pageFour:
            return "Ao girar a tela do seu celular a imagem do relógio é mudada"
        }
    }
    
    var image: String {
        switch self {
        case .pageOne:
            return "intro_image"
        case .pageTwo:
            return "timer_image"
        case .pageThree:
            return "notification_image"
        case .pageFour:
            return "rotate_screen_image"
        }
    }
}
