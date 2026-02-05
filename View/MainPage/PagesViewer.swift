import SwiftUI

struct PagesViewer: View {
    @StateObject private var vm = PagesViewerViewModel()

    private var title: String {
        switch vm.selectedTab {
        case .library: return ""
        case .reading: return "Reading"
        case .dictionary: return "Saved Words"
        }
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Group {
                switch vm.selectedTab {
                case .library:
                    HomePageView()
                case .reading:
                    Text("Reading Page")
                        .foregroundStyle(.white)
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
        .safeAreaInset(edge: .top) {
            if vm.selectedTab != .library {
                NavigationHeader(
                    title: title,
                    canGoBack: true,
                    onBack: { vm.selectedTab = .library }
                )
            }
        }
        .safeAreaInset(edge: .bottom) {
            DynamicSearch(selected: $vm.selectedTab, vm: vm.searchVM) { text in
                vm.handleSearch(text)
            }
            .padding(.bottom, 8)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    PagesViewer()
}


