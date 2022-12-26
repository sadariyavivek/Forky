//
//  CardView.swift
//  Forky
//
//  Created by Vivek Patel on 16/10/22.
//

import SwiftUI

struct CardView : View {
    @State private var isExpanded: Bool = false
    var data : Card
    
    var body: some View{
        VStack(spacing: 0) {
            Image(self.data.image)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
            HStack {
                Text(self.data.title)
                    .fontWeight(.regular)
                Spacer()
                Image("share")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .frame(width: 50, height: 50)
            }
            ExpandableText("Create a ZStack with unbounded height to allow the inner Text as much, Render the limited text and measure its size, Hide the background Indicates whether the text has been truncated in its display.", lineLimit: 2).padding(.top, -10)
            
        }.frame(maxWidth: .infinity)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(data: Card(id: 0, image: "postimage", title: "Zombie Gunship Survival", subTitile: "Tour the apocalypse"))
            .previewDevice("iPhone 11 Pro Max")
    }
}


struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
    @State private var shrinkText: String
    private var text: String
    let font: UIFont
    let lineLimit: Int
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? " read less" : " ... read more"
        }
    }
    
    init(_ text: String, lineLimit: Int, font: UIFont = UIFont.systemFont(ofSize: 12, weight: .ultraLight)) {
        self.text = text
        self.lineLimit = lineLimit
        _shrinkText =  State(wrappedValue: text)
        self.font = font
    }
    
    var body: some View {
        
        
        ZStack(alignment: .bottomLeading) {
            Group {
                        Text(self.expanded ? text : shrinkText)
                        .font(Font(font)) ///set default font
                        + Text(moreLessText)
                        .font(Font(UIFont.systemFont(ofSize: 12, weight: .bold)))
                        .foregroundColor(.black)
                
            }.animation(.easeInOut)
            .lineLimit(expanded ? nil : lineLimit)
                .background(
                    // Render the limited text and measure its size
                    Text(text).lineLimit(lineLimit)
                        .background(GeometryReader { visibleTextGeometry in
                            Color.clear.onAppear() {
                                let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                                let attributes:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font: font]
                                ///Binary search until mid == low && mid == high
                                var low  = 0
                                var heigh = shrinkText.count
                                var mid = heigh ///start from top so that if text contain we does not need to loop
                                while ((heigh - low) > 1) {
                                    let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                    let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                    if boundingRect.size.height > visibleTextGeometry.size.height {
                                        truncated = true
                                        heigh = mid
                                        mid = (heigh + low)/2
                                        
                                    } else {
                                        if mid == text.count {
                                            break
                                        } else {
                                            low = mid
                                            mid = (low + heigh)/2
                                        }
                                    }
                                    shrinkText = String(text.prefix(mid))
                                }
                                if truncated {
                                    shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  //-2 extra as highlighted text is bold
                                }
                            }
                        })
                        .hidden() // Hide the background
            )
            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack { //taking tap on only last line, As it is not possible to get 'see more' location
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
    }

}



// sample data for cards....

struct Card : Identifiable {
    
    var id : Int
    var image : String
    var title : String
    var subTitile : String
}
