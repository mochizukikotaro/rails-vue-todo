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
let initialTasks = []
export default {
  data: function () {
    return {
      newTask: "",
      tasks: initialTasks
    }
  },
  beforeCreate: function(){
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/tasks.json", true);
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        for(const x of xhr.response){
          initialTasks.push({ id: x.id, msg: x.name })
        }
      }
    }
    xhr.responseType = "json"
    xhr.send()
  },
  methods: {
    addTask: function(){

      const callBackAddTask = (res) => {
        console.log(res);
        if(res.status != "error"){
          this.tasks.push({ id: res.id, msg: this.newTask })
          this.newTask = ""
        } else {
          console.log('error');
        }
      }

      var xhr = new XMLHttpRequest()
      xhr.open("POST", "/tasks.json", true)
      xhr.setRequestHeader("Content-type", "application/json");
      xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
          callBackAddTask(xhr.response)
        }
      }
      xhr.responseType = "json"
      xhr.send('{"task":{"name": "' + this.newTask + '"}}')
    },
    deleteTask: function(task){
      const callBackDeleteTask = (res) => {
        for(const t of this.tasks){
          if(t.id == res.id){
            const index = this.tasks.indexOf(t)
            this.tasks.splice(index, 1)
          }
        }
      }
      var xhr = new XMLHttpRequest()
      xhr.open("DELETE", "/tasks/" + task.id + ".json", true)
      xhr.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
          callBackDeleteTask(xhr.response)
        }
      }
      xhr.responseType = "json"
      xhr.send()
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
