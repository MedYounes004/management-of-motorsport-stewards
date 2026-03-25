# Management of Motorsport Stewards

A web-based management system for organizing and supervising motorsport events, stewards (commissioners), incidents, and performance analytics — tailored for a regional motorcycling federation.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Database Schema](#database-schema)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [Usage](#usage)

## Overview

This system provides a centralized platform for managing motorsport events across regional associations in Tunisia. It covers commissioner registration and assignment, event scheduling, incident tracking, and statistical reporting.

## Features

- **Commissioner Management** — Register stewards with personal details, license types (competition, refereeing, technical), salary, and regional association (ASSM/CCR).
- **Event Management** — Create and track motorsport events (Moto-Cross, Endurance, Rally, Speed, Superbike, etc.) with dates and locations.
- **Incident Tracking** — Log incidents during events and link them to the responsible stewards, with intervention descriptions.
- **Performance Analytics** — View intervention counts grouped by event type, events supervised per commissioner, and historical statistics.
- **Dynamic Data Display** — Fetch and display commissioners, events, and analytics directly from the homepage via AJAX.

## Technologies Used

| Layer | Technology |
|---|---|
| Backend | PHP (MySQLi) |
| Database | MySQL |
| Frontend | HTML5, CSS3, JavaScript |
| CSS Framework | Bootstrap 3, Font Awesome |
| Animations | Animate.css, WOW.js |

## Database Schema

The database (`pfa.sql`) contains 11 tables:

| Table | Description |
|---|---|
| `FSM` | Sports Federation Master |
| `ASSM` | Regional Motorcycling Associations |
| `CCR` | Regional Racing Commissions |
| `LICENCE` | Commissioner Licenses |
| `COMMISSAIRE` | Stewards / Commissioners |
| `EPREUVE` | Sporting Events / Races |
| `INCIDENT` | Race Incidents |
| `CONTENIR` | Event–Incident relationships |
| `INTERVENIR` | Commissioner–Incident interventions |
| `ENCADRER` | Commissioner–Event assignments |
| `CHOISIR` | Commissioner selection requests |

## Project Structure

```
├── index2.html          # Main landing page (navigation, forms, statistics)
├── affich.php           # Displays all commissioners
├── affich1.php          # Displays all events
├── affich2.php          # Intervention analytics by event type
├── connexion.php        # Commissioner registration form processor
├── conn.php             # Event registration form processor
├── pfa.sql              # Database schema and seed data
├── base.txt             # Database structure notes
├── css/                 # Bootstrap, Font Awesome, custom styles
├── js/                  # JavaScript libraries
├── fonts/               # Font Awesome fonts
└── images/              # Theme images and logos
```

## Setup & Installation

### Prerequisites

- PHP 5.6+ (or PHP 7.x)
- MySQL 5.x
- A local server such as [XAMPP](https://www.apachefriends.org/) or [WAMP](https://www.wampserver.com/)

### Steps

1. **Clone or copy** the project folder into your web server's document root (e.g., `htdocs/` for XAMPP).

2. **Import the database** using phpMyAdmin or the MySQL CLI:
   ```bash
   mysql -u root -p < pfa.sql
   ```

3. **Configure the database connection** in `affich.php`, `affich1.php`, `affich2.php`, `connexion.php`, and `conn.php`. Update the credentials if needed (default: `localhost`, user `root`, no password, database `pfa`):
   ```php
   $conn = mysqli_connect("localhost", "root", "", "pfa");
   ```

4. **Start your local server** and open the application in a browser:
   ```
   http://localhost/<project-folder>/index2.html
   ```

## Usage

1. **Register a Commissioner** — Fill out the steward registration form on the homepage and submit.
2. **Register an Event** — Fill out the event registration form to add a new motorsport race.
3. **View Data** — Use the display buttons on the homepage to load:
   - The full list of commissioners
   - All events with dates and types
   - Intervention statistics grouped by event type
