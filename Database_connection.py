import sqlite3
conn = sqlite3.connect("AdventureWorks.db")
cursor = conn.cursor()



conn.commit()
conn.close()