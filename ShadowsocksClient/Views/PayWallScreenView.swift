import SwiftUI

struct PayWallScreenView: View {
    @State private var isThreeDaysSelected: Bool = true
    @State private var isTrialEnabled: Bool = false
    @State private var selectedProduct: String = "week.5.t"
    
    var body: some View {
        VStack {
            // Close button
            HStack {
                Spacer()
                Image("close-paywall")
                    .resizable()
                    .frame(width: 19, height: 19)
                    .padding(.top, 18)
                    .padding(.trailing, 23)
                    .onTapGesture {
                        closePaywall()
                    }
            }
            
            // Main title and subtitle
            Text("Unlimited access")
                .font(.system(size: 25, weight: .black))
                .foregroundColor(Color(hex: "#0F1319"))
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            Text("Scan PDF, E-Sign document, Print\ndocuments")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(hex: "#999999"))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            // Replace Lottie with image (red background for now)
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(Color.red)
                .cornerRadius(15)
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
            // Three Days view
            OptionView(
                title: "3 day free trial",
                subtitle: "$4.99 per week",
                isSelected: isThreeDaysSelected
            )
            .padding(.top, 15)
            
            // Yearly view
            OptionView(
                title: "Yearly",
                subtitle: "$29.99 per year",
                isSelected: !isThreeDaysSelected
            )
            .padding(.top, 10)
            
            // Enable Free Trial
            HStack {
                Text("Enable Free Trial")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                Toggle("", isOn: $isTrialEnabled)
                    .labelsHidden()
                    .onChange(of: isTrialEnabled) { value in
                        updateViewSelection(isThreeDaysSelected: value)
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .background(Color(hex: "#F5F7FA"))
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.2), radius: 1, x: 2, y: 2)
            .frame(height: 43)
            
            // Continue Button
            Button(action: {
                sendButtonTapped()
            }) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#006AFF"))
                    .cornerRadius(28)
                    .shadow(color: Color(hex: "#006AFF").opacity(0.67), radius: 20, x: 2, y: 2)
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(height: 56)
            
            // Privacy, Restore, Terms Labels
            HStack {
                Text("Privacy")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#999999"))
                    .onTapGesture {
                        openURL("https://yourprivacyurl.com")
                    }
                
                Spacer()
                
                Text("Restore")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#999999"))
                    .onTapGesture {
                        // Restore logic here
                    }
                
                Spacer()
                
                Text("Terms")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#999999"))
                    .onTapGesture {
                        openURL("https://yourtermsurl.com")
                    }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color(hex: "#F5F7FA")) // Устанавливаем цвет фона
        .edgesIgnoringSafeArea(.all)
    }
    
    func updateViewSelection(isThreeDaysSelected: Bool) {
        self.isThreeDaysSelected = isThreeDaysSelected
    }
    
    func sendButtonTapped() {
        // Send button logic
    }
    
    func closePaywall() {
        // Close paywall logic
    }
    
    func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

// Custom view for the options (Three days / Yearly)
struct OptionView: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#141316"))
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "#999999"))
            }
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 19, height: 19)
        }
        .padding()
        .background(Color(hex: "#F5F7FA"))
        .cornerRadius(25)
        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 2, y: 2) // Добавляем тень, но без обводки
    }
}

// Helper for Color from hex string
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
