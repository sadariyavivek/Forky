//
//  RestoDetailView.swift
//  Forky
//
//  Created by Vivek Patel on 17/09/22.
//

import SwiftUI

struct RestoDetailView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Home()
        .navigationBarHidden(true)
    }
}

struct RestoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestoDetailView()
            .previewDevice("iPhone 11 Pro Max")
    }
}


struct Home : View {
    
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State var show = false
    
    var body: some View{
        let divider = 3.3
        ZStack(alignment: .top, content: {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                ZStack {
                    VStack(spacing: 0){
                        SliderView(show: $show).padding(.bottom, -24)
                        VStack{
                            RestDetailName()
                            VStack(spacing: 30){
                                ForEach(data){ i in
                                    CardView(data: i)
                                }
                            }
                            .padding(.top)
                            Divider()
                            Text("You may also like")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(0..<10) { index in
                                        RecomendedRestoView(label: "\(index)")
                                    }
                                }
                            }.frame(height: 200)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(24, corners: [.topRight, .topLeft])
                        Spacer()
                    }
                }
            })
            
            if self.show{
                TopView(isShow: true)
                    .background(Color.white
                        .shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                                .mask(Rectangle().padding(.bottom, -8)))
            } else {
                TopView(isShow: false).background(Color.clear)
            }
        })
        .edgesIgnoringSafeArea(.top)
    }
}

// CardView...


// TopView...

struct TopView : View {
    var isShow: Bool = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        
        HStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
            }
            Text("Arcade")
                .font(.headline)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
                .opacity(isShow ? 1 : 0)
            Spacer(minLength: 0)
            Button(action: {
                print("Test Call")
            }) {
                Image("call")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .opacity(isShow ? 1 : 0)
                    .frame(width: 50, height: 50)
            }
        }
        // for non safe area phones padding will be 15...
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct SliderVideo : View {
    var body: some View{
        Group {
            HStack{
                Image("camera")
                    .frame(width: 50, height: 50)
                Text("Video tour of the place")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, -10)
                Spacer(minLength: 0)
                Button(action: {
                    print("button pressed")
                }) {
                    Image("videoOrange")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .frame(width: 50, height: 50)
                }
            }
            
        }.background(VisualEffect(style: .systemChromeMaterialDark))
            .cornerRadius(6.0)
            .padding(.horizontal, 20)
    }
}

struct SliderVideoIndicator : View {
    var body: some View{
        HStack{
            Capsule()
            .fill(.white)
            .frame(width: 50, height: 4)
            Capsule()
            .fill(.white)
            .opacity(0.5)
            .frame(width: 20, height: 4)
            Capsule()
            .fill(.white)
            .opacity(0.5)
            .frame(width: 20, height: 4)
            Capsule()
            .fill(.white)
            .opacity(0.5)
            .frame(width: 20, height: 4)
        }.padding()
    }
}

struct AmenityView : View {
    let imgName:String
    let title:String
    
    var body: some View{
        HStack(spacing: 0){
            Image(imgName)
                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                .frame(width: 30, height: 30)
            Text(title)
                .font(.headline)
                .fontWeight(.light)
        }
    }
}

struct SliderView : View {
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @Binding var show: Bool
    var height:CGFloat = 400.0
    var body: some View{
        GeometryReader { geometry in
            ImageCarouselView(numberOfImages: 3) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .overlay(TintOverlay().opacity(0.75))
            .onReceive(self.time) { (_) in
                // its not a timer...
                // for tracking the image is scrolled out or not...
                let y = geometry.frame(in: .global).minY

                if -y > height - 50{
                    withAnimation{
                        self.show = true
                    }
                }
                else{
                    withAnimation{
                        self.show = false
                    }
                }
            }
        }
        .frame(height: height, alignment: .center)
        .overlay(
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    Color.clear
                    SliderVideo()
                }
                SliderVideoIndicator()
            }.padding(.bottom, 24)
        )
    }
}


struct ImageCarouselView<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content

    @State private var currentIndex: Int = 0
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
            .animation(.spring())
            .onReceive(self.timer) { _ in
                
                self.currentIndex = (self.currentIndex + 1) % 3
            }
        }
    }
}

var data = [

    Card(id: 0, image: "postimage", title: "Zombie Gunship Survival", subTitile: "Tour the apocalypse"),
    Card(id: 1, image: "postimage", title: "Portal", subTitile: "Travel through dimensions"),
]

struct RestDetailName: View {
    var body: some View {
        
        VStack {
            HStack{
                Text("Singh Saab")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Button(action: {
                    print("button pressed")
                }) {
                    Image("call")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .frame(width: 50, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            )
                        .padding(.bottom, 100)
                }.frame(width: 48, height: 48)
            }
            Text("Club & Lounge")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
            Text("Mughalai, North Indian, Continental")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 0)
            HStack {
                Text("Koregaon Parkl")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack(spacing: 0)  {
                    Image("pin")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .frame(width: 30, height: 30)
                    Text("Locate")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .underline()
                }
            }
            HStack{
                Text("5pm - 12:30pm (Today)")
                    .font(.headline)
                    .fontWeight(.light)
                Image("dropDown")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .frame(width: 30, height: 30)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10){
                AmenityView(imgName: "pin", title: "Pure Veg")
                AmenityView(imgName: "pin", title: "Pet Friendly")
                AmenityView(imgName: "pin", title: "Wifi Available")
            }.frame(maxWidth: .infinity, alignment: .leading)
            SegementView()
        }
    }
}


struct VisualEffect: UIViewRepresentable {
    @State var style : UIBlurEffect.Style // 1
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style)) // 2
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    } // 3
}


extension Color {
  static var gradient: Array<Color> {
    return [
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 1.0),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.7),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.5),
      Color(red: 37/255, green: 37/255, blue: 37/255, opacity: 0.2),
      Color(red: 5/255, green: 5/255, blue: 5/255, opacity: 1.0)
    ]
  }
}

struct TintOverlay: View {
  var body: some View {
    ZStack {
      Text(" ")
        .foregroundColor(.white)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(
      LinearGradient(gradient: Gradient(colors: Color.gradient), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    )
  }
}


struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}


