const  express = require('express');
const app  = express();
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended:true}));
const jwt = require('jsonwebtoken');
const secret = 'letseat';
const { Pool } = require('pg');
var pool = null;
function connectPool(){
    pool = new Pool({
        user: 'postgres',
        host: 'localhost',
        database: 'LetsEat',
        password: '0909',
        port: 5432,
    });
}
// var data = require('./Module/Person');

var arrPerson = [
    new Person('1', 'abc', 1999, 'male'),
    new Person('2', 'abc1', 1999, 'male'),
    new Person('3', 'abc2', 1999, 'male'),
    new Person('4', 'abc3', 1999, 'male'),
    new Person('5', 'abc4', 1999, 'male'),
    new Person('6', 'abc5', 1999, 'male')
]
app.post('/login', function (req,res) {
    const {username, password} = req.body;
    const query = `select * from "User" where "username"='${username}' and "password"=MD5('${password}')`
    connectPool();
    pool.query(query, function(err, result){
        if (result.rowCount == 0){
               res.json({result: false, message:'Đăng nhập thất bại', data: [], token:''});
           }
           else{
               const token = jwt.sign(result.rows[0],secret,{expiresIn : 30000000000});
               res.json({result: true, message:'Đăng nhập thành công', data: arrPerson, token:token});
           }
   });
   pool.end();
});
app.post('/check', function(req, res){
    const token = req.body.token;
    jwt.verify(token,secret, function(err,decoded){
        if (err){
            res.json({result:false, message: 'Đăng nhập quá hạn', data:[]});
        }
        else{
            req.decoded = decoded;
            res.json({result:true, message: 'Đăng nhập thành công', data:arrPerson});
        }
    });
});
app.post('/register', function(req,res){
    connectPool();
    const {username, password, isCheck} = req.body;
    pool.query(`select * from "User" where "username" = '${username}'`,
    function(err, result){
        console.log(isCheck);
            if (result.rowCount == 1) {
                res.json({result : false, message : 'Tài khoản tồn tại', data : []});
            } else if(isCheck == 'false'){
                let query = `insert into "User" ("username", "password")
                values ('${username}', MD5('${password}'))`
                connectPool();
                pool.query(query, function(err, result){
                    res.json({result : true, message : 'Đăng kí thành công', data : []});
                });
                pool.end();
            } else {
                res.json({result : false, message : 'Tài khoản có thể sử dụng', data : []});
            }
    });
    pool.end();
});
app.listen(3000);
function Person(id, name, age, gender){
    this.id = id;
    this.name = name;
    this.age = age;
    this.gender = gender;
}