//
//  BlurbView.swift
//  LevelUp_19
//
//  Created by Reem Alghamdi on 20/08/1447 AH.
//

import SwiftUI

// MARK: - Custom Curved Shape
struct HeaderCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.75))
        // This creates the sweeping curve from right to left
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.height),
                          control: CGPoint(x: rect.width * 0.5, y: rect.height * 1.05))
        path.closeSubpath()
        return path
    }
}

struct StoryIntroView: View {
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Section with Custom Curve
            ZStack(alignment: .top) {
                Image("storyCover1") // Replace with your image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.55)
                    .clipShape(HeaderCurve())
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Top Navigation Bar
                HStack {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .background(Circle().fill(Color.black.opacity(0.4)))
                        
                        Spacer()
                        
                        Text("Story Title")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .frame(width: 280, height: 50)
                    .background(Capsule().fill(Color.white.opacity(0.9)))
                    
                    Spacer()
                    
                    // Translation Button
                    Button(action: {}) {
                        Image(systemName: "character.bubble.fill")
                            .font(.title2)
                            .padding(12)
                            .background(Circle().fill(Color.white.opacity(0.9)))
                            .foregroundColor(.black)
                            .shadow(radius: 2)
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }
            
            // MARK: - Bottom Content Section
            VStack(spacing: 35) {
                Spacer()
                
                // Description Text
                Text("This text is written to explain more about this story, you can kno more here about this story and can have a look when you start reading.")
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
                
                // Bottom Buttons
                HStack(spacing: 20) {
                    Button(action: {}) {
                        Text("Start Reading")
                            .frame(width:186 , height: 54)
                            .font(.headline)
                            .foregroundColor(.black)
//                            .padding(.vertical, 18)
//                            .padding(.horizontal, 40)
                            .background(
                                Capsule()
                                    .fill(LinearGradient(colors: [Color.yellow.opacity(0.5), .yellow], startPoint: .top, endPoint: .bottom))
                            )
                            .shadow(color: .yellow.opacity(0.3), radius: 10, y: 5)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "star")
                            .font(.title2)
                            .padding(15)
                            .background(Color(.clear))
                            .glassEffect(.clear)
                            .foregroundColor(.black)
//                            .shadow(color: .black.opacity(0.1), radius: 5)
                    }
                }
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.white))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    StoryIntroView()
}
