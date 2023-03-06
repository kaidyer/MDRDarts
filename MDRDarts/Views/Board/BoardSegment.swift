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
    var color: colorList
    
    var body: some View {
        let start = color.degree
        let end = start + 18
        let colorList = color.colors
        VStack {
            ZStack {
                PieSegment(start: .degrees(start), end: .degrees(end))
                    .stroke(.black)
                    .background(PieSegment(start: .degrees(start), end: .degrees(end)).fill(colorList[0]))
                    .frame(width: 350, height: 350)
                PieSegment(start: .degrees(start), end: .degrees(end))
                    .stroke(.black)
                    .frame(width: 325, height: 325)
                    .background(PieSegment(start: .degrees(start), end: .degrees(end)).fill(colorList[1]))
                PieSegment(start: .degrees(start), end: .degrees(end))
                    .stroke(.black)
                    .frame(width: 200, height: 200)
                    .background(PieSegment(start: .degrees(start), end: .degrees(end)).fill(colorList[2]))
                PieSegment(start: .degrees(start), end: .degrees(end))
                    .stroke(.black)
                    .frame(width: 180, height: 180)
                    .background(PieSegment(start: .degrees(start), end: .degrees(end)).fill(colorList[3]))
                //            Circle()
                //                .stroke(.black)
                //                .background(Circle().fill(.blue))
                //                .frame(width: 150, height: 150)
                
            }
        }
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        let myWhite = Color(red: 0.96, green: 0.894, blue: 0.796)
        let myBlack = Color(red: 0.1019, green: 0.10588, blue: 0.1254)
        let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
        let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
        let color1 = colorList(id: 20, degree: 81, colors: [myRed, myBlack, myRed, myBlack])
        let color2 = colorList(id: 1, degree: 63, colors: [myGreen, myWhite, myGreen, myWhite])
        ZStack{
            //SegmentView(color: color1)
            SegmentView(color: color2)
        }
    }
}
