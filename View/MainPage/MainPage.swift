import SwiftUI
import SwiftData

struct HomePageView: View {

    @StateObject private var viewModel = HomePageViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query var allStories: [Story]
    
    var onStoryTap: (Story) -> Void = { _ in }
    
    // Filter favorite stories
    private var favoriteStories: [Story] {
        allStories.filter { $0.isFavorite }
    }
    
    var body: some View {
        ZStack {
            
            Image("NightDay_Background")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) { // No spacing – we'll use divider padding and explicit spacers
                    TopHeroWidget(heroVM: viewModel.heroVM)
                        .padding(.top, 6)
                    
                    // Push the list down a little
                    Spacer().frame(height: 8)
                    
                    // Liked Stories section (only if favorites exist)
                    if !favoriteStories.isEmpty {
                        // Divider above Liked Stories
                        Divider()
                            .background(Color.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        
                        StoryRowView(
                            title: "Liked Stories",
                            stories: favoriteStories,
                            showFilterButton: false,
                            onStoryTap: onStoryTap
                        )
                        .padding(.horizontal, 16)
                        
                        // Divider below Liked Stories
                        Divider()
                            .background(Color.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                    }

                    // Genre rows
                    ForEach(Array(viewModel.genreNames.enumerated()), id: \.element) { index, genreName in
                        // 1. Calculate the filtered list for this specific row
                        let storiesInGenre = allStories.filter { story in
                            if genreName == "Favorite" {
                                // Logic for the 'Favorite' tab based on the star button
                                return story.isFavorite
                            } else {
                                // Logic for standard genres (Romance, Mystery, etc.)
                                return story.genre == genreName
                            }
                        }
                        
                        // 2. Only show the Row if there are stories to display
                        if !storiesInGenre.isEmpty {
                            StoryRowView(
                                title: genreName,
                                stories: storiesInGenre,
                                showFilterButton: index == 0,
                                onStoryTap: { story in
                                    onStoryTap(story)
                                }
                            )
                            .padding(.horizontal, 16)
                            
                            // Add white divider after each genre row except the last one
                            if index < viewModel.genreNames.count - 1 {
                                Divider()
                                    .background(Color.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 120)
                }
                .task {
                    StoriesLibrary.syncLibrary(in: modelContext)
                }
            }
        }
    }
}

private struct TopHeroWidget: View {
    let heroVM: HeroRingWidgetViewModel
    
    var body: some View {
        HStack() {
            HeroRingWidget(vm: heroVM)
                .padding(.top, 4)
            
            Color.clear
                .frame(width: 1, height: 1)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 10)
    }
}
    
private struct StoryRowView: View {
    let title: String
    let stories: [Story]
    var showFilterButton: Bool = true
    var onStoryTap: (Story) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // Tighter internal spacing
            Text(title)
                .font(.title2)
                .bold()
                .foregroundStyle(Color.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(stories) { story in
                        StoryCardButtonView(story: story) {
                            onStoryTap(story)
                        }
                    }
                }
            }
        }
    }
}

private struct StoryCardButtonView: View {
    let story: Story
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 86, height: 108)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(.white.opacity(0.12), lineWidth: 1)
                    )
                
                Image(story.storycover ?? "placeholder")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 86, height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .clipped()
                
                ProgressBar(progress: story.Readingprogress)
                    .padding(.bottom, 8)
            }
            
            Text(story.title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .frame(width: 86)
                .frame(height: 54, alignment: .top)
        }
        .onTapGesture {
            onTap()
        }
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

#Preview {
    HomePageView()
}
