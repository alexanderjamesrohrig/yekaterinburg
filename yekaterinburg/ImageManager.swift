//
//  ImageManager.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/6/24.
//

import Foundation
import SwiftUI

/// System images used within the app
class ImageManager {
    static let shared = ImageManager()
    let ff = "flag.2.crossed.fill"
    /// Used to signify multiple teams
    let teams = "person.2.crop.square.stack"
    /// Used to signify baseball
    let baseball = "figure.baseball"
    /// Used to signify football, college and professional
    let football = "figure.american.football"
    /// Used to signify a teams schedule
    let schedule = "calendar"
    /// Used to signify user can refresh data
    let refresh = "arrow.clockwise"
    /// Used to signify the Sports tab within Apple News
    let appleNews = "sportscourt.fill"
    /// Used to signify manually adding a scheduled game
    let add = "plus"
    /// Used to signify hockey
    let hockey = "figure.hockey"
    /// Used to signify SettingsView
    let settings = "gear"
    /// Used to signify radio options
    let radio = "radio"
    /// Used to signify television options
    let tv = "tv"
    /// Used to signify no available television options
    let noTV = "tv.slash"
    /// NHL URL Ex :- https://assets.nhle.com/logos/nhl/svg/NYI_light.svg
    /// MLS URL Ex :- https://images.mlssoccer.com/image/upload/assets/logos/TOR.svg
    /// NBA URL Ex :- https://cdn.nba.com/logos/nba/1610612745/primary/L/logo.svg
    /// MLB URL Ex :- https://www.mlbstatic.com/team-logos/team-cap-on-light/147.svg
    
    public func teamLogo(for sport: YeType, id: Int) -> Image? {
        switch sport {
        case .event:
            return nil
        case .game(let game):
            switch game {
            case .baseball:
                return Image("\(StringManager.shared.baseballPrefix)\(id)")
            case .basketball:
                return Image("\(StringManager.shared.basketballPrefix)\(id)")
            case .hockey:
                return Image("\(StringManager.shared.hockeyPrefix)\(id)")
            case .calcio:
                return Image("\(StringManager.shared.soccerPrefix)\(id)")
            case .collegeFootball:
                return nil // TODO:
            case .football:
                return nil // TODO:
            }
        }
    }
    
    public func mlbCrestName(for id: Int) -> String? {
        switch id {
        case 108...121:
            return "\(SM.shared.baseballPrefix)\(id)"
        case 134...147:
            return "\(SM.shared.baseballPrefix)\(id)"
        case 158:
            return "\(SM.shared.baseballPrefix)\(id)"
        case 586:
            return "\(SM.shared.baseballPrefix)\(id)"
        default:
            return nil
        }
    }
    
    private init() {}
}
