//
//  SegementView.swift
//  Forky
//
//  Created by Vivek Patel on 16/10/22.
//

import SwiftUI

struct SegementView: View {
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    @State private var slcValue = "Recent"
    var values = ["Recent", "Menu", "Photos", "Special"]
    
    var body: some View {
        Picker("", selection: $slcValue) {
            ForEach(values, id: \.self) {
                Text($0)
            }
        }.pickerStyle(SegmentedPickerStyle())
        
    }
}

struct SegementView_Previews: PreviewProvider {
    static var previews: some View {
        SegementView()
    }
}
