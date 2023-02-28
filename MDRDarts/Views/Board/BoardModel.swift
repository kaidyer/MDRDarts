//
//  BoardModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/27/23.
//

import Foundation
import SwiftUI

struct BoardModel {
    
    let startAngles: [Double] = [81, 63,45,27,9,-9,-27,-45,-63,-81,-99,-117,-135,-153,-171,-189,-207,-225,-243,-261]
    let idList: [Int] = [20, 1, 18, 4, 13, 6, 10, 15, 2, 17, 3, 19, 7, 16, 8, 11, 14, 9, 12, 5]
    let myWhite = Color(red: 0.96, green: 0.894, blue: 0.796)
    let myBlack = Color(red: 0.1019, green: 0.10588, blue: 0.1254)
    let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
    let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
    
    var colors = [colorList]()
    
    init() {
        for index in 0...idList.count-1 {
            if index % 2 == 0 {
                self.colors.append(colorList(id: idList[index], degree: startAngles[index], colors: [myRed, myBlack, myRed, myBlack]))
            } else {
                self.colors.append(colorList(id: idList[index], degree: startAngles[index], colors: [myGreen, myWhite, myGreen, myWhite]))
            }
        }
    }
    
}
    
    // 2D array for colors of blocks
    // [[slice 1], [slice 2], ..., [slice n]]
    // where slice n = [color 1, color 2, ..., color 4]

struct colorList: Identifiable {
    var id: Int
    var degree: Double
    var colors: [Color]
}
