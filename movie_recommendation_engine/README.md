## 🎬 Movie Recommendation Engine

A PostgreSQL-based movie recommendation engine that analyzes user preferences, movie ratings, and genres to suggest personalized movies. This project demonstrates how structured SQL queries, database design, and reporting views can be used to generate useful insights and export data for practical applications.

---

### 📌 Project Overview

This project focuses on building a data-driven movie recommendation engine using PostgreSQL. The system recommends movies based on:
- User ratings
- Movie genres
- Average movie scores
- Popularity metrics

The core objective is to analyze user preferences and provide meaningful recommendations using SQL logic and reporting views.

---

### 🗃️ Database Schema

The project uses the following normalized database schema:

### 1. `users`
| Column Name | Type     | Description              |
|-------------|----------|--------------------------|
| user_id     | INTEGER  | Primary key (User)       |
| username    | TEXT     | Unique username          |
| email       | TEXT     | Email of the user        |

---

### 2. `movies`
| Column Name | Type     | Description              |
|-------------|----------|--------------------------|
| movie_id    | INTEGER  | Primary key (Movie)      |
| title       | TEXT     | Movie title              |
| genre       | TEXT     | Genre (e.g., Action, Drama) |
| release_year| INTEGER  | Year of release          |

---

### 3. `ratings`
| Column Name | Type     | Description              |
|-------------|----------|--------------------------|
| rating_id   | INTEGER  | Primary key              |
| user_id     | INTEGER  | Foreign key → users      |
| movie_id    | INTEGER  | Foreign key → movies     |
| rating      | FLOAT    | Rating (e.g., 0 to 5)     |
| rating_date | DATE     | When the rating was given|

---

### ✨ Features

- ✅ Recommend top-rated movies by genre
- ✅ Recommend movies for new users (cold start)
- ✅ Recommend movies based on user history
- ✅ Calculate average rating per genre
- ✅ View most active users
- ✅ Recommend unseen but highly rated movies
- ✅ Export recommendation results to `.csv`

---

### 📊 Views and Reports

#### 🔹 Reporting Views Created:

1. **`top_rated_movies`**  
   Displays highest-rated movies based on average ratings and number of reviews.

2. **`user_rating_summary`**  
   Shows total ratings, average score, and last activity per user.

3. **`genre_popularity`**  
   Aggregates average ratings and number of ratings per genre.

4. **`most_active_users`**  
   Lists users based on rating frequency.

5. **`recommended_movies_for_users`**  
   Suggests top movies a specific user hasn’t rated yet, based on global popularity.

---

### 📤 Exporting Recommendations

I have exported recommended movies using the following tools:

#### GUI-based :
- **DBeaver** → Right-click on query results → `Export Resultset` → Choose `.csv`
- **pgAdmin** → Run query → Export results using grid toolbar

---

### 💻 Tech Stack

| Layer        | Technology           |
|--------------|----------------------|
| Database     | PostgreSQL           |
| Tools Used   | DBeaver, pgAdmin     |
| Export Tools | DBeaver, Python, psql|
| Language     | SQL                  |

---

### ▶️ How to Use

1. Set up the PostgreSQL database and import the schema and data.
2. Run the defined SQL queries and views to generate insights.
3. Export recommendations using preferred method (GUI or Python).
4. Integrate exported files in dashboards or reports as needed.

---

### 📚 Future Enhancements

- Add collaborative filtering using Python ML libraries
- Integrate with a Flask or React frontend
- Schedule automatic exports or email reports
- Connect to a recommendation API (e.g., TMDB)

---

### 🧾 License

This project is for my personal educational and portfolio use. Attribution appreciated if used in public repositories.

---

### 🙌 Acknowledgments

- Dataset inspired by [MovieLens](https://grouplens.org/datasets/movielens/)
- Tools: PostgreSQL, DBeaver, pgAdmin

---

**👩‍💻 Created by:** Dimple Mundhra  
**📅 Date:** July 2025  
**🎯 Goal:** Build an end-to-end recommendation system using SQL
