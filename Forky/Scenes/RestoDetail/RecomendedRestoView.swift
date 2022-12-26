//
//  RecomendedRestoView.swift
//  Forky
//
//  Created by Vivek Patel on 16/10/22.
//

import SwiftUI

struct RecomendedRestoView: View {
    @State var label: String
    
    var body: some View {
        ZStack {
            Image("recomemended")
                .resizable()
                .frame(width: 175, height: 175)
            Text(label)
        }
    }
}

struct RecomendedRestoView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendedRestoView(label: "")
    }
}

