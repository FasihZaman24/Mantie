//
//  SuggestionView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 07/12/23.
//


import SwiftUI

struct OnboardingView: View {
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1
    @State private var titleText: String = "MANTIÉ"
    @State private var currentImageName: String = "guy"
    @State private var isNavigating = false
    @State private var searchText = ""
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        
        
        ZStack {
            Color(.orangeM)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()
                
                VStack(spacing: 0) {
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .transition(.opacity)
                        .id(titleText)
                    
                    Text("""
                            Trust your luggage with Mantié
                            We help you to travel light!
                            
                            """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - Center
                ZStack{
                    CircleGroupView(ShapeColor: Color(.white),ShapeOpacity: 0.4)
                        .offset(x: imageOffset.width * -1) // To make the circle go in the opposite direction as of Image.
                        .blur(radius: abs(imageOffset.width / 7))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image(currentImageName)
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            titleText = "Travel"
                                            currentImageName = "guy"
                                        }
                                        
                                    }
                                }
                                .onEnded{gesture in
                                    //withAnimation{
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        titleText = "Light."
                                        currentImageName = "guy2"
                                    }
                                    //}
                                    
                                }
                        
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        
                }
                Spacer()
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                
                Spacer()
                
                //MARK: - Footer
                ZStack{
                    NavigationLink(destination: HomeView(), isActive: $isNavigating) {
                        EmptyView()}

                    VStack (spacing: 6){
//                        TextField("", text: $searchText, onCommit: { isNavigating = true })
//                            .foregroundColor(.black) // Text Color
//                            .padding(.leading, 40) // Padding to prevent icon from overlapping text
//                            .padding() // General Padding for the TextField
//                            .background(Color.white) // Background Color
//                            .cornerRadius(10) // Corner Radius
//                            .shadow(radius: 4) // Shadow
//                            .overlay(
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundColor(.gray)
//                                        .padding(.leading)
//                                    
//                                    // Placeholder Text
//                                    if searchText.isEmpty {
//                                        Text("Enter Location")
//                                            .foregroundColor(.gray)
//                                            .padding(.leading, 5)
//                                    }
//                                    
//                                    Spacer()
//                                }
//                            )
                        
                        
                        
                        Button(action: {
                            isNavigating = true
                            
                        }) {
                            Text("Check Nearby Stores")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(10)
                                .shadow(color: .red.opacity(0.5), radius: 10, x: 0, y: 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 2)
                                        .shadow(color: .white, radius: 10, x: -5, y: -5)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                                )
                        }
                        Spacer()
                    }
                   
                    

                }
                //:ZStack
                .frame(width: buttonWidth, height: 80, alignment: .center)
                
                
                Spacer()
                
                
            } //:VStack
        } //:ZStack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}



