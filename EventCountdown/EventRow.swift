//
//  EventRow.swift
//  EventCountdown
//
//  Created by Madhu Babu Adiki on 7/4/24.
//

import SwiftUI

struct EventRow: View {
    
    let event: Event
    @State var currentDate = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .bold()
                .foregroundColor(event.textColor)
            Text(relataiveDateFormatter.localizedString(for: event.date, relativeTo: currentDate))
                .foregroundColor(.gray)
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            currentDate = Date()
        }
    }
    
    private var relataiveDateFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }
}

#Preview {
    EventRow(event: Event(title: "Christmas", textColor: .red, date: Date().addingTimeInterval(-7500000)))
}
