import SwiftUI
import SwiftData

struct WordsBankList: View {
    @Environment(\.modelContext) private var modelContext
        // This replaces the 'items' array in your ViewModel
        @Query(sort: \WordBankItem.createdAt, order: .reverse) var items: [WordBankItem]
    
        @StateObject private var vm = WordsBankListViewModel.shared

    var body: some View {
        ZStack {
            List {
                ForEach(items) { item in
                    WordCardView(
                        item: item,
                        isTranslating: vm.translatingID == item.id,
                        onLeftAction: { vm.translateCard(item) },
                        onRightAction: {
                            vm.speak(item) // Now passes the item to handle the toggle logic
                        }
                    )
                    
                    .listRowInsets(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .contentShape(Rectangle())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            modelContext.delete(item)
                        } label: {
                            Label("", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.top, 110)
            .padding(.bottom, 120)
        }
    }
}

#Preview {
    WordsBankList()
}

