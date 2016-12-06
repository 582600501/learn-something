/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  NativeAppEventEmitter,
} = React;

var MyNativeModule = require('NativeModules').MyNativeModule;
var MyNativeStaticModule = require('my-native-static-module');
// console.log(require('NativeModules'));

var subscription = NativeAppEventEmitter.addListener(
	 'afterHello',
	 (data) => {
	 	console.log("afterHello");	
		console.log(data);	
	 } 
 );

console.log(MyNativeModule);
console.log(MyNativeModule.a + "|" + MyNativeModule.b);


var CallNativeModuleView = React.createClass({
  //render方法之前
  componentWillMount:function(){
     
  },
  clicked:function(){
 	  MyNativeModule.Hello(function(){
        console.log(arguments);
      });
  },
  render: function() {
  	
    // console.log(React.NativeModules);
    // console.log('>>>>>>>>>>');
    // console.log(MyNativeModule);
    // console.log('>>>>>>>>>>');

    return (
      <View style={{flex:1,justifyContent:'center',alignItems:'center',flexDirection:'column'}}>
     		<Text  style={{flex:1,top:80}}onPress={this.clicked}> 
		   		本节主要演示内容：react-native 调用原生ios模块,点击文字调用原生Hello()方法，并且会收到
		   		"afterHello"的事件通知
   			</Text>
        <MyNativeStaticModule></MyNativeStaticModule>
      </View>
    );
  }
});


var styles = StyleSheet.create({

});


module.exports = CallNativeModuleView;
