class Node

  constructor: ->
    @value = "default"
    @pointer = null

class LinkedList

  constructor: ->
    @length = 0
    @head = null

  append: (node) ->
    if @head == null
      @head = node
      @length = 1
    else
      tmp = @head
      while tmp.pointer != null
        tmp = tmp.pointer
      tmp.pointer = node
      @length += 1
    node

  count_nodes: ->
    @length

  list_values: ->
    values = []
    if @head == null
      return []
    else
      tmp = @head
      values.push tmp.value
      while tmp.pointer != null
        tmp = tmp.pointer
        values.push tmp.value
    values

#ogfileid:9
