//
//  StartList.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct StartList: View {
    var color: Color
    var titletext: String
    var imagename: String
    var useSFSymbol: Bool
    var body: some View {
        let heightRatio: CGFloat = 0.2
        ZStack {
            HStack {
                Text(titletext)
                    .font(.title)
                    .fontWeight(.bold)
                if useSFSymbol {
                    Image(systemName: imagename)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                else {
                    Image(imagename)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(color)
                .frame(height: UIScreen.main.bounds.height * heightRatio)
                .opacity(0.5)
        }
    }
}

struct StartList_Previews: PreviewProvider {
    static var previews: some View {
        StartList(color: .blue, titletext: "Start", imagename: "darts", useSFSymbol: false)
    }
}
