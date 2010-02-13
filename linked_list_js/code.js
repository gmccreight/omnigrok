(function() {
    var undefined;

    function Node () {
      this.value = "default";
      this.pointer = null;
    }

    window.Node = Node;

    function LinkedList () {
      this.length = 0;
      this.head = null;
    }

    LinkedList.prototype.append = function(node) {
      if (this.head == null) {
        this.head = node;
        return;
      }
      else {
        var tmp = this.head;
        while (tmp.pointer != null) {
          tmp = tmp.pointer;
        }
        tmp.pointer = node;
      }
    }

    LinkedList.prototype.list_values = function() {
      var values = [];
      if (this.head == null) {
        return [];
      }
      else {
        var tmp = this.head;
        values.push(tmp.value);
        while (tmp.pointer != null) {
          tmp = tmp.pointer;
          values.push(tmp.value);
        }
      }
      return values;
    }

    window.LinkedList = LinkedList;
})();
