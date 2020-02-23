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
               res.json({result: true, message:'Đăng nhập thành công', data: result.rows, token:token});
           }
   });
   
   pool.end();
});
app.post('/more', function(req,res){
    const {id,gender} = req.body;
    const query = `update "User" set "gender" = '${gender}' where "id"='${id}'`
    connectPool();
    pool.query(query, function(err, result){
        res.json({result:true});
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
            res.json({result:true, message: 'Đăng nhập thành công', data:[]});
        }
    });
});
app.post('/register', function(req,res){
    connectPool();
    const {firtname, lastname, birtday, email, phonenumber, username, password, isCheck} = req.body;
    pool.query(`select * from "User" where "username" = '${username}'`,
    function(err, result){
        console.log(isCheck);
            if (result.rowCount == 1) {
                res.json({result : false, message : 'Tài khoản tồn tại'});
            } else if(isCheck == 'false'){
                let query = `insert into "User" ("firtname","lastname","birtday","email","phonenumber","username", "password")
                values ('${firtname}','${lastname}','${birtday}','${email}','${phonenumber}','${username}', MD5('${password}'))`
                connectPool();
                pool.query(query, function(err, result){
                    res.json({result : true, message : 'Đăng kí thành công'});
                });
                pool.end();
            } else {
                res.json({result : true, message : 'Tài khoản có thể sử dụng'});
            }
    });
    pool.end();
});
app.get('/delivery', function(req,res){
    const query = `select * from "menufood"`;
    connectPool();
    pool.query(query, function(err, result){
            if (result.rowCount == 0) {
                res.json({result : false, message : 'Chua co mon an', data:[]});
            } else {
                res.json({result : true, message : 'OK',data: result.rows});
            }
    });
    pool.end();
});
app.post('/delivery/menufood', function(req,res){
    const {id} = req.body
    const query = `select * from "kindfood" where "menufood_id"='${id}'`;
    connectPool();
    pool.query(query, function(err, result){
        console.log(result.rowCount)
            if (result.rowCount == 0) {
                res.json({result : false, message : 'Chua co mon an', data:[]});
            } else {
                res.json({result : true, message : 'OK',data: result.rows});
            }
    });
    pool.end();
});
app.post('/delivery/menufood/foods', function(req,res){
    const {id} = req.body;
    const query = `select * from "foods" where "kindfood_id"='${id}'`;
    connectPool();
    pool.query(query, function(err, result){
        console.log(result.rowCount)
            if (result.rowCount == 0) {
                res.json({result : false, message : 'Chua co mon an', data:[]});
            } else {
                res.json({result : true, message : 'OK',data: result.rows});
            }
    });
    pool.end();
});
app.post('/delivery/menufood/foods/changeamount', function(req,res){
    const {id,amount} = req.body;
    const query = `update "foods" set "amount" = '${amount}' where "id"='${id}'`
    connectPool();
    pool.query(query, function(err, result){
        res.json({result:true});
    });
    pool.end();
});
app.post('/delivery/menufood/orderfoods', function(req,res){
    const {namefood, imgfood, price, amount} = req.body;
    const query = `insert into "orderfoods" ("namefood","imgfood","price","amount")
        values ('${namefood}','${imgfood}','${price}','${amount}')`
    connectPool();
    pool.query(query, function(err, result){
        res.json({result : true, message : 'Them thanh cong'});
    });
    pool.end();
});
app.get('/order/foods', function(req,res){
    const query = `select * from "orderfoods"`;
    connectPool();
    pool.query(query, function(err, result){
            if (result.rowCount == 0) {
                res.json({result : false, message : 'Chua co mon an', data:[]});
            } else {
                res.json({result : true, message : 'OK',data: result.rows});
            }
    });
    pool.end();
});
app.post('/order/foods/changeamount', function(req,res){
    const {id,amount} = req.body;
    const query = `update "orderfoods" set "amount" = '${amount}' where "id"='${id}'`
    connectPool();
    pool.query(query, function(err, result){
        res.json({result:true});
    });
    pool.end();
});
app.post('/order/foods/delete', function(req,res){
    const {id} = req.body;
    const query = `delete from "orderfoods" where "id"='${id}'`
    connectPool();
    pool.query(query, function(err, result){
        res.json({result:true});
    });
    pool.end();
});
app.listen(3000);
