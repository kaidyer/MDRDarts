//
//  BoardViewModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/27/23.
//

import Foundation
import SwiftUI

class BoardViewModel: ObservableObject {
    
    // let startAngles: [Double] = [81, 63,45,27,9,-9,-27,-45,-63,-81,-99,-117,-135,-153,-171,-189,-207,-225,-243,-261]
    let startAngles1: [Double] = [63, 27, -9, -45, -81, -117, -153, -189, -225, -261]
    let startAngles2: [Double] = [81, 45, 9, -27, -63, -99, -135, -171, -207, -243]
    
    let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
    let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
    
    private static func createBoardModel() -> BoardModel {
        BoardModel()
    }
    
    @Published private var model: BoardModel = createBoardModel()
    
    var colors: [colorList] {
        return model.colors
    }

}
