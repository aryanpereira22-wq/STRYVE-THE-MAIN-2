import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isNotificationsEnabled = true
    @State private var isDarkModeEnabled = false
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $isNotificationsEnabled)
                    Toggle("Dark Mode", isOn: $isDarkModeEnabled)
                }
                
                Section(header: Text("Account")) {
                    NavigationLink(destination: EditProfileView()) {
                        Text("Edit Profile")
                    }
                    
                    NavigationLink(destination: Text("Privacy Settings")) {
                        Text("Privacy")
                    }
                    
                    NavigationLink(destination: Text("Help Center")) {
                        Text("Help & Support")
                    }
                    
                    Button(action: { showLogoutAlert = true }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
                
                Section {
                    VStack(alignment: .center, spacing: 8) {
                        Text("STRYVE")
                            .font(.caption)
                            .foregroundColor(ColorTheme.textSecondary)
                        
                        Text("Version 1.0.0")
                            .font(.caption2)
                            .foregroundColor(ColorTheme.textTertiary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Log Out", role: .destructive) {
                    // Handle logout
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
    }
}

#Preview {
    SettingsView()
}
