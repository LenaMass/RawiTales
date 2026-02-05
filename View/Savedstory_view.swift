//
//  Savedstory_view.swift
//  LevelUp_19
//
//  Created by Nuha  on 03/02/2026.
//

import SwiftUI
import Combine



struct Savedstory_view: View {
    
    // stories names from the asset file
    let myImages = ["UnforgivableStory", "BacktothemoonStory", "LittlewomanStory", "OverthegardenwallStory"]
    
        // 1. Define 3 equal columns
        let columns = [
            GridItem(.flexible(), spacing: 30),
            GridItem(.flexible(), spacing: 30),
            GridItem(.flexible(), spacing: 30)
        ]

    
    var body: some View {
        
        //MARK: - Main VStack
        ZStack{
            
        
                VStack{
                
                HStack{
                    // here to add a nvaigation view to see this page
                    /* Button(action: {
                     // Your code here
                     print("Button tapped!")
                     }) {
                     Image(systemName: "arrowshape.left.fill")
                     .buttonBorderShape(.circle)
                     .frame(width: 40, height: 40)
                     .font(.system(size: 40))
                     .glassEffect(.clear)
                     
                     }*/
                    
                    
                    
                    Text("Saved Stories")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        .bold()
                }
                
                // divider under the page title
                VStack{
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(Color.white)
                }
                
                //MARK: - VStack that holds the scrollbar of stories
                
                VStack{
                    
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(myImages, id: \.self) { imageName in
                                // 3. Your Image View
                                Image(imageName) // Replace with your image name
                                    .resizable()
                                    .scaledToFill()
                                //.frame(minWidth: 0, maxWidth: .infinity)
                                //.aspectRatio(1, contentMode: .fill) // Makes it a square
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(18) // Optional: rounded corners
                                    .clipped() // Ensures image doesn't bleed out of square
                                   
                                .background(
                                    VStack {
                                    Spacer() // Pushes the progress bar to the bottom of the 250pt frame
                                                        
                                                        // 2. Your Progress View
                                    ZStack(alignment: .leading) {
                                    Capsule()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 8) // Slimmer look like your screenshot
                                                            
                                    Capsule()
                                    .fill(Color.black)
                                    .frame(width: 50, height: 8) // Dynamic width here
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 15) // Adjust this to move bar up/down within the white
                                    }
                                                
                                        .frame(height: 180)
                                        .background(Color.white)
                                        .cornerRadius(18)
                                        , alignment: .top
                                    
                                    ) // end of the background
                                .padding(.bottom, 60)
                               
                          
                            }
                        }
                        .padding()
                        
                        
                        
                    }
                }
                
                
                
                
                
            }// end of main VStack
              
                }
            
        }
           
                
     
           
            
        }
    
    


#Preview {
    Savedstory_view()
}

