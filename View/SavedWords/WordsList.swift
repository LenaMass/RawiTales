import SwiftUI

struct WordsBankList: View {
    @StateObject private var vm = WordsBankListViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(vm.items) { item in
                    WordCardView(
                        item: item,
                        onLeftAction: { print("Left action:", item.word) },
                        onRightAction: { print("Right action:", item.word) }
                    )
                    .listRowInsets(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .contentShape(Rectangle())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            vm.delete(item)
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

