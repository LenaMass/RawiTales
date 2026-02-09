import SwiftUI
import SwiftData

/*
struct HomePageView: View {
    @StateObject private var vm = HomePageViewModel()

    @StateObject private var savedStoryVM = SavedStoryViewModel()
    
    var onStoryTap: (Story) -> Void = { story in
        print("Tapped story:", story.title)
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    TopHeroWidget(heroVM: vm.heroVM)
                        .padding(.top, 6)

                    ForEach(Array(vm.genres.enumerated()), id: \.element.id) { index, genre in
                        VStack(spacing: 0) {
                            StoryRowView(genre: genre, showFilterButton: index == 0, onStoryTap: onStoryTap)
                                .padding(.horizontal, 16)

                            if index < vm.genres.count - 1 {
                                Divider()
                                    .background(Color.white)
                                    .padding(.vertical, 8)
                            }
                        }
                    }

                    Spacer().frame(height: 120)
                }
            }
        }
    }
}*/


// MARK: - New HomePage Struct

struct HomePageView: View {
    @StateObject private var vm = HomePageViewModel()
        // CHANGE 1: Create the single source of truth here
    @StateObject private var savedStoryVM = SavedStoryViewModel()
    
    var onStoryTap: (Story) -> Void = { story in
        print("Tapped story:", story.title)
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    TopHeroWidget(heroVM: vm.heroVM)
                        .padding(.top, 6)

                    ForEach(Array(vm.genres.enumerated()), id: \.element.id) { index, genre in
                                            VStack(spacing: 0) {
                                                // CHANGE 2: Pass the shared VM to the row
                                                StoryRowView(
                                                    genre: genre,
                                                    showFilterButton: index == 0,
                                                    onStoryTap: { story in
                                                        // Handle logic if needed
                                                    }
                                                )
                                                .padding(.horizontal, 16)
                                                // ... rest of your divider logic
                                            }
                                        }
                                        Spacer().frame(height: 120)
                }
            }
        }
    }
}



private struct TopHeroWidget: View {
    let heroVM: HeroRingWidgetViewModel

    var body: some View {
        HStack(alignment: .top) {
            Button {} label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 34, height: 34)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .buttonStyle(.plain)
            .background {
                Circle().fill(Color.clear).glassEffect(.clear)
            }
            .overlay {
                Circle().strokeBorder(.white.opacity(0.18), lineWidth: 1)
            }

            Spacer()

            HeroRingWidget(vm: heroVM)
                .padding(.top, 4)

            Spacer()

            Color.clear
                .frame(width: 34, height: 34)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 10)
    }
}

/*
private struct StoryRowView: View {
    let genre: StoryGenre
    let showFilterButton: Bool
    let onStoryTap: (Story) -> Void
    //  let title: String
    
    @StateObject var savedVM = SavedStoryViewModel()
        
     
       
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text(genre.name)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()

                if showFilterButton {
                    Button {} label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .buttonStyle(.plain)
                    .background {
                        Circle().fill(Color.clear).glassEffect(.clear)
                    }
                    .overlay {
                        Circle().strokeBorder(.white.opacity(0.18), lineWidth: 1)
                    }
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 33) {
                                // 2. Loop through the actual stories in your ViewModel
                                ForEach(savedVM.allStories) { storyItem in
                                    StoryCardButtonView(story: storyItem) {
                                        print("Tapped: \(storyItem.imageName)")
                                    }
                                }
                            }
                            .padding(.vertical, 4)
            }
        }
        .padding(.vertical, 6)
    }
}
*/


// MARK: - New StoryRow Struct


private struct StoryRowView: View {
    let genre: StoryGenre
    let showFilterButton: Bool
    let onStoryTap: (Story) -> Void
    //  let title: String
    
    
    @Query var savedStories: [SavedStoryData]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text(genre.name)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                
                if showFilterButton {
                    Button {} label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .buttonStyle(.plain)
                    .background {
                        Circle().fill(Color.clear).glassEffect(.clear)
                    }
                    .overlay {
                        Circle().strokeBorder(.white.opacity(0.18), lineWidth: 1)
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 33) {
                    ForEach(savedStories) { storyItem in
                        NavigationLink(destination: StoryDetailView(story: storyItem)) {
                            StoryCardButtonView(story: storyItem) {
                                // Optional: print("Tapped \(storyItem.imageName)")
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding(.vertical, 6)
        }
    }
    
    
    
    
    /*
     private struct StoryCardButtonView: View {
     let story: SavedStoryModel
     let onTap: () -> Void
     
     
     
     var body: some View {
     
     // adjusted new code
     
     Button(action: onTap) {
     VStack(spacing: 8) {
     ZStack(alignment: .bottom) {
     RoundedRectangle(cornerRadius: 16, style: .continuous)
     .fill(Color.white.opacity(0.08))
     .frame(width: 86, height: 108)
     .overlay(
     RoundedRectangle(cornerRadius: 16, style: .continuous)
     .strokeBorder(.white.opacity(0.12), lineWidth: 1)
     )
     
     // Use 'imageName' from your SavedStoryViewModel
     Image(story.imageName)
     .renderingMode(.original)
     .resizable()
     .scaledToFill()
     .frame(width: 86, height: 108)
     .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
     .clipped()
     
     // The white/black progress bar from your screenshot
     ProgressBar(progress: story.Readingprogress)
     .padding(.bottom, 8)
     }
     
     Text(story.imageName) // Using imageName as the title for now
     .font(.system(size: 12, weight: .semibold, design: .rounded))
     .foregroundStyle(.white.opacity(0.9))
     .lineLimit(1)
     .frame(width: 86)
     }
     }
     .buttonStyle(.plain)
     }
     
     }
     */
    
    // MARK: - New StoryCardButtonView Struct
    
    private struct StoryCardButtonView: View {
        let story: SavedStoryData
        let onTap: () -> Void
        
        
        
        var body: some View {
            
            // adjusted new code
            
            
            VStack(spacing: 8) {
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 86, height: 108)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
                        )
                    
                    // Use 'imageName' from your SavedStoryViewModel
                    Image(story.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 86, height: 108)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .clipped()
                    
                    // The white/black progress bar from your screenshot
                    ProgressBar(progress: story.Readingprogress)
                        .padding(.bottom, 8)
                }
                
                Text(story.imageName) // Using imageName as the title for now
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .frame(width: 86)
            }
            
            // .buttonStyle(.plain)
        }
        
    }
    
    
    
    struct ProgressBar: View {
        var progress: Int
        
        var body: some View {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(width: 70, height: 6)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.black)
                    .frame(width: CGFloat(progress) / 100 * 70, height: 6)
            }
        }
    }
}

#Preview {
    HomePageView()
        .background(.black)
}

