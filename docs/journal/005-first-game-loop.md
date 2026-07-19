# First Complete Gameplay Loop

## Goal

Create a gameplay loop that can be repeated indefinitely.

## What Did I Learn?

A game loop is more important than individual mechanics.

GameManager can coordinate systems.

Spawning objects dynamically creates replayability.

## Why Does It Matter?

The game now has a complete play cycle.

Players can continue playing indefinitely.

## What Broke?

Package spawning initially failed because add_child()
was called while the scene tree was still being built.

## How Did I Fix It?

Used call_deferred() to delay spawning until the
scene tree was ready.