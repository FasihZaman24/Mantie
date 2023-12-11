//
//  LotteAnimationView.swift
//  Mantie
//
//  Created by Muhammad Fasih uz Zaman Siddiqui on 10/12/23.
//

//import SwiftUI
//import Lottie
//
//struct LottieAnimationView: UIViewRepresentable {
//    var filename: String
//
//    func makeUIView(context: Self.Context) -> UIView {
//        let view = UIView(frame: .zero)
//        let animationView = AnimationView()
//        animationView.animation = Animation.named(filename)
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .loop
//        animationView.play()
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {
//        // UIView update code
//    }
//}
//
//
//#Preview {
//    LotteAnimationView()
//}
