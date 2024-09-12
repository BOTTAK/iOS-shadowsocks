import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    let totalPages = 4
    let titles = ["Many prestigious awards", "Safe and Secured", "Global Server Coverage", "24/7 Customer Support"]
    let subtitles = ["Trusted by over 4 million users", "Military-Grade Encryption", "Supports over 1 million servers worldwide.", "Caring help whenever you need."]
    let images = ["onboarding1", "onboarding2", "onboarding3", "onboarding4"]
    var primaryColor: Color {
        return Color(UIColor(hexString: "#F95825"))
    }
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 90)
            Image(images[currentPage])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 46)
            
            Spacer()
                .frame(height: 51)
            Text(titles[currentPage])
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(primaryColor)
                .multilineTextAlignment(.center)
            Text(subtitles[currentPage])
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(primaryColor)
                .multilineTextAlignment(.center)
            
            Spacer()
            Button(action: {
                if currentPage < totalPages - 1 {
                    currentPage += 1
                } else {
                    onComplete()
                }
            }) {
                Text(currentPage == totalPages - 1 ? "Start enjoying" : "Next")
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
            }
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView(onComplete: {
        print("Onboarding completed")
    })
}
