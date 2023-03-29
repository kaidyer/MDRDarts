//
//  TutorialView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 3/9/23.
//

import SwiftUI

struct TutorialView: View {
    
    var body: some View {
        VStack{
            HStack{
                Text("Game Mode: 201/501")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.leading)
                Spacer()
            }
            ScrollView {
                Text("In 201/501, the goal is to reach exactly 0 points.")
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
