//
//  HKWorkoutType+Ext.swift
//  FitnessApp
//
//  Created by Thành Trung on 14/1/25.
//

import HealthKit
import SwiftUI

extension HKWorkoutActivityType {
    
    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"
            
            // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"
            
            // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"
            
            // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"
            
            // Catch-all
        default:                            return "Other"
        }
    }
    var image: String {
        switch self {
        case .americanFootball:             return "football"
        case .archery:                      return "archery"
        case .australianFootball:           return "flag.2.crossed"
        case .badminton:                    return "sportscourt"
        case .baseball:                     return "baseball"
        case .basketball:                   return "basketball"
        case .bowling:                      return "bowl"
        case .boxing:                       return "boxing.glove"
        case .climbing:                     return "figure.climbing"
        case .cycling:                      return "bicycle"
        case .dance:                        return "figure.dance"
        case .hiking:                       return "figure.hiking"
        case .running:                      return "figure.run"
        case .rowing:                       return "figure.rowing"
        case .swimming:                     return "figure.swim"
        case .tennis:                       return "tennis.racket"
        case .volleyball:                   return "volleyball"
        case .walking:                      return "figure.walk"
        case .yoga:                         return "figure.yoga"
        case .snowboarding:                 return "figure.snowboarding"
        case .downhillSkiing:               return "figure.skiing.downhill"
        case .taiChi:                       return "figure.mind.and.body"
        case .highIntensityIntervalTraining: return "flame"
        case .kickboxing:                   return "figure.kickboxing"
        default:                            return "star"
        }
    }
    
    var color: Color {
        let symbolColor: Color
        switch self {
        case .americanFootball:             return .brown
        case .archery:                      return .green
        case .australianFootball:           return .orange
        case .badminton:                    return .blue
        case .baseball:                     return .red
        case .basketball:                   return .orange
        case .bowling:                      return .gray
        case .boxing:                       return .red
        case .climbing:                     return .purple
        case .cycling:                      return .yellow
        case .dance:                        return .pink
        case .hiking:                       return .green
        case .running:                      return .blue
        case .rowing:                       return .cyan
        case .swimming:                     return .teal
        case .tennis:                       return .green
        case .volleyball:                   return .orange
        case .walking:                      return .blue
        case .yoga:                         return .purple
        case .snowboarding:                 return .white
        case .downhillSkiing:               return .white
        case .taiChi:                       return .mint
        case .highIntensityIntervalTraining: return .red
        case .kickboxing:                   return .orange
        default:                            return .gray
        }
    }
}
