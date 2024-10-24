
import SwiftUI


struct ContentView: View {
//    @State var todoItems: [ToDoModel] = [
//        ToDoModel(todoItem: "阅读1小时"),
//        ToDoModel(todoItem: "跑步5公里")
//    ]
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.id, ascending: true)],
        animation: .default)
    private var todoItems: FetchedResults<Entity>
    var body: some View {
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
//                    .onTapGesture {
//                            toggleToDoItemCompleted(todoItem)
                        }
            }
            //滑动删除
//            .onDelete(perform: deleteToDoItem)
            .listRowSeparator(.hidden)
        InputTextField()
        }
    }
    //点击完成事项
//    func toggleToDoItemCompleted(_ todoItem: ToDoModel) {
//        if let index = todoItems.firstIndex(where: {$0.id == todoItem.id} ) {
//            todoItems[index].isCompleted.toggle()
//        }
//    }
    //删除事项方法
//    func deleteToDoItem(at offsets: IndexSet) {
//        todoItems.remove(atOffsets: offsets)
//    }
//}
struct ToDoListRow: View {
    var todoItem: Entity
    var body: some View {
        HStack{
            Text(todoItem.todoItem!)//强制解包
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
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        HStack{
            TextField("添加新事项", text: $newToDoItem)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 28))
                .foregroundColor(.blue)
                .onTapGesture {
                    addToDoItem()
                }
        }
        .padding()
    }
    //新增笔记的方法
    func addToDoItem() {
        if !newToDoItem.isEmpty {
            let newItem = Entity(context: viewContext)
            newItem.id = UUID()
            newItem.todoItem = newToDoItem
            newItem.isCompleted = false
            do {
                try viewContext.save()
            } catch{
                print(error)
            }
            newToDoItem = ""
        }
    }
}

#Preview {
    ContentView()
}
