<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 1" @submit.prevent="saveScore">
                    <h1 class="text-h5 font-weight-bold">แบบประเมินตนเอง</h1>
                    <v-card class="mt-3 pa-3" :elevation="5" >
                        <p>ผู้ใช้งาน : {{ user.fname }} {{ user.lname }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,t) in topics" :key="topic.id_topic">
                        <v-col cols="12">
                            <h1 class="text-h5 font-weight-bold">{{ Number(t)+1 }}.{{ topic.name_topic }}</h1>
                        </v-col>
                        <v-col cols="12">
                            <v-card class="pa-3 mt-1" :elevation="5" rounded="5">
                                <v-row v-for="(indicate,i) in topic.indicates" :key="indicate.id_indicate">
                                    <v-col cols="12">
                                        {{ Number(t)+1 }}.{{ Number(i)+1 }} {{ indicate.name_indicate }} รายละเอียดตัวชี้วัด {{ indicate.detail_indicate }} น้ำหนักคะแนน {{ indicate.point_indicate }} คะแนนเต็ม {{ indicate.point_indicate*4 }}
                                        <v-textarea class="mt-2" label="รายละเอียดเพิ่มเติม (ถ้ามี)" rows="2" v-model="indicate.detail_eva" variant="outlined" ></v-textarea>
                                        <v-file-input label="*** แนบได้เฉพาะนามสกุลไฟล์ .png .jpg .pdf *** " variant="outlined" @change="onFileChange($event,topic.id_topic,indicate.id_indicate)" accept=".png,.jpg,.pdf"></v-file-input>
                                        <v-select v-if="indicate.check_indicate === 'y'" label="ใส่คะแนนประเมิน 1-4 " :items="[1,2,3,4]" v-model="indicate.score" variant="outlined"></v-select>
                                        <v-text-field v-else label="ใส่คะแนนประเมิน 1-4 " v-model="indicate.score" variant="outlined" @input="indicate.score > 4 ? indicate.score = 4 :null " min="0"></v-text-field>
                                    </v-col>
                                </v-row>
                            </v-card>
                        </v-col>
                    </v-row>
                    <div class="text-center mt-4">
                        <v-btn type="submit" color="blue">บันทึกคะแนน</v-btn>
                    </div>
                </v-form>
                <v-alert type="success" variant="outlined" v-else-if="user.status_eva === 2 || user.status_eva === 3">ประเมินสำเร็จ</v-alert>
                <v-alert type="error" variant="outlined" v-else>ยังไม่ได้ประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios, { all } from 'axios';
import { eva } from '~/API/base';

const topics = ref<any>([])
const user = ref<any>({})


const fetchUser = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${eva}/selfeva/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    } catch (error) {
        console.error('ERROR GET USER  ',error)
    }
}
const fetchTopics = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${eva}/selfeva/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPICS  ',error)
    }
}

onMounted(async()=>{
    Promise.all([fetchUser(),fetchTopics()])
})

const fileMap = ref<Record<string,File>>({})
const onFileChange = (event:Event,id_topic:number,id_indicate:number)=>{
    const file = (event.target as HTMLInputElement)?.files?.[0]
    if(!file)return
    fileMap.value[`${id_topic}-${id_indicate}`] = file
}

const saveScore = async()=>{
    const token = localStorage.getItem('token')
    const formData = new FormData()
    const allScore = topics.value.flatMap((t:any) =>
        t.indicates.map((i:any) => {
            const key = `${t.id_topic}-${i.id_indicate}`
            const file = fileMap.value[key]
            if(file)formData.append(`file_${key}`,file)
            return{
                id_topic:t.id_topic,
                id_indicate:i.id_indicate,
                score:i.score,
                detail_eva:i.detail_eva,
                file_key:file ? `file_${key}` :null
        
            }
        })
    )
    if(allScore.some((s:any)=> !s.score)){
        alert('กรุณากรอกคะแนนให้สมบูรณ์')
        return
    }
    formData.append('scores',JSON.stringify(allScore))
    try {
        await axios.post(`${eva}/selfeva/save`,formData,{headers:{Authorization:`Bearer ${token}`}})
        alert('ประเมินสำเร็จ')
        await Promise.all([fetchTopics(),fetchUser()])
        // window.location.reload()
    } catch (error) {
        console.error('Error POST Score!',error)
    }
}
</script>

<style scoped>

</style>