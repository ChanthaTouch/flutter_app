<?php

// routes/api.php
use App\Http\Controllers\AuthController;
use App\Http\Controllers\SaleController;
use App\Http\Controllers\TargetController;
use Illuminate\Support\Facades\Route;

// Public Route
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes (Requires Token)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // Sales
    Route::get('/sales', [SaleController::class, 'index']);
    Route::post('/sales', [SaleController::class, 'store']);

    // Targets (Manager Setting Targets)
    Route::get('/targets', [TargetController::class, 'index']);
    Route::post('/targets', [TargetController::class, 'store']);
});