//
//  ContentView.swift
//  nanomarket
//
//  Created by Arya Fadhil on 15/11/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Check it out")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    // Array untuk menyimpan daftar to-do
    @State private var todos: [String] = []
    @State private var newTodo: String = ""
    
    // State untuk carousel otomatis
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
            VStack {
                // Carousel otomatis
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0..<3) { index in
                                VStack{
                                    Text("Item \(index + 1)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                                .frame(width: geometry.size.width, height: 150)
                                .background(Color.blue)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                        }
                        .frame(width: geometry.size.width * 3, alignment: .leading)
                        .offset(x: -CGFloat(currentIndex) * geometry.size.width)
                        .animation(.easeInOut(duration: 0.5), value: currentIndex)
                    }
                    .onReceive(timer) { _ in
                        currentIndex = (currentIndex + 1) % 3
                    }
                }
                .frame(height: 120)
                .padding(.vertical)
                
                
                // TextField untuk menambah to-do baru
                HStack {
                    TextField("Tambahkan to-do", text: $newTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        addTodo()
                    }) {
                        Text("Tambah")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                .padding()
                
                // List untuk menampilkan item to-do
                List {
                    ForEach(todos, id: \.self) { todo in
                        Text("- \(todo)")
                            .padding(.vertical, 10)
                    }
                    .onDelete(perform: deleteTodo)
                }
            }
            .navigationTitle("To-Do List")
        }
    }
    
    // Fungsi untuk menambah item ke daftar to-do
    private func addTodo() {
        if !newTodo.isEmpty {
            todos.append(newTodo)
            newTodo = ""
        }
    }

    // Fungsi untuk menghapus item dari daftar to-do
    private func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

