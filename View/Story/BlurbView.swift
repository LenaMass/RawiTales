import SwiftUI
import Foundation

// MARK: - Custom Curved Shape
struct HeaderCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.75))
        // This creates the sweeping curve from right to left
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.height),
                          control: CGPoint(x: rect.width * 0.5, y: rect.height * 1.05))
        path.closeSubpath()
        return path
    }
}

struct StoryIntroView: View {

    private var englishBlurb: String {
        "This text is written to explain more about this story and can have a look when you start reading."
    }

    //  Translation state (added)
    @State private var isTranslated: Bool = false
    @State private var isTranslating: Bool = false
    @State private var translatedArabic: String?

    // Read key from Info.plist (xcconfig injected)
    private var deeplApiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "DEEPL_API_KEY") as? String ?? ""
    }

    private var deeplIsFreePlan: Bool {
        let v = Bundle.main.object(forInfoDictionaryKey: "DEEPL_FREE_PLAN") as? String ?? "YES"
        return (v as NSString).boolValue
    }

    private var translator: DeepLTranslator {
        DeepLTranslator(apiKey: deeplApiKey, isFreePlan: deeplIsFreePlan)
    }

    private var displayedBlurb: String {
        isTranslated ? (translatedArabic ?? englishBlurb) : englishBlurb
    }

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Section with Custom Curve
            ZStack(alignment: .top) {
                Image("storyCover1") // Replace with your image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.55)
                    .clipShape(HeaderCurve())
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)

                // Top Navigation Bar
                HStack {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(10)
                            .background(Circle().fill(Color.primary.opacity(0.25)))

                        Spacer()

                        Text("Story Title")
                            .font(.headline)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)

                        Spacer()

                        Button(action: {
                            toggleBlurbTranslation()
                        }) {
                            Image(systemName: (isTranslated || isTranslating) ? "character.bubble.fill" : "character.bubble")
                                .font(.title2)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .foregroundColor(.primary)
                                .shadow(radius: 2)
                        }
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
            }

            // MARK: - Bottom Content Section
            VStack(spacing: 35) {
                Spacer()

                //( now shows API translation when active)
                Text(displayedBlurb)
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 40)
                    .foregroundColor(.primary)

                // Bottom Buttons
                HStack(spacing: 20) {
                    Button(action: {}) {
                        Text("Start Reading")
                            .frame(width: 186, height: 54)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .background(
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.accentColor.opacity(0.7), Color.accentColor],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                            )
                            .shadow(color: Color.accentColor.opacity(0.3), radius: 10, y: 5)
                    }

                    Button(action: {}) {
                        Image(systemName: "star")
                            .font(.title2)
                            .padding(15)
                            .background(Color(.clear))
                            .glassEffect(.clear)
                            .foregroundColor(.primary)
                        //                            .shadow(color: .black.opacity(0.1), radius: 5)
                    }
                }
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea()
    }

    //API only
    private func toggleBlurbTranslation() {
        // Tap again → back to English (unfill)
        if isTranslated || isTranslating {
            isTranslated = false
            isTranslating = false
            return
        }
        
        if let cached = translatedArabic, !cached.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            isTranslated = true
            return
        }

        guard !deeplApiKey.isEmpty else { return }

        let text = englishBlurb.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        isTranslating = true

        Task {
            defer { isTranslating = false }
            do {
                let ar = try await translator.translate(text, from: "EN", to: "AR")
                translatedArabic = ar
                isTranslated = true
            } catch {
                isTranslated = false
            }
        }
    }
}

#Preview {
    StoryIntroView()
}


