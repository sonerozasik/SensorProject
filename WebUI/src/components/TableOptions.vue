<template>
    <div class="popup">
        <div class="popup-inner">
            <div class="row justify-content-center">
                <h2>Settings</h2>
            </div>
            <div class="row">
                <div style="display:inline-block; float:right;">
                    <select v-model="selectedOption" style="font-size:30px">
                        <option value="byMinute">LastXMinutes</option>
                        <option value="byHour">LastXHours</option>
                        <option value="byDay">LastXDays</option>
                        <option value="ByMonth">LastXMonth</option>
                    </select>
                    <input v-model="xTime" type="numeric" inputmode="numeric" pattern="\d*" style="font-size:25px">
                </div>
            </div>
            <div class="row p-4">
                <button @click="closePopup">OK</button> 
            </div>
        </div>
    </div>
</template>


<script>
export default{
    props:{
        closePopup:Function,
    },
data(){
    return{
        xTime:1,
        selectedOption:0
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

<style lang="scss" scoped>
.popup{
    position: fixed;
    top:0;
    left:0;
    bottom:0;
    right: 0;
    z-index: 99;
    background-color: rgba(0,0,0,0.2);

    display: flex;
    align-items: center;
    justify-content: center;

    .popup-inner{
        background-color:#FFF ;
        padding: 100px;
        border-radius: 10%;
    }
}

</style>