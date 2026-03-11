<?php

// app/Http/Controllers/SaleController.php
namespace App\Http\Controllers;

use App\Models\Sale;
use Illuminate\Http\Request;

class SaleController extends Controller
{
    // Get sales for the logged-in user (for Daily Report)
    public function index(Request $request) {
        $sales = $request->user()->sales()->with('items')->get();
        return response()->json($sales);
    }

    // Save a new sale (From AddSaleScreen)
    public function store(Request $request) {
        $validated = $request->validate([
            'customer_name' => 'required|string',
            'total_price' => 'required|numeric',
            'sale_date' => 'required|date',
            'items' => 'array', // Array of products from ChooseProductScreen
        ]);

        // Create the sale
        $sale = $request->user()->sales()->create([
            'customer_name' => $validated['customer_name'],
            'total_price' => $validated['total_price'],
            'sale_date' => $validated['sale_date'],
        ]);

        // Attach items if they exist
        if (!empty($validated['items'])) {
            $sale->items()->createMany($validated['items']);
        }

        return response()->json(['message' => 'Sale added successfully', 'sale' => $sale], 201);
    }
}