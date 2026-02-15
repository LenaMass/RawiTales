import SwiftUI
struct DynamicSearch: View {
    @Binding var selected: Tab
    @ObservedObject var vm: DynamicSearchViewModel
    // Note: onSubmit and focused are no longer strictly needed if search is removed
    
    var body: some View {
        HStack(spacing: 10) {
            // We removed the 'if vm.isSearching' Group and the search button.
            // Now we just display the tabs capsule.
            tabsCapsule
        }
    }

    // the tabs
    private var tabsCapsule: some View {
        HStack(spacing: 40) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    selected = tab
                } label: {
                    ZStack {
                        if selected == tab {
                            RoundedRectangle(cornerRadius: 20)
                                .glassEffect()
                                .frame(width: 50, height: 50)
                        }

                        Image(systemName: selected == tab ? tab.filledIcon : tab.icon)
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundStyle(selected == tab ? .white : .iconsC)
                            .frame(width: 50, height: 50)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .glassEffect(.clear)
    }
}

/*
 
 struct DynamicSearch: View {
     @Binding var selected: Tab
     @ObservedObject var vm: DynamicSearchViewModel
     var onSubmit: (String) -> Void = { _ in }

     @FocusState private var focused: Bool

     var body: some View {
         HStack(spacing: 10) {

             Group {
                 if vm.isSearching {
                     searchCapsule
                         .transition(.move(edge: .leading).combined(with: .opacity))
                 } else {
                     tabsCapsule
                         .transition(.move(edge: .leading).combined(with: .opacity))
                 }
             }
             .animation(.easeOut(duration: 0.22), value: vm.isSearching) // <--- change later :D
             Button {
                 if vm.isSearching { vm.end() } else { vm.begin() }
             } label: {
                 ZStack {
                     RoundedRectangle(cornerRadius: 20)
                         .glassEffect(.clear)
                         .frame(width: 60, height: 60)

                     Image(systemName: "magnifyingglass")
                         .font(.system(size: 32, weight: .semibold))
                         .frame(width: 60, height: 60)
                         .foregroundStyle(.iconsC)
                 }
             }
             .buttonStyle(.plain)
             .frame(width: 60)

         }
         .onChange(of: vm.isSearching) { _, active in
             if active {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                     focused = true
                 }
             } else {
                 focused = false
             }
         }
     }
 // the tabs
     private var tabsCapsule: some View {
         HStack(spacing: 40) {
             ForEach(Tab.allCases, id: \.self) { tab in
                 Button {
                     selected = tab
                 } label: {
                     ZStack {
                         if selected == tab {
                             RoundedRectangle(cornerRadius: 20)
 //                                .fill(.ultraThinMaterial)
                                 .glassEffect()
                                 .frame(width: 50, height: 50)
                             
                         }

                        
                            Image(systemName: selected == tab ? tab.filledIcon : tab.icon)
                                .font(.system(size: 32, weight: .semibold))
                                .foregroundStyle(selected == tab ? .white : .iconsC)
                                .frame(width: 50, height: 50)
                        }
                    }
                 .buttonStyle(.plain)
               //  .glassEffect(.clear)

             
             }
         }
         .padding(.horizontal, 30)
         .padding(.vertical, 10)
         .glassEffect(.clear)
     }
 // the search bar :)
     private var searchCapsule: some View {
         HStack(spacing: 5) {
             TextField("Search your story here", text: $vm.query)
                 .textInputAutocapitalization(.never)
                 .foregroundColor(Color.white)
                 .frame(maxWidth: 260) // // sizze
                 .autocorrectionDisabled(true)
                 .submitLabel(.search)
                 .focused($focused)
                 .onSubmit {
                     vm.submit(onSubmit: onSubmit)
                 }

             if !vm.query.isEmpty {
                 Button { vm.clear() } label: {
                     Image(systemName: "xmark.circle.fill")
                         .foregroundStyle(.secondary)
                         .font(.system(size: 18, weight: .semibold))
                 }
                 .buttonStyle(.plain)
             }
         }
         .padding(.horizontal, 24)
         .frame(height: 60)
         .glassEffect(.clear)
     }
 }
 #Preview {
     DynamicSearchPreviewHost()
 }
 private struct DynamicSearchPreviewHost: View {
     @State private var selected: Tab = .library
     @StateObject private var searchVM = DynamicSearchViewModel()

     var body: some View {
         ZStack {
             LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom)
                 .ignoresSafeArea()

             VStack {
                 Spacer()

                 DynamicSearch(selected: $selected, vm: searchVM) { text in
                     print("Preview search:", text)
                 }
                 .padding(.bottom, 10)
             }
         }
         .onAppear {

         }
     }
 }


 
 */
