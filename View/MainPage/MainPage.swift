import SwiftUI

struct HomePageView: View {
    @StateObject private var vm = HomePageViewModel()

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

private struct StoryRowView: View {
    let genre: StoryGenre
    let showFilterButton: Bool
    let onStoryTap: (Story) -> Void

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
                    ForEach(genre.stories) { story in
                        StoryCardButtonView(story: story) {
                            onStoryTap(story)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding(.vertical, 6)
    }
}

private struct StoryCardButtonView: View {
    let story: Story
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 86, height: 108)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .strokeBorder(.white.opacity(0.12), lineWidth: 1)
                        )

                    if let name = story.cover, !name.isEmpty {
                        Image(name)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 86, height: 108)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .clipped()
                    } else {
                        Image(systemName: "book.fill")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                }

                Text(story.title)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                    .lineLimit(1)
                    .frame(width: 86)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomePageView()
        .background(.black)
}

