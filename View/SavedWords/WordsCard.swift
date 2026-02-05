import SwiftUI

struct WordCardView: View {
    let item: WordBankItem
    let onLeftAction: () -> Void
    let onRightAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.word)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color.red)

                Text(item.example)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundStyle(.black.opacity(0.85))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .background(Color.black)
                .opacity(5)

            HStack(spacing: 0) {
                Button {
                    onLeftAction()
                } label: {
                    Image(systemName: "translate")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.black.opacity(0.70))
//                        .background(Color.black.opacity(0.04))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                
                Divider()
                    .background(Color.black)
//                    .background(Color.black.opacity(1))


                Button {
                    onRightAction()
                } label: {
                    Image(systemName: "ear.and.waveform")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.black.opacity(0.70))
//                        .background(Color.black.opacity(0.04))
                        .contentShape(Rectangle())
                        
                }
                .buttonStyle(.plain)
            
                
            }
            .frame(height: 54)
        }
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.20), radius: 14, x: 0, y: 10)
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        WordCardView(
            item: .init(word: "Looks", example: "“He looks at the mirror”"),
            onLeftAction: {},
            onRightAction: {}
        )
        .padding(.horizontal, 20)
    }
}


