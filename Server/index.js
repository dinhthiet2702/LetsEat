const  express = require('express')
const app  = express()
const bodyPaser = require('body-parser')

app.use(bodyPaser.urlencoded({
    extends : false
}))
var data = require('./Module/Person');


app.get('/ios',function (req,res) {
    res.send(data)
})
app.post('/login', function (req,res) {
    const username = req.body.username;
    const password= req.body.password;
    var i ;
    for(i = 0 ; i < data.length ; i++){
        if (username == data[i].user && password == data[i].password){
            res.json({
                result  : true,
                massager : "Dang nhap thanh cong" ,
                data : [data[i].id]

            })
        }
        else{
            res.json({
                result  : false,
                massager : "Dang nhap thanh cong" ,
                data : []

            })
        }
    }

    // res.send('Hello login')
    
})
app.listen('3000')