//
//  BoardSegment.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/24/23.
//

import Foundation
import SwiftUI


struct PieSegment: Shape {
    var start: Angle
    var end: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let rotationAdjust = Angle.degrees(360)
        let modifiedStart = rotationAdjust - start
        let modifiedEnd = rotationAdjust - end
        
        path.move(to: center)
        path.addArc(center: center, radius: rect.midX, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: true)
        path.addLine(to: center)
        return path
    }
}

struct SegmentView: View {
    @State var fileData: Data?
    var start: Double
    var end: Double
    
    var body: some View {
        ZStack {
            PieSegment(start: .degrees(start), end: .degrees(end))
                .stroke(.black)
                .frame(width: 350, height: 350)
            PieSegment(start: .degrees(start), end: .degrees(end))
                .stroke(.black)
                .frame(width: 325, height: 325)
            PieSegment(start: .degrees(start), end: .degrees(end))
                .stroke(.black)
                .frame(width: 200, height: 200)
            PieSegment(start: .degrees(start), end: .degrees(end))
                .stroke(.black)
                .frame(width: 180, height: 180)
//            Circle()
//                .stroke(.black)
//                .background(Circle().fill(.blue))
//                .frame(width: 150, height: 150)
            
        }
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            SegmentView(start: 81, end: 99)
            SegmentView(start:-261, end: -243)
        }
    }
}
