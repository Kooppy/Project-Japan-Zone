const upload = require('../config/multer.js');

exports.createUser = (req, res) => {

    const file = req.file.filename; 

    let sql = `INSERT INTO user SET email= ?, avatar= ?, pseudo= ?, mot_de_passe= ?`;
    let values = [
        req.body.email,
        file,
        req.body.pseudo,
        req.body.password
    ];

    db.query(sql, values, function (err) {
        if (err) console.error('error :' + err.stack);
        res.redirect('back');
    }); 
}

exports.loginUser = (req, res) => {
    /*let sql = `SELECT * FROM user WHERE (pseudo = :pseudo OR email = :pseudo) AND confirmation_date IS NULL`;*/
    //let user = db.query(`SELECT * FROM user WHERE pseudo= ?`, req.body.pseudo, function (result){console.log(result);});
    let values = [
        req.body.pseudo
    ];
    /*console.log("test :", user);*/
    db.query("SELECT * FROM user WHERE pseudo= ?", values, function (err, data) {
        if (err) console.error('error : ' + err.stack);
        //let user = {data}
        console.log(data.email);
        // console.log(user.email);
        // console.log(data.email);
    })
    console.log(req.body);
    res.redirect('back');
}