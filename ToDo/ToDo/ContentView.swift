
import SwiftUI


struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.id, ascending: true)],
        animation: .default)
    private var todoItems: FetchedResults<Entity>
    var body: some View {
        List {
            ForEach(todoItems) { todoItem in
                ToDoListRow(todoItem: todoItem)
                    .onTapGesture {
                        toggleToDoItemCompleted(itemId: todoItem.id!)
                    }
                //长按弹窗删除
                    .contextMenu {
                        Button("删除"){
                            if let itemId = todoItem.id {
                                deleteToDoItem(itemId: itemId)
                            }
                        }
                    }
                }
            }
         
            .listRowSeparator(.hidden)
        InputTextField()
            
        }
    //删除方法
    func deleteToDoItem(itemId: UUID) {
           if let deleteItem = todoItems.first(where: { $0.id == itemId }) {
               viewContext.delete(deleteItem)
               do {
                   try viewContext.save()
               } catch {
                   print(error)
               }
           }
       }
    //点击完成事项方法
    func toggleToDoItemCompleted(itemId: UUID){
        guard let todoItem = todoItems.first (where: { $0.id == itemId}) else {return}
        withAnimation{
            todoItem.isCompleted.toggle()
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    }
  
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
