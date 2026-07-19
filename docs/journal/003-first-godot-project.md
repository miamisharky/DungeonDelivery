# First Godot Project

## Goal

Understand Godot fundamentals.

## What Did I Learn?

Nodes are building blocks.

Scenes combine nodes.

Scripts add behavior.

## Why Does It Matter?

Every gameplay feature will be built using scenes and nodes.

## What Broke?

Did not attach script when manually created script

## How Did I Fix It?

Can create script from Player

## What Broke?

Nothing significant.

The project launched successfully.

## Observations

The player spawned at world coordinate (0,0),
which appears near the upper-left corner of the level.

Movement felt smooth on a 240Hz display.

## What Broke?

The package would not disappear when the player touched it.

## Root Cause

Collision detection was not properly configured.

The collision shapes were not being detected correctly.

Using Visible Collision Shapes helped visualize the problem.

## How Did I Fix It?

Verified collision shapes existed and were visible.

Corrected the package setup.

Confirmed collision overlap was occurring.

The package now disappears when touched.