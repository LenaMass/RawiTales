/*
issues notes
the navigation works fine, however the back naviation is double one from the savedstoriesview and the other is from this page.
 
 
*/
import SwiftUI
import SwiftData
import Combine


struct PagesViewer: View {
    @StateObject private var vm = PagesViewerViewModel()
    
    private var title: String {
        switch vm.selectedTab {
        case .library: return ""
        case .reading: return ""//"Reading"
        case .dictionary: return "Saved Words"
        }
    }
    
    var body: some View {
        ZStack {
            
            Group {
                switch vm.selectedTab {
                case .library:
                    HomePageView()
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
        
        
        .safeAreaInset(edge: .top) {
            // Only show the header when the user is specifically on the dictionary tab
            if vm.selectedTab == .dictionary {
                NavigationHeader(
                    title: title,
                    canGoBack: true,
                    onBack: { vm.selectedTab = .library }
                )
            }
        }
        
        
        
        
        .safeAreaInset(edge: .bottom) {
            // We removed the search closure since the search bar is gone
            DynamicSearch(selected: $vm.selectedTab, vm: vm.searchVM)
                .padding(.bottom, 8)
        }
        // You can also remove .ignoresSafeArea(.keyboard) if you no longer have any text inputs
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    PagesViewer()
}


