CREATE TABLE users (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    last_name CHAR(150) NOT NULL,
    first_name CHAR(150) NOT NULL,
    middle_name CHAR(150) NULL,
    description CHAR(1000) NULL,
    avatar_id CHAR(100) NULL,
    city CHAR(150) NULL,
    interests CHAR(100)[] NULL
)

CREATE TABLE communities (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    name CHAR(150) NOT NULL,
    description CHAR(2000) NULL
)

CREATE TABLE communitiesUsers (
    user_id INTEGER NOT NULL,
    community_id INTEGER NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_community FOREIGN KEY(community_id) REFERENCES communities(id)
)

CREATE TABLE chats (
    id INTEGER NOT NULL SERIAL PRIMARY KEY
)

CREATE TABLE chatsUsers (
    user_id INTEGER NOT NULL,
    chat_id INTEGER NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_chat FOREIGN KEY(chat_id) REFERENCES chats(id)
)

CREATE TABLE messages (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    chat_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    text CHAR(2000) NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_chat FOREIGN KEY(chat_id) REFERENCES chats(id)
)

CREATE TABLE lastSeenMessages (
    message_id INTEGER NOT NULL,
    chat_id INTEGER NOT NULL,
    CONSTRAINT fk_message FOREIGN KEY(message_id) REFERENCES messages(id),
    CONSTRAINT fk_chat FOREIGN KEY(chat_id) REFERENCES chats(id)
)

CREATE TYPE publisher_type AS ENUM ('user', 'community');
CREATE TABLE publishers (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    publisher_id INTEGER NOT NULL,
    type publisher_type NOT NULL
)

CREATE TABLE posts (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    publisher_id INTEGER NOT NULL,
    description CHAR(2000) NULL,
    photo_url CHAR(100) NULL,
    video_url CHAR(100) NULL,
    audio_url CHAR(100) NULL,
    CONSTRAINT fk_publisher FOREIGN KEY(publisher_id) REFERENCES publishers(id)
)

CREATE TABLE hashtags (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    text CHAR(50) NOT NULL
)

CREATE TABLE postsHashtags (
    post_id INTEGER NOT NULL,
    hashtag_id INTEGER NOT NULL,
    CONSTRAINT fk_post FOREIGN KEY(post_id) REFERENCES posts(id),
    CONSTRAINT fk_hashtag FOREIGN KEY(hashtag_id) REFERENCES hashtags(id)
)

CREATE TABLE likes (
    id INTEGER NOT NULL SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_post FOREIGN KEY(post_id) REFERENCES posts(id),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    UNIQUE (post_id, user_id)
)

CREATE TABLE postsViewings (
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT fk_post FOREIGN KEY(post_id) REFERENCES posts(id),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
    UNIQUE (post_id, user_id)
)

CREATE TABLE postsComments (
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    text CHAR(500) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_post FOREIGN KEY(post_id) REFERENCES posts(id),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id),
)