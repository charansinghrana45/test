php artisan config:clear
php artisan cache:clear
composer dump-autoload

<?php
//helpers
url('/admin'); //to make url link by providing url
route('admin-dashboard'); //to make url link by using route name
redirect(); //to redirect from one page to another
csrf_token(); //to generate hidden _token input field with value totken
method_field('PUT'); //to generate hidden _method input filed with value put

//routing
Route::get('/test/{name}', function ($name) { return view('welcome'); })->where(['name'=>'[0-9]+'])->name('test-url');
Route::get('/test/{name}', 'AdminController@index')->where(['name'=>'[0-9]+'])->name('test-url');
Route::get('/test/{name}', [
		'as' => 'test-url2',
		'uses' => 'AdminController@index',
		'middleware' => 'web',
	])->where(['name'=>'[0-9]+']);

Route::group(['middleware'=>'web','namespace'=>'admin','prefix'=>'admin'],function (){
	Route::get('/test/{name}', 'AdminController@index')->where(['name'=>'[0-9]+'])->name('test-url');
});	
Route::match(['get','post'],'/test/{name}', 'AdminController@index')->where(['name'=>'[0-9]+'])->name('test-url');	
Route::any('/test/{name}', 'AdminController@index')->where(['name'=>'[0-9]+'])->name('test-url');

//to pass data to view
return view('test',compact('data'));
return View::make('test',compact('data'));
return view('test')->with(['data' => $data]);
return view('test')->withData($data);

//middleware
$request->route('id')  //to receive parameters in middleware
$request->route()->parameters(); //to receive all parameters in middleware

inside controller method middleware
$this->middleware(['web','auth']);
$this->middleware(['web','auth'],['only'=>['dashboard','index']]);
$this->middleware(['web','auth'],['except'=>['index']]);

//blade template
asset('public/css/bootstrap/bootstrap.min.css') //to load css
asset('public/css/bootstrap/bootstrap.min.js') //to load js
@extends('layout.master')
@yield('content')
@section('content')
@endsection
{{ $data }} //render data in view with htmlentities
{!! $data !!} //render data in view without htmlentities
@{{ data }} //to remain unchanged by blade engine
<p>{{ $data or "not found" }}</p>
@php $x = 0; @endphp //to ececute raw php code

//sessions
session() //helper function to manipulate session data
$request->session() //request instance to manipulate section data

$value = $request->session()->get('key', 'default');   //retrieve a value from the session if not set return default value
$value = $request->session()->get('key', function () { return 'default'; }); //retrieve a value from the session

session()->has('msg2')  //if session variable exists with some value (variable should not hold null value)
session()->exists('msg2') //if session variable exists then return true also works for variable with null value

session()->push('key','value'); 

session()->flash('key','value');
$request->session()->reflash();
$request->session()->keep(['username', 'email']);

$request->session()->forget('key');
$request->session()->flush();

$request->session()->pull('key', 'default');



