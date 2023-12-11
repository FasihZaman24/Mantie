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
    @State private var titleText: String = "Share."
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true //This true value will only be added to the var if the app doesn't finds the "onboarding" key in the local storage. We have already defined it in the content view which means the value of this key from content view will be taken...
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - Header
                Spacer()
                
                VStack(spacing: 0) {
                    Text(titleText)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleText)
                    
                    Text("""
                            It's not how much we give but,
                            how much love we put into giving.
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
                    CircleGroupView(ShapeColor: .white,ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1) // To make the circle go in the opposite direction as of Image.
                        .blur(radius: abs(imageOffset.width / 7))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
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
                                            titleText = "Give."
                                        }
                                        
                                    }
                                }
                                .onEnded{gesture in
                                    //withAnimation{
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        titleText = "Share."
                                    }
                                    //}
                                    
                                }
                        
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        
                }
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
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed").opacity(0.8))
                            .frame(width: buttonOffset + 80)
                        
                        Spacer()
                    }//:HStack
                    
                    // CIRCLE (DRAGABLE)
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                            //playSound(sound: "chimeup", type: "mp3")
                                        }else{
                                            buttonOffset = 0
                                        }
                                        
                                    }
                                }
                        )
//                        .onTapGesture {
//                            isOnboardingViewActive = false
//                        }
                        
                        Spacer()
                    }
                }//:ZStack
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                
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



