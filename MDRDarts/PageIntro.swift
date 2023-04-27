//
//  PageIntro.swift
//  WalkthroughPageAnimation
//
//  Created by 山本響 on 2023/04/03.
//

import SwiftUI

/// Page Intro Model
struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displaysAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "Page 1", title: "First to Reach\n0 Points Wins!", subTitle: "Start at 501 points and work your way down."),
    .init(introAssetImage: "Page 2", title: "The Outer Ring is Worth Double Points", subTitle: "Multiply the number on the border times 2 to get your score."),
    .init(introAssetImage: "Page 2", title: "The Inner Ring is Worth Triple Points", subTitle: "Multiply the number on the border times 3 to get your score."),
    .init(introAssetImage: "Page 1", title: "You Must Get Exactly 0 Points", subTitle: "If you score more than you have points left, it does not count!", displaysAction: true)
]
