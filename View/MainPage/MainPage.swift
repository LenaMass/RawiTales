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

                    ForEach(vm.genres) { genre in
                        StoryRowView(genre: genre, onStoryTap: onStoryTap)
                            .padding(.horizontal, 16)
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
                    .foregroundStyle(.primary.opacity(0.9))
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

            Button {} label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 34, height: 34)
                    .foregroundStyle(.primary.opacity(0.9))
            }
            .buttonStyle(.plain)
            .background {
                Circle().fill(Color.clear).glassEffect(.clear)
            }
            .overlay {
                Circle().strokeBorder(.white.opacity(0.18), lineWidth: 1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 10)
    }
}

private struct StoryRowView: View {
    let genre: StoryGenre
    let onStoryTap: (Story) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: "leaf")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary.opacity(0.85))
                Text(genre.name)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary.opacity(0.9))
                Spacer()
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

                    if let assetName = story.assetName {
                        Image(assetName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 86, height: 108)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    } else {
                        Image(systemName: "OverthegardenwallStory")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.red.opacity(0.65))
                    }
                }

                Text(story.title)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary.opacity(0.9))
                    .lineLimit(1)
                    .frame(width: 86)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomePageView()
}


