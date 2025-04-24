from flask import Flask
import mysql.connector


app = Flask(__name__)

# Connect to MySQL database
db_config = {
    'host': 'db',
    'user': 'user',
    'password': 'password',
    'database': 'counter_db',
}

connection = mysql.connector.connect(**db_config)
cursor = connection.cursor()

# Create the table if it doesn't already exist
cursor.execute("""
CREATE TABLE IF NOT EXISTS hits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    count INT NOT NULL
) ENGINE=InnoDB;
""")

# Ensure the table has at least one row
cursor.execute("SELECT * FROM hits")
if cursor.rowcount == 0:
    cursor.execute("INSERT INTO hits (count) VALUES (0)")
    connection.commit()


@app.route('/')
def hello():
    cursor.execute("SELECT count FROM hits WHERE id = 1")
    row = cursor.fetchone()
    count = row[0] + 1
    cursor.execute("UPDATE hits SET count = %s WHERE id = 1", (count,))
    connection.commit()
    return f"<h1>Hello, World!</h1><p>This page has been viewed {count} times.</p>"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
