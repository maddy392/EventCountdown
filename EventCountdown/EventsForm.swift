//
//  EventsForm.swift
//  EventCountdown
//
//  Created by Madhu Babu Adiki on 7/4/24.
//

import SwiftUI

struct EventsForm: View {
    
    @Environment(\.dismiss) var dismiss
    @State var event: Event
    @State var isTitleValid: Bool = true
    @State var hasStartedEditingTitle = false
    @State var showAlert = false
    
    var onSave: (Event) -> Void
    var isNewEvent: Bool
    
    init(event: Event? = nil, onSave: @escaping (Event) -> Void) {
        if let event = event {
            _event = State(initialValue: event)
            isNewEvent = false
        } else {
            _event = State(initialValue: Event(id: UUID().uuidString,
                title: "Create an Event", textColor: .gray, date: Date()))
            isNewEvent = true
        }
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $event.title)
                        .foregroundColor(event.textColor)
                        .onTapGesture {
                            if event.title == "Create an Event" && !hasStartedEditingTitle {
                                event.title = ""
                                hasStartedEditingTitle = true
                            }
                        }
                        .onChange(of: event.title) { _, newValue in
                            _ = validateTitle(newValue)
                        }
                    DatePicker("Date", selection: $event.date, displayedComponents: [.date, .hourAndMinute])
                    ColorPicker("Text Color", selection: $event.textColor)
                }
                if !isTitleValid {
                    Text("Title can not be empty")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
            .navigationTitle(isNewEvent ? "Add Event": "Edit \(event.title)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        showAlert = true
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if validateTitle(event.title) {
                            onSave(event)
                            dismiss()
                        }
                    }) {
                        Image(systemName: "checkmark")
                    }
                    .disabled(!isTitleValid)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Discard Changes?"),
                    message: Text("Are you sure you want to discard your changes?"),
                    primaryButton: .destructive(Text("Discard")) {
                        dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
        
        func validateTitle(_ title: String) -> Bool {
            isTitleValid = !title.trimmingCharacters(in: .whitespaces).isEmpty
            return isTitleValid
    }
}

#Preview {
    NavigationView {
        EventsForm{_ in}
    }
}
