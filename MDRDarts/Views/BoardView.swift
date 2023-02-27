//
//  BoardView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/26/23.
//

import SwiftUI

struct BoardView: View {
    let startAngles: [Double] = [81, 63,45,27,9,-9,-27,-45,-63,-81,-99,-117,-135,-153,-171,-189,-207,-225,-243,-261]
    var body: some View {
        ZStack {
            ForEach(startAngles, id: \.self) {
                startAngle in SegmentView(start: startAngle, end: startAngle + 18)
            }
            Circle()
                .stroke(.black)
                .background(Circle().fill(.gray))
                .frame(width: 50)
            Circle()
                .stroke(.black)
                .background(Circle().fill(.black))
                .frame(width: 25)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
