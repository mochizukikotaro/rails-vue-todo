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
export default {
  data: function () {
    return {
      newTask: "",
      tasks: [
        { msg: 'Cooking' },
        { msg: 'Watching TV' },
        { msg: 'Cleaning' }
      ]
    }
  },
  methods: {
    addTask: function(){
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
