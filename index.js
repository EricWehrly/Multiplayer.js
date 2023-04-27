'use strict'

// 'Hello World' nodejs6.10 runtime AWS Lambda function
exports.handler = (event, context, callback) => {
    console.log('Hello, world!');
    callback(null, 'great success');
}