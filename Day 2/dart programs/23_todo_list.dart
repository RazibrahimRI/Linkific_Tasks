class Todo {
  String task;
  bool isComplete;

  Todo(this.task, {this.isComplete = false});
}

class TodoList {
  List<Todo> todos = [];

  void addTask(String task) {
    todos.add(Todo(task));
  }

  void completeTask(int index) {
    if (index >= 0 && index < todos.length) {
      todos[index].isComplete = true;
    }
  }

  void removeTask(int index) {
    if (index >= 0 && index < todos.length) {
      todos.removeAt(index);
    }
  }

  void printAll() {
    for (var todo in todos) {
      print('${todo.isComplete ? "[x]" : "[ ]"} ${todo.task}');
    }
  }
}

void main() {
  var list = TodoList();
  list.addTask('Finish Day 2 task');
  list.addTask('Attend 8 PM meeting');
  list.addTask('Update Google Sheet');

  list.completeTask(0);
  list.printAll();
}