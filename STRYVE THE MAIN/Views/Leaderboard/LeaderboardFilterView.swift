import SwiftUI

struct LeaderboardFilterView: View {
    @Binding var selectedFilter: Int
    let filters: [String]
    
    var body: some View {
        Picker("Filter", selection: $selectedFilter) {
            ForEach(0..<filters.count, id: \.self) { index in
                Text(filters[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

#Preview {
    LeaderboardFilterView(
        selectedFilter: .constant(0),
        filters: ["Global", "Friends"]
    )
}
