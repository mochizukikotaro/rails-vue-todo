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
import axios from 'axios'
let initialTasks = []
export default {
  data: function () {
    return {
      newTask: "",
      tasks: initialTasks
    }
  },
  beforeCreate: function(){
    axios.get("/tasks.json").then(res => {
      for(const task of res.data){
        initialTasks.push({ id: task.id, msg: task.name })
      }
    })
  },
  methods: {
    addTask: function(){
      axios.post("/tasks.json", {
        task: { name: this.newTask }
      }).then(res => {
        if(res.data.status != "error"){
          this.tasks.push({ id: res.data.id, msg: this.newTask })
          this.newTask = ""
        } else {
          console.log('error');
        }
      })
    },
    deleteTask: function(task){
      axios.delete("/tasks/" + task.id + ".json").then(res => {
        for(const t of this.tasks){
          if(t.id == res.data.id){
            const index = this.tasks.indexOf(t)
            this.tasks.splice(index, 1)
          }
        }
      })
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
