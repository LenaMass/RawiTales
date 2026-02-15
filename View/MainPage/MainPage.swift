import SwiftUI
import SwiftData



// MARK: - New HomePage Struct
struct HomePageView: View {

    @StateObject private var viewModel = HomePageViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query var allStories: [Story]
    
    // Track the selected story to trigger navigation
    @State private var selectedStory: Story?
    
   
    var body: some View {
        
        
        NavigationStack { // 1. Wrap everything in a Stack
            
            ZStack {
                
                Image("NightDay_Background")
                .resizable()
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        TopHeroWidget(heroVM: viewModel.heroVM)
                            .padding(.top, 6)

                        ForEach(Array(viewModel.genreNames.enumerated()), id: \.element) { index, genreName in
                            let storiesInGenre = allStories.filter { $0.genre == genreName }
                            
                            if !storiesInGenre.isEmpty {
                                StoryRowView(
                                    title: genreName,
                                    stories: storiesInGenre,
                                    showFilterButton: index == 0,
                                    onStoryTap: { story in
                                        // 2. Set the selected story when tapped
                                        selectedStory = story
                                    }
                                )
                                .padding(.horizontal, 16)
                            }
                        }
                        
                        Spacer().frame(height: 120)
                    }
                    .task {
                        StoriesLibrary.syncLibrary(in: modelContext)
                    }
                }
            }
            // 3. Define WHERE to go when a story is selected
            .navigationDestination(item: $selectedStory) { story in
                StoryView(story: story)
            }
        }
    }
}
    
    
    
    
    
    
    private struct TopHeroWidget: View {
        let heroVM: HeroRingWidgetViewModel
        
        // for settings
        @State private var showSettings = false
        @EnvironmentObject var settings: AppSettings

        var body: some View {
            HStack(alignment: .top) {
                Button {
                    showSettings = true
                } label: {
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
            
            .sheet(isPresented: $showSettings) {
                        SettingsView()
                            .environmentObject(settings) // IMPORTANT: Pass settings to the sheet
                    }
        }
    }
    
    
    // MARK: - New StoryRow Struct
    
    
private struct StoryRowView: View {
    let title: String
    let stories: [Story] // This accepts the filtered array
    var showFilterButton: Bool = true
    var onStoryTap: (Story) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundStyle(Color.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(stories) { story in
                        // Use your existing card view here
                        StoryCardButtonView(story: story) {
                            onStoryTap(story)
                        }
                    }
                    
                }
            }
        }
    }
}
    /*var body: some View {
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

           /ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 33) {
                    ForEach(genre.stories) { story in
                        StoryCardButtonView(story: story) {
                            onStoryTap(story)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        
    }
    */
    
    // MARK: - New StoryCardButtonView Struct
    
    private struct StoryCardButtonView: View {
        let story: Story
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
                    Image(story.storycover ?? "placeholder")
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
                
                Text(story.title) // Using imageName as the title for now
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .frame(width: 86)
            }
            .onTapGesture {
                onTap()
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


#Preview {
    HomePageView()
        
}

