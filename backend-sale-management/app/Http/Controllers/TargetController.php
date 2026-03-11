<?php

namespace App\Http\Controllers;

use App\Models\Target;
use Illuminate\Http\Request;

class TargetController extends Controller
{
    // Get targets (Managers see all, Staff see only theirs)
    public function index(Request $request)
    {
        if ($request->user()->role === 'manager') {
            // Managers can see all targets, along with the user data
            $targets = Target::with('user')->get();
        } else {
            // Staff can only see their own targets
            $targets = $request->user()->targets()->get();
        }

        return response()->json($targets);
    }

    // Save a new target from SetTargetScreen
    public function store(Request $request)
    {
        // Security check: Only managers can set targets
        if ($request->user()->role !== 'manager') {
            return response()->json([
                'message' => 'Unauthorized. Only managers can set targets.'
            ], 403);
        }

        $validated = $request->validate([
            'user_id' => 'required|exists:users,id', // ID of the staff member
            'month' => 'required|string',
            'year' => 'required|integer',
            'target_amount' => 'required|numeric',
        ]);

        // We use updateOrCreate so if a manager sets a target for "April 2025" twice, 
        // it updates the existing one instead of creating a duplicate row.
        $target = Target::updateOrCreate(
            [
                'user_id' => $validated['user_id'],
                'month' => $validated['month'],
                'year' => $validated['year'],
            ],
            [
                'target_amount' => $validated['target_amount']
            ]
        );

        return response()->json([
            'message' => 'Target saved successfully',
            'target' => $target
        ], 201);
    }
}
