	USE youtube;
    
    INSERT INTO `user`(email, password, username, birth_date, gender, country, postal_code)
    VALUES
    ('alice@example.com', 'pass123', 'AliceWonder', '1995-05-15', 'FEMALE', 'Spain', 08001),
	('bob@example.com', 'secure456', 'BobTheBuilder', '1990-11-22', 'MALE', 'USA', 90210),
	('charlie@example.com', 'qwerty789', 'CharlieVlogs', '2001-02-10', 'NONBINARY', 'UK', 10001);
    
    INSERT INTO tag (name)
    VALUES
    ('Music'),
    ('Sports'),
    ('Gaming'),
    ('Educational');
    
    INSERT INTO `channel` (name, description, creation_date, user_id)
    VALUES
    ('Alice Adventures', 'Travel and lifestyle vlogs', '2023-01-10 10:00:00', 1),
	('Tech with Bob', 'Gadget reviews and coding tutorials', '2023-03-15 14:30:00', 2);
    
    INSERT INTO playlist (name, creation_date, state, user_id)
    VALUES
    ('My Favorite Tunes', '2023-06-01 09:15:00', 'PUBLIC', 1),
	('Watch Later', '2023-07-20 18:45:00', 'PRIVATE', 2);
    
    INSERT INTO video (title, description, size, file_name, thumbnail, views, likes, dislikes, state, publication_date, user_id)
    VALUES
    ('Trip to Barcelona', 'Exploring the city!', 150.50, 'barca_trip.mp4', NULL, 1200, 150, 2, 'PUBLIC', '2023-05-01 12:00:00', 1),
	('How to build a PC', 'Step by step guide', 500.75, 'pc_build.mp4', NULL, 5000, 300, 10, 'PUBLIC', '2023-05-10 16:20:00', 2),
	('Secret Blog', 'Just for me', 45.20, 'secret.mp4', NULL, 0, 0, 0, 'PRIVATE', '2023-06-05 08:00:00', 1);
    
    INSERT INTO `comment` (text, date_time, user_id, video_id)
    VALUES
    ('Great video! I love Barcelona.', '2023-05-02 09:00:00', 2, 1),
	('Very helpful PC guide, thanks!', '2023-05-11 10:15:00', 3, 2),
	('Can you do a setup tour next?', '2023-05-12 11:30:00', 1, 2);
    
    INSERT INTO subscription (user_id, channel_id, date_time)
    VALUES
    (2, 1, '2023-02-01 10:00:00'),
	(3, 2, '2023-04-01 15:30:00');
    
    INSERT INTO video_has_tag (video_id, tag_id)
    VALUES
    (1, 2),
    (2, 4);
    
    INSERT INTO playlist_contains_video (playlist_id, video_id)
    VALUES
    (2, 1),
    (1, 2);
    
    INSERT INTO user_interacts_with_video ( user_id, video_id, type, date_time)
    VALUES
    (2, 1, 'LIKE', '2023-05-02 08:55:00'),
	(3, 2, 'LIKE', '2023-05-11 10:00:00'),
	(1, 2, 'DISLIKE', '2023-05-12 11:00:00');
    
    INSERT INTO user_interacts_with_comment (user_id, comment_id, date_time, type)
    VALUES
    (1, 1, '2023-05-02 09:05:00', 'LIKE'),
	(2, 3, '2023-05-12 12:00:00', 'LIKE');
    
    
    
    
    
    

