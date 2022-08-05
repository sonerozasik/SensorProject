<template>
    <div style="display:inline-block; float:right;">
        <select v-model="selectedOption" name="cars" id="cars">
            <option value="byMinute">LastXMinutes</option>
            <option value="byHour">LastXHours</option>
            <option value="byDay">LastXDays</option>
            <option value="ByMonth">LastXMonth</option>
        </select>
        <input v-model="xTime" type="text" inputmode="numeric" pattern="\d*">
    </div> 
</template>

<script>
    export default{
        data(){
            return{
                selectedOption:'byHour',
                xTime:1
            }
        },
        watch :{
            xTime(val){
                if(val){
                this.xTime=val;
                this.$emit('getOptionValue',{value:val,option:this.selectedOption});
                }
            },
            selectedOption(val){
                if(val){
                    this.selectedOption=val;
                    this.$emit('getOptionValue',{value:this.xTime,option:this.selectedOption});
                }
            }
        }
    }
</script>