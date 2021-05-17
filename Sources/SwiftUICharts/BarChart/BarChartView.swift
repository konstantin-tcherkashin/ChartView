//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private var data: ChartData
    public var title: String
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier:String
    public var animatedToBack: Bool

    public enum Legend {
        case top(String), bottom(String), none
    }

    public var legend: Legend = .none
    public var showLabel: Bool = false

    public init(data:ChartData, title: String, legend: Legend = .none, style: ChartStyle = Styles.barChartStyleOrangeLight, valueSpecifier: String? = "%.1f", animatedToBack: Bool = false){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.barChartStyleOrangeDark
        self.valueSpecifier = valueSpecifier!
        self.animatedToBack = animatedToBack
    }
    
    public var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(self.title)
                    .font(.headline)
                    .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                if case let .top(string) = legend {
                    Text(string)
                        .font(.callout)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor)
                        .transition(.opacity)
                        .animation(.easeOut)
                }
                Spacer()
            }.padding()
            BarChartRow(data: data.points.map{$0.1},
                        accentColor: self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor,
                        gradient: self.colorScheme == .dark ? self.darkModeStyle.gradientColor : self.style.gradientColor,
                        touchLocation: .constant(-1))
            if case let .bottom(string) = legend {
                Text(string)
                    .font(.headline)
                    .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                    .padding()
            }
        }
    }
}
