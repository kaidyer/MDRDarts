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
    
    func getSegment(id: Int) -> colorList? {
        for color in model.colors {
            if color.id == id {
                return color
            }
        }
        return nil
    }
    
    func setYellow(slice: Int, block: Int) {
        let index: Int
        switch slice{
        case 20:
            index = 0
        case 1:
            index = 1
        case 18:
            index = 2
        case 4:
            index = 3
        case 13:
            index = 4
        case 6:
            index = 5
        case 10:
            index = 6
        case 15:
            index = 7
        case 2:
            index = 8
        case 17:
            index = 9
        case 3:
            index = 10
        case 19:
            index = 11
        case 7:
            index = 12
        case 16:
            index = 13
        case 8:
            index = 14
        case 11:
            index = 15
        case 14:
            index = 16
        case 9:
            index = 17
        case 12:
            index = 18
        case 5:
            index = 19
        default:
            index = 0
        }
        model.colors[index].colors[block] = Color(.yellow)
    }

}
