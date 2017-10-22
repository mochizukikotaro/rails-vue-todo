<template>
  <div id="app">
    <input v-model="newTask" placeholder="Your task">
    <button @click="addTask">Add</button>
    <ol>
      <li v-for="task in tasks">
        {{ task.msg }}
        <button @click="deleteTask(task)">Delete</button>
      </li>
    </ol>
  </div>
</template>

<script>
let initTasks = []
export default {
  data: function () {
    return {
      newTask: "",
      tasks: initTasks
    }
  },
  beforeCreate: function(){
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/tasks/index.json", true);
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        for(const x of xhr.response){
          initTasks.push({ msg: x.name })
        }
      }
    }
    xhr.responseType = "json"
    xhr.send()
  },
  methods: {
    addTask: function(){
      var xhr = new XMLHttpRequest()
      xhr.open("POST", "/tasks/create.json", true)
      xhr.setRequestHeader("Content-type", "application/json");
      xhr.onreadystatechange = function(){
        // TODO:
        console.log(xhr.response);
      }
      xhr.responseType = "json"
      xhr.send('{"task":{"name": "' + this.newTask + '"}}')

      this.tasks.push({ msg: this.newTask })
      this.newTask = ""
    },
    deleteTask: function(task){
      const index = this.tasks.indexOf(task)
      this.tasks.splice(index, 1)
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
