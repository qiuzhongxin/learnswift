
import SwiftUI


struct ContentView: View {
    @State var todoItems: [ToDoModel] = [
        ToDoModel(todoItem: "阅读1小时"),
        ToDoModel(todoItem: "跑步5公里")
    ]
    var body: some View {
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
                    .onTapGesture {
                            toggleToDoItemCompleted(todoItem)
                        }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        InputTextField()
    }
    //点击完成事项
    func toggleToDoItemCompleted(_ todoItem: ToDoModel) {
        if let index = todoItems.firstIndex(where: {$0.id == todoItem.id} ) {
            todoItems[index].isCompleted.toggle()
        }
    }
}
struct ToDoListRow: View {
    var todoItem: ToDoModel
    var body: some View {
        HStack{
            Text(todoItem.todoItem)
                .foregroundColor(todoItem.isCompleted ? .gray : .black)
                .lineLimit(1)
                .strikethrough(todoItem.isCompleted, color: .gray)//删除线
            Spacer()
            Image(systemName: todoItem.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todoItem.isCompleted ? .green : .black)
        }
        .padding(.horizontal)
        .frame(height: 75)
        .background(Color(.systemGray6))
    }
}
struct InputTextField: View {
    @State var newToDoItem = ""
    var body: some View {
        HStack{
            TextField("添加新事项", text: $newToDoItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 28))
                .foregroundColor(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
