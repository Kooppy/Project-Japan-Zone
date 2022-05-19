/*
 * Controller: Messagery (Messagery)
 * ************************ */

const { pagination } = require('../util/pagination'),
      { sendMail } =require('../util/nodemailer');

exports.messagery = async (req, res) => {

    const message = req.session.msg;

    req.session.msg= '';

    let pagiMessagery = await pagination({
        numItem: 10,
        page: req.query.messagery,
        table: 'messagery'
    });

    console.log(pagiMessagery);
    
    try {
        const messagery = await db.query(`SELECT * FROM messagery ORDER BY num_messagery DESC LIMIT ${pagiMessagery.limit};`);
        
        res.render('messagery', {
            layout: 'adminLayout',
            namePage: 'Messagery',
            messagery,
            paginate: pagiMessagery.page,
            message
        });
    } catch (err) {
        throw err;
    }
}

exports.sendEmail = async (req, res) => {

    const { name, email, subject, message } = req.body;

    console.log(email);

    try {
        let result = await sendMail({toEmail: email, subject, message: `${message} Cordialement, ${name}`, validate: 'Email, envoyer'});

        // res.render('messagery', {flash: result.flash});
        req.session.msg = result.flash
        res.redirect('back');
    } catch (err) {
        throw err;
    }
}

exports.deleteMessage = async (req, res) => {

    const { id } = req.params;
    
    try {
        const deleteMessage = await db.query('DELETE FROM messagery WHERE num_messagery= :id;', {id});
        
        req.session.msg = 'Message supprimer'
        res.redirect('back');
    } catch (err) {
        throw err;
    }
}