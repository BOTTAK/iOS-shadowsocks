import SwiftUI

struct SplashView: View {
    var primaryColor: Color {
        return Color(UIColor(hexString: "#F95825"))
    }

    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
        return "Version \(version).\(build)"
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 90)
            Image("splash-shield")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 46)
            Spacer()
                .frame(height: 11)
            Text("B-TELL")
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 2)
            Text(appVersion)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .background(primaryColor)
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
