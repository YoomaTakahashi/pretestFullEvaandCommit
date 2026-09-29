const experss = require('express')
const db = require('../../db')
const router = experss.Router()
const {verifyToken,requireRole} = require('../../middleware/authmiddleware')
const bc = require('bcrypt')

router.get('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`select fname,lname,username,email,role from tb_member where id_member=?`,[id_member])
        res.json(rows[0])
    } catch (error) {
        console.error('ERROR GET USER',error)
        res.status(500).json({message:'ERROR GET USER'})
    }
})

router.put('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const {fname,lname,email,username,password,role} = req.body
        if(password && password.trim()){
            const hash = await bc.hash(password,10)
            await db.query(`update tb_member set fname=?,lname=?,email=?,username=?,password=?,role=? where id_member='${id_member}'`,[fname,lname,email,username,hash,role])
        }else{
            await db.query(`update tb_member set fname=?,lname=?,email=?,username=?,role=? where id_member='${id_member}'`,[fname,lname,email,username,role])
        }
        res.json({message:'Update Sucesss!'})
    } catch (error) {
        console.error('ERROR UPDATE',error)
        res.status(500).json({message:'ERROR UPDATE'})
    }
})

module.exports = router