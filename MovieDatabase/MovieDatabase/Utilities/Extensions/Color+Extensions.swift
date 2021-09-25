//
//  Color+Extensions.swift
//  MovieDatabase
//
//  Created by Nilaakash Singh on 25/09/21.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue:  .random(in: 0...1))
    }
}
