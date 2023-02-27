//
//  BoardView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/26/23.
//

import SwiftUI

struct BoardView: View {
    // let startAngles: [Double] = [81, 63,45,27,9,-9,-27,-45,-63,-81,-99,-117,-135,-153,-171,-189,-207,-225,-243,-261]
    let startAngles1: [Double] = [63, 27, -9, -45, -81, -117, -153, -189, -225, -261]
    let startAngles2: [Double] = [81, 45, 9, -27, -63, -99, -135, -171, -207, -243]
    
    let myWhite = Color(red: 0.96, green: 0.894, blue: 0.796)
    let myBlack = Color(red: 0.1019, green: 0.10588, blue: 0.1254)
    let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
    let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
    
    var body: some View {
        let colorList1: [Color] = [myRed, myBlack, myRed, myBlack]
        let colorList2: [Color] = [myGreen, myWhite, myGreen, myWhite]
        ZStack {
            ForEach(startAngles1, id: \.self) {
                startAngle in SegmentView(start: startAngle, end: startAngle + 18, colorList: colorList1)
            }
            ForEach(startAngles2, id: \.self) {
                startAngle in SegmentView(start: startAngle, end: startAngle + 18, colorList: colorList2)
            }
            Circle()
                .stroke(.black)
                .background(Circle().fill(myGreen))
                .frame(width: 50)
            Circle()
                .stroke(.black)
                .background(Circle().fill(myRed))
                .frame(width: 25)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
