<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 2 || user.status_eva === 3 ">
                    <h1 class="text-h5 font-weight-bold">แบบประเมินตนเอง</h1>
                    <v-card class="mt-3 pa-3" :elevation="5" >
                        <p>ผู้ใช้งาน : {{ user.fname }} {{ user.lname }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,t) in topics" :key="topic.id_topic">
                        <v-col cols="12">
                            <h1 class="text-h5 font-weight-bold">{{ Number(t)+1 }}.{{ topic.name_topic }}</h1>
                            <v-table class="table " >
                                <tr>
                                    <th class="bg-grey border pa-1" style="width: 10%;">ตัวชี้วัด</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">รายละเอียดตัวชี้</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">น้ำหนักคะแนน</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">คะแนนเต็ม</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">ประธาน</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">กรรมการ</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">เลขา</th>
                                    <th class="bg-grey border pa-1" style="width: 10%;">คะแนนที่ได้</th>
                                </tr>
                                <tr v-for="indicate in topic.indicates" :key="indicate.id_indicate">
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ indicate.name_indicate }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ indicate.detail_indicate }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ indicate.point_indicate }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ indicate.point_indicate*4 }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ scores[indicate.indicate]?.a ?? 'รอประธานประเมิน' }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ scores[indicate.indicate]?.b ?? 'รอประธานประเมิน' }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ scores[indicate.indicate]?.c ?? 'รอประธานประเมิน' }}</td>
                                    <td class="border pa-1 text-center" style="width: 10%;" >{{ (((scores[indicate.indicate]?.a ?? 0)+(scores[indicate.indicate]?.b ?? 0)+(scores[indicate.id_indicate]?.c ?? 0))/3).toFixed(2) }}</td>
                                </tr>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="text-center mt-4">
                        <v-card color="success" class="pa-2 text-end">คะแนนนรวมสุทธิ : {{ ((user.total_commit)/3).toFixed(2) }} คะแนน</v-card>
                    </div>
                    <div class="mt-4">
                        <v-card class="pa-2">
                            <label for="">ข้อเสนอแนะของกรรมการ</label>
                            <v-row>
                                <v-col cols="12" v-for="(commit,c) in commits" :key="commit.id_commit">
                                    {{ c+1 }}.{{ commit.level_commit }} : {{ commit.detail_commit || 'รอการประเมิน' }}

                                </v-col>
                            </v-row>
                        </v-card>
                    </div>
                </v-form>
                <v-alert type="success" variant="tonal" v-else-if="user.status_eva === 1">ยังไม่ได้ประเมินตนเอง</v-alert>
                <v-alert type="error" variant="tonal" v-else>ยังไม่ได้ประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios, { all } from 'axios';
import { eva } from '~/API/base';

const topics = ref<any>([])
const user = ref<any>({})
const scores =ref<any>([])
const commits = ref<any>([])

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
        const res = await axios.get(`${eva}/score_member/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPICS  ',error)
    }
}
const fetchCommit = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${eva}/score_member/topic`,{headers:{Authorization:`Bearer ${token}`}})
        commits.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPICS  ',error)
    }
}
const fetchScore = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${eva}/score_member/topic`,{headers:{Authorization:`Bearer ${token}`}})
        scores.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPICS  ',error)
    }
}

onMounted(async()=>{
    Promise.all([fetchUser(),fetchTopics(),fetchCommit(),fetchScore()])
})


</script>

<style scoped>

</style>