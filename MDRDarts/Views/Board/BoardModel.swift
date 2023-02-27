//
//  BoardModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/27/23.
//

import Foundation
import SwiftUI

struct BoardModel {
    var myWhite: Color
    var myBlack: Color
    var myRed: Color
    var myGreen: Color
    
    var colorList1: [Color]
    var colorList2: [Color]
    
    init() {
        self.myWhite = Color(red: 0.96, green: 0.894, blue: 0.796)
        self.myBlack = Color(red: 0.1019, green: 0.10588, blue: 0.1254)
        self.myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
        self.myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
        self.colorList1 = [myRed, myBlack, myRed, myBlack]
        self.colorList2 = [myGreen, myWhite, myGreen, myWhite]
    }
}
