//
//  ContentView.swift
//  iExpense
//
//  Created by Remitbee on 09/11/26.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            // contents of the sheet
            SecondView(name: "@twostraws")
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    let name: String

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}
@Observable
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

#Preview {
    ContentView()
}
