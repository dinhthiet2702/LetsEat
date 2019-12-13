const  express = require('express');
const app  = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({
    extended : false
}));
var data = require('./Module/Person');

function Person(id,user,pass){
    this.id = id;
    this.user = user;
    this.pass = pass;

}
var arrPerson = [
    new Person('1','admin','admin'),
    new Person('2','admin1','admin123')


]
app.get('/ios',function (req,res) {
    res.send(arrPerson)
});
app.post('/login', function (req,res) {
    const username = req.body.username;
    const password= req.body.password;
    var i ;
    for(i = 0 ; i < arrPerson.length ; i++){
        if (username == arrPerson[i].user && password == arrPerson[i].pass){
            res.json({
                result  : true,
                message : 'Dang nhap thanh cong' ,
                data : arrPerson

            });
        }
        else{
            res.json({
                result  : false,
                message : 'Dang nhap that bai' ,
                data : []

            });
        }
    }


    // res.send('Hello login')
    
});
app.listen('3000');