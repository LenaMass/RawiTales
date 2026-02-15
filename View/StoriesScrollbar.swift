
import SwiftUI
import Combine
import SwiftData

struct StoriesScrollbar: View {
    // 1. CHANGE: Delete the ObservedObject and use @Query to get real saved data
    @Query(sort: \Story.title) var allStories: [Story]
    @Query(filter: #Predicate<Story> { $0.isFavorite == true }) var favoriteStories: [Story]
    var savedStories: [Story] {
            allStories.filter { $0.Readingprogress > 0 || $0.isFavorite }
        

        
        }
    
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
            ScrollView {
                // Check if there are actually saved stories to show
                if savedStories.isEmpty {
                    ContentUnavailableView("No Saved Stories",
                                           systemImage: "book.closed",
                                           description: Text("Start reading a story to see it here."))
                        .padding(.top, 100)
                        .foregroundStyle(Color.white)
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(savedStories) { story in
                            // Use your existing StoryView for the destination
                            NavigationLink(destination: StoryView(story: story)) {
                                VStack(spacing: 0) {
                                    // Cover Image
                                    Image(story.storycover ?? "placeholder")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 140)
                                        .clipped()
                                        .cornerRadius(18, corners: [.topLeft, .topRight])
                                    
                                    // Progress Section
                                    VStack {
                                        Spacer()
                                        ZStack(alignment: .leading) {
                                            Capsule()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(height: 8)
                                            
                                            GeometryReader { geo in
                                                Capsule()
                                                    .fill(Color.black)
                                                    // Dynamic width based on progress
                                                    .frame(width: geo.size.width * (Double(story.Readingprogress) / 100.0), height: 8)
                                            }
                                        }
                                        .frame(height: 8)
                                        .padding(.horizontal, 10)
                                        .padding(.bottom, 12)
                                    }
                                    .frame(height: 40)
                                    .background(Color.white)
                                    .cornerRadius(18, corners: [.bottomLeft, .bottomRight])
                                }
                                .shadow(radius: 2)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 20)
                        }
                    }
                    .padding()
                }
            }
            .background(Color.clear)
        
        
        
        }
    }

#Preview {
    StoriesScrollbar()
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
