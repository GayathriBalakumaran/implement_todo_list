require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
  end

  def overdue?
    overdue = false
    if (@due_date < Date.today)
      overdue = true
    end
    return overdue
  end

  def duedate?
    duedate = false
    if (@due_date == Date.today)
      duedate = true
    end
    return duedate
  end

  def duelater?
    duelater = false
    if (@due_date > Date.today)
      duelater = true
    end
    return duelater
  end

  def to_displayable_string
    str = " "
    if (@due_date == Date.today)
      if (@completed == true)
        str += "[X] #{@text}"
      else
        str += "[ ] #{@text}"
      end
    else
      str += "[ ] #{@text} #{@due_date}"
    end
    return str
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.duedate? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.duelater? })
  end

  def add(new_element)
    @todos.append(new_element)
  end

  def to_displayable_list
    todo_text = []
    @todos.each { |todo| todo_text << todo.to_displayable_string }
    return todo_text.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
