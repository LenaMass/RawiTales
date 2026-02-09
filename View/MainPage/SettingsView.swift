//
//  SettingsView.swift
//  LevelUp_19
//
//  Created by Nuha  on 09/02/2026.
//

import SwiftUI

struct SettingsView: View {
    let symbolSet1: [String] = ["sun.max.fill", "moon.fill"]
    let symbolSet2: [String] = ["textformat.size.smaller", "textformat.size.smaller"]
    @Namespace private var namespace
    
    var body: some View {
   
        ZStack {
        
            VStack {
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        .bold()
                }
                
                
                //MARK: - Divider bellow the Title
                
                VStack {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(Color.white)
                }
                
                //MARK: - Mode Container
                HStack {
                    
                    Spacer()
                    Text("Mode")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        
                    
                    Spacer()
                    
                    GlassEffectContainer(spacing: 20.0) {
                        HStack(spacing: 20.0) {
                            ForEach(symbolSet1.indices, id: \.self) { item in
                                Button {
                                    print("Tapped on \(symbolSet1[item])")
                                                // Add your action here
                                    } label: {
                                                // 2. The icon remains the visual "Label"
                                Image(systemName: symbolSet1[item])
                                .frame(width: 80.0, height: 80.0)
                                .font(.system(size: 36))
                                .foregroundStyle(.white) // Ensure the icon is visible
                                .glassEffect() // make it a glasseffect
                                .glassEffectUnion(id: item < 2 ? "1" : "2", namespace: namespace) // merges the two buttons together
                                }
                                .buttonStyle(.plain)
                                
                                
                            }
                        }
                    }
                    
                    Spacer()
                } // end of HStack that contains the GlassEffectContainer
                
            //MARK: - Divider bellow the Mode Stack
                
                VStack {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(Color.white)
                }
                
            //MARK: - Divider bellow the Dynamic Text Stack
                
                HStack {
                    
                    Spacer()
                    Text("Dynamic Text")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        
                    
                    Spacer()
                    
                    GlassEffectContainer(spacing: 20.0) {
                        HStack(spacing: 20.0) {
                            ForEach(symbolSet2.indices, id: \.self) { item in
                                Button {
                                    print("Tapped on \(symbolSet2[item])")
                                                // Add your action here
                                    } label: {
                                                // 2. The icon remains the visual "Label"
                                Image(systemName: symbolSet2[item])
                                .frame(width: 80.0, height: 80.0)
                                .font(.system(size: 36))
                                .foregroundStyle(.white) // Ensure the icon is visible
                                .glassEffect() // make it a glasseffect
                                .glassEffectUnion(id: item < 2 ? "1" : "2", namespace: namespace) // merges the two buttons together
                                }
                                .buttonStyle(.plain)
                                
                                
                            }
                        }
                    }
                    
                    Spacer()
                } // end of HStack that contains the GlassEffectContainer
                
                // Pass the existing viewModel here
            }
        }
        
        
        
    }
}

#Preview {
    SettingsView()
}
