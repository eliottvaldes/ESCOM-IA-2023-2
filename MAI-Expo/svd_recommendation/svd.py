import tarfile
import ast
import pandas as pd
import numpy as np

with tarfile.open("./files/lthing_data.tar.gz") as tar:
    print("Files in tar archive:")
    tar.list()

    print("\nSample records:")
    with tar.extractfile("./files/lthing_data/reviews.txt") as file:
        count = 0
        for line in file:
            print(line)
            count += 1
            if count > 3:
                break

# Collect records
reviews = []
with tarfile.open("./files/lthing_data.tar.gz") as tar:
    with tar.extractfile("./files/lthing_data/reviews.txt") as file:
        for line in file:
            try:
                record = ast.literal_eval(line.decode("utf8"))
            except:
                print(line.decode("utf8"))
                raise
            if any(x not in record for x in ['user', 'work', 'stars']):
                continue
            reviews.append([record['user'], record['work'], record['stars']])
print(len(reviews), "records retrieved")

# Print a few sample of what we collected
reviews = pd.DataFrame(reviews, columns=["user", "work", "stars"])
print(reviews.head())

# Look for the users who reviewed more than 50 books
usercount = reviews[["work","user"]].groupby("user").count()
usercount = usercount[usercount["work"] >= 50]

# Look for the books who reviewed by more than 50 users
workcount = reviews[["work","user"]].groupby("work").count()
workcount = workcount[workcount["user"] >= 50]

# Keep only the popular books and active users
reviews = reviews[reviews["user"].isin(usercount.index) & reviews["work"].isin(workcount.index)]
print("\nSubset of data:")
print(reviews)

# Convert records into user-book review score matrix
reviewmatrix = reviews.pivot(index="user", columns="work", values="stars").fillna(0)
matrix = reviewmatrix.values

# Singular value decomposition
u, s, vh = np.linalg.svd(matrix, full_matrices=False)

# Find the highest similarity
def cosine_similarity(v,u):
    return (v @ u)/ (np.linalg.norm(v) * np.linalg.norm(u))

highest_similarity = -np.inf
highest_sim_col = -1
for col in range(1,vh.shape[1]):
    similarity = cosine_similarity(vh[:,0], vh[:,col])
    if similarity > highest_similarity:
        highest_similarity = similarity
        highest_sim_col = col

print("Column %d (book id %s) is most similar to column 0 (book id %s)" %
        (highest_sim_col, reviewmatrix.columns[col], reviewmatrix.columns[0])
)