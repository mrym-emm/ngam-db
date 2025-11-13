# Database Migration to Google Cloud SQL - Setup Instructions 
(only on - feat/backend/cloud-sql-migration - not published yet)

## What's Changed 

* Our backend now connects to Cloud SQL instead of local PostgreSQL
* All database tables have been created on the Cloud SQL instance
* The database is currently empty (no data yet, just table structure)

## To Use Cloud SQL Connection

1. Make sure you're on the `refactor/frontend/connect-to-db` branch

2. Get the service account JSON file from me: `gaia-capstone4-prd-85a4ee482e4e.json`

3. Place it in: `backend/.gcp/` folder

4. Update your `backend/.env` file with:

```bash
# Cloud SQL Configuration
INSTANCE_CONNECTION_NAME=gaia-capstone4-prd:us-central1:booksdb
POSTGRES_USER=postgres
POSTGRES_PASSWORD=Admin123!
POSTGRES_DB=ngamjedb
GOOGLE_APPLICATION_CREDENTIALS=/mnt/c/Users/[YOUR_USERNAME]/OneDrive/Desktop/capstone_final/ngam-je/backend/.gcp/gaia-capstone4-prd-85a4ee482e4e.json
```

5. Install the required packages:

```bash
uv pip install cloud-sql-python-connector pg8000
```

6. Start the backend:

```bash
uv run uvicorn src.app.main:app --reload --host 0.0.0.0 --port 8000
```

## To Use Local Database Instead

* Comment out `INSTANCE_CONNECTION_NAME` in `.env`
* The code will automatically fall back to local `DATABASE_URL`

## Files Modified

* `backend/src/database.py` - Added Cloud SQL Connector logic
* `backend/alembic/env.py` - Updated for Cloud SQL migrations
* `backend/.env` - Added Cloud SQL credentials
* `.gitignore` - Protected credentials from being committed

Let me know if you need help setting it up!

---

## Important Notes

**Don't forget to:**
* Share the `gaia-capstone4-prd-85a4ee482e4e.json` file securely (Slack DM, encrypted email, NOT in git)
* Share the database password: `Admin123!`
* Let them know the database instance is already created and configured
