var exec = require('cordova/exec');

// exports.coolMethod = function (arg0, success, error) {
//     exec(success, error, 'JitsiVCall', 'coolMethod', [arg0]);
// };

exports.startconfig = function (arg0, success, error) {
    exec(success, error, 'JitsiVCall', 'startconfig', [arg0]);
}

// var PLUGINNAME_CALL = 'JitsiVCall';

// var JitsiVCall = {
//     getCall: function (cb,arg0){
//         exec(success, error, PLUGINNAME_CALL, 'getCall', [arg0]); 
//     }
// };

// module.exports = JitsiVCall;