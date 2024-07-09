//
//  EventsView.swift
//  EventCountdown
//
//  Created by Madhu Babu Adiki on 7/4/24.
//

import SwiftUI


struct EventsView: View {
    
    @State var events: [Event]?
    @State var isAddingNewEvent = false
    
    var sortedEvents: [Event] {
        events?.sorted() ?? []
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedEvents) {event in
                    NavigationLink(value: event) {
                        EventRow(event: event)
                    }
                    .swipeActions {
                        if events != nil {
                            Button(role: .destructive) {
                                delete(event: event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddingNewEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewEvent, content: {
                EventsForm(onSave: { newEvent in
                    if let index = events?.firstIndex(where: { $0.id == newEvent.id }) {
                        events?[index] = newEvent
                    } else {
                        if events != nil {
                            events?.append(newEvent)
                        } else {
                            events = [newEvent]
                        }
                    }
                    isAddingNewEvent = false
                })
            })
            .navigationDestination(for: Event.self) { event in
                EventsForm(event: event) { updatedEvent in
                    if let index = events?.firstIndex(where: {$0.id == updatedEvent.id}) {
                        events?[index] = updatedEvent
                    }
                }
            }
        }
    }
    
    func delete(event: Event) {
        if let index = events?.firstIndex(where: { $0.id == event.id }) {
            events?.remove(at: index)
        }
    }
}

//#Preview {
//    EventsView()
//}

#Preview {
    EventsView(events: [
        Event(title: "Christmas", textColor: .red, date: Date().addingTimeInterval(3600)),
        Event(title: "New Year", textColor: .blue, date: Date().addingTimeInterval(7200)),
        Event(title: "Birthday", textColor: .green, date: Date().addingTimeInterval(100800))
    ])
}
