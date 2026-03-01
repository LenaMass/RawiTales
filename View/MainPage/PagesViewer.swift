/*
issues notes
the navigation works fine, however the back naviation is double one from the savedstoriesview and the other is from this page.
 
 
*/
import SwiftUI
import SwiftData
import Combine


struct PagesViewer: View {
    @StateObject private var vm = PagesViewerViewModel()
    @State private var selectedStory: Story?
    
    private var title: String {
        switch vm.selectedTab {
        case .library: return ""
        case .reading: return ""//"Reading"
        case .dictionary: return "Saved Words"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Group {
                    switch vm.selectedTab {
                    case .library:
                        HomePageView { story in
                            if vm.path.last != .storyView {
                                vm.push(.storyView)
                            }
                            selectedStory = story
                        }
                    case .reading:
                        Savedstory_view()
                    case .dictionary:
                        WordsBankList()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if vm.searchVM.isSearching {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture { vm.searchVM.end() }
                        .ignoresSafeArea()
                }
            }
            .navigationDestination(item: $selectedStory) { story in
                StoryView(story: story)
                    .onDisappear {
                        if vm.path.last == .storyView {
                            vm.goBack()
                        }
                    }
            }
            .safeAreaInset(edge: .top) {
                if vm.selectedTab == .dictionary {
                    NavigationHeader(
                        title: title,
                        canGoBack: true,
                        onBack: { vm.selectedTab = .library }
                    )
                }
            }
            .safeAreaInset(edge: .bottom) {
                if !vm.shouldHideBottomBar {
                    DynamicSearch(selected: $vm.selectedTab, vm: vm.searchVM)
                        .padding(.bottom, -15)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    PagesViewer()
}
