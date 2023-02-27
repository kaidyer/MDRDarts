//
//  BoardViewModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/27/23.
//

import Foundation
import SwiftUI

class BoardViewModel: ObservableObject {
    
    private static func createBoardModel() -> BoardModel {
        BoardModel()
    }
    
    @Published private var model: BoardModel = createBoardModel()
    
    var colorList1: [Color] {
        return model.colorList1
    }
    
    var colorList2: [Color] {
        return model.colorList2
    }
}
