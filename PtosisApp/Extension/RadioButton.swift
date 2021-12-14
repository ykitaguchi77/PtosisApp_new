//
//  RadioButton.swift
//  PtosisApp
//
//  Created by Yoshiyuki Kitaguchi on 2021/12/14.
//

import SwiftUI

struct RadioButtonModel: Identifiable, Hashable {
    let id = UUID()
    let index: Int
    let text: String
    
    init(index: Int, text: String) {
        self.index = index
        self.text = text
    }
}

struct RadioButton: View {
    
    enum Axis {
        case horizontal
        case vertical
    }
    
    @Binding var selectedIndex: Int
    private let axis: Axis
    private let title1: String
    private let title2: String
    private var models: [RadioButtonModel] = []
    
    init(selectedIndex: Binding<Int>, axis: Axis, title1: String, title2: String,texts: [String]) {
        self._selectedIndex = selectedIndex
        self.axis = axis
        self.title1 = title1
        self.title2 = title2
        
        var index = 0
        texts.forEach { text in
            let model = RadioButtonModel(index: index, text: text)
            models.append(model)
            index += 1
        }
    }
    
    var body: some View {
        if axis == .vertical {
            return configureVertical()
        } else {
            return configureHorizontal()
        }
    }
    
    private func configureHorizontal() -> AnyView {
        return AnyView(
            HStack {
                configure()
            }
        )
    }
    
    private func configureVertical() -> AnyView {
        return AnyView(
            VStack(alignment: .leading) {
                configure()
            }
        )
    }
    
    private func configure() -> AnyView {
        return AnyView(
            VStack{
                Text(self.title1)
                    .foregroundColor(.black)
                Text(self.title2)
                    .foregroundColor(.black)
                ForEach(models) { model in
                    HStack {
                        if model.index == self.selectedIndex {
                            ZStack {
                                Circle()
                                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20, height: 20)
                                Circle()
                                    .fill(Color.accentColor)
                                    .frame(width: 12, height: 12)
                            }
                        } else {
                            Circle()
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                                .frame(width: 20, height: 20)
                        }
                        Text(model.text)
                            .foregroundColor(.black)
                    }
                    .onTapGesture {
                        self._selectedIndex.wrappedValue = model.index
                    }
                }
            }
        )
    }
}
