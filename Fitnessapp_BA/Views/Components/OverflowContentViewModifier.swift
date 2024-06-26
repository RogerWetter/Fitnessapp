//
//  OverflowContentViewModifier.swift
//  Fitnessapp_BA
//
//  Copied by roger wetter on 13.05.2024 from https://stackoverflow.com/questions/62463142/make-scrollview-scrollable-only-if-it-exceeds-the-height-of-the-window.
//
//
//  Usage:
//  VStack {
//   // Your content
//  }
//  .scrollOnOverflow()

import SwiftUI

struct OverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow: Bool = false
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
            .background(
                GeometryReader { contentGeometry in
                    Color.clear.onAppear {
                        contentOverflow = contentGeometry.size.height > geometry.size.height
                    }
                }
            )
            .wrappedInScrollView(when: contentOverflow)
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView {
                self
            }
        } else {
            self
        }
    }
}

extension View {
    func scrollOnOverflow() -> some View {
        modifier(OverflowContentViewModifier())
    }
}
