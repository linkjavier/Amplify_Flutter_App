const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({region:'us-west-2'});
exports.handler = (event, context, callback) => {
    var params ={
        Item: {
            id: "12345",
            Name: "Javier",
            Surname: "Charria"
        },
        TableName: 'homeowner'
    };
    docClient.put(params,function(err,data){
        if(err){
            callback(err,null);
        }else{
            callback(null,"HomeOwner Created");
        }
    });
};