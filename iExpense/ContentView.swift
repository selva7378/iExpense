import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var expenses = Expenses()

    var body: some View {
        NavigationStack {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.personalItems) { item in
                        expenseRow(for: item)
                    }
                    .onDelete(perform: removePersonalItems)
                }

                Section("Business Expenses") {
                    ForEach(expenses.businessItems) { item in
                        expenseRow(for: item)
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    @ViewBuilder
    func expenseRow(for item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(amountFont(for: item.amount))
                .foregroundStyle(amountColor(for: item.amount))
        }
    }

    func amountColor(for amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .blue
        } else {
            return .red
        }
    }

    func amountFont(for amount: Double) -> Font {
        if amount < 10 {
            return .subheadline
        } else if amount < 100 {
            return .body.weight(.medium)
        } else {
            return .headline.bold()
        }
    }

    func removePersonalItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.personalItems)
    }

    func removeBusinessItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.businessItems)
    }

    func removeItems(at offsets: IndexSet, in sourceList: [ExpenseItem]) {
        for offset in offsets {
            let itemToDelete = sourceList[offset]
            if let index = expenses.items.firstIndex(where: { $0.id == itemToDelete.id }) {
                expenses.items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
}
