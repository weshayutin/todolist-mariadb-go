#!/usr/bin/env python
from datetime import datetime
import json
import requests


def updateToDo(id, completed):
  """Update data to the todo application

  Args:
    item_dict: dict of todo item
    completed: bool

  Returns:
    {"updated": true/false}
  """
  data = {
      "id": id,
      "completed": completed
  }

  # Set the endpoint URL
  endpoint = "http://localhost:8000/todo/" + str(id)
  # Send a POST request with the data and the endpoint URL
  response = requests.post(endpoint, data=data)
  # Check the status code of the response
  if response.status_code == 201 or response.status_code == 200:
      print("Task updated successfully!")
      return True
  else:
      print("Error updating task.")
      return False
  

def createToDo(description, completed):
  """Post data to the todo application

  Args:
    description: todo list description
    completed: bool

  Returns:
    id of todo item in db
  """
  data = {
      "description": description,
      "completed": completed
  }

  # Set the endpoint URL
  endpoint = "http://localhost:8000/todo"
  # Send a POST request with the data and the endpoint URL
  response = requests.post(endpoint, data=data)
  # Check the status code of the response
  if response.status_code == 201 or response.status_code == 200:
      print("Task created successfully!")
  else:
      print("Error creating task.")
  response_dict = json.loads(response.text)[0]
  return response_dict

def checkToDoLists(completed):
  """Post data to the todo application

  Args:
    completed: bool

  Returns:
    json list
  """
  # Set the endpoint URL
  if completed:
    endpoint = "http://localhost:8000/todo-completed"
  else:
    endpoint = "http://localhost:8000/todo-incomplete"
  # Send a POST request with the data and the endpoint URL
  response = requests.get(endpoint)
  # Check the status code of the response
  if response.status_code == 201 or response.status_code == 200:
      print("Got list of items")
  else:
      print("Failed to get list of items")
  response_dict = json.loads(response.text)
  return response_dict



def main():
   date = datetime.today().strftime('%Y-%m-%d-%H:%M:%S')
   # create todo items
   test1 = createToDo("pytest-1-" + date, False)
   test2 = createToDo("pytest-2-" + date, False)
   test3 = createToDo("pytest-1-" + date, False)

   # update todo items
   success = updateToDo(test1["Id"], True)
   success = updateToDo(test2["Id"], True)

   # check todo's
   completed = checkToDoLists(True)
   incomplete = checkToDoLists(False)
   print("COMPLETED ITEMS:")
   print(completed)
   print("INCOMPLETE ITEMS:")
   print(incomplete)

   found_completed = False
   for i in completed:
       if test1["Description"] == i["Description"]:
          found_completed = True

   found_incomplete = False
   for i in incomplete:
      if test3["Description"] == i["Description"]:
         found_incomplete = True
   
   if found_completed == False or found_incomplete == False:
      print("FAILED TEST")
   else:
      print("SUCCESS!")


if __name__ == "__main__":
    main()

