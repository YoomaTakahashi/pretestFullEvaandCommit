<template>
    <v-container>
        <v-card>
            <v-sheet class="pa-5 text-center">
                <h1 class="text-h5 font-weight-bold">DashBoard - Evaluatee</h1>
            </v-sheet>
             <v-card-text>
                <v-row>
                    <v-col md="4" v-for="b in box" :key="b" cols="12">
                        <v-card :elevation="5" class="pa-4" rounded="5">
                            <div class="text-h5 text-center">{{ b.title }}</div>
                            <div class="text-h5 text-center">{{ b.value }}</div>
                        </v-card>
                    </v-col>
                </v-row>
             </v-card-text>
        </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { api } from '~/API/base';

const token = import.meta.client ? localStorage.getItem('token') :null

const box = ref([])
const fecth = async () => {
    try {
        const res = await axios.get(`${api}/dash/eva`,{headers:{Authorization:`Bearer ${token}`}})
        box.value = res.data.box
    } catch (error) {
        console.error('ERROR GET PROFILE!',error)
    }
}
onMounted(fecth)
</script>

<style scoped>

</style>