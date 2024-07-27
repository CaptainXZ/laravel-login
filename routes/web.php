<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
	return view('/welcome');
});

Route::get('/welcome', function () {
	return 'listen to my heart';
});

// Route Product Controller
Route::get('/product', function() { 
	return 'product';
});


