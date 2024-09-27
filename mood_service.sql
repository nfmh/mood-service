-- Create the mood_service database
CREATE DATABASE mood_service;

-- Connect to the mood_service database
\c mood_service;

-- Create table for moods
CREATE TABLE moods (
    id SERIAL PRIMARY KEY,
    mood_name VARCHAR(50) NOT NULL UNIQUE
);

-- Update quotes table to reference the mood table
CREATE TABLE quotes (
    id SERIAL PRIMARY KEY,
    mood_id INT NOT NULL,
    quote TEXT NOT NULL,
    FOREIGN KEY (mood_id) REFERENCES moods(id) ON DELETE CASCADE
);

-- Update songs table to reference the mood table
CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    mood_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    FOREIGN KEY (mood_id) REFERENCES moods(id) ON DELETE CASCADE
);

-- Update movements table to reference the mood table
CREATE TABLE movements (
    id SERIAL PRIMARY KEY,
    mood_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (mood_id) REFERENCES moods(id) ON DELETE CASCADE
);

-- Insert mood data into the mood table
INSERT INTO moods (mood_name) VALUES
('energized'),
('sleepy'),
('moody'),
('happy'),
('sad');

-- Insert quotes dynamically based on mood names
INSERT INTO quotes (mood_id, quote)
SELECT moods.id, quotes_data.quote
FROM moods
JOIN (
    -- Quotes data for each mood
    VALUES
        ('energized', 'The journey of a thousand miles begins with one step. - Lao Tzu'),
        ('energized', 'Knowing others is intelligence; knowing yourself is true wisdom. - Lao Tzu'),
        ('energized', 'Mastering others is strength; mastering yourself is true power. - Lao Tzu'),
        ('energized', 'When you are content to be simply yourself, you will become unique. - Lao Tzu'),
        ('energized', 'A good traveler has no fixed plans and is not intent on arriving. - Lao Tzu'),
        
        ('sleepy', 'Be still like a mountain and flow like a great river. - Lao Tzu'),
        ('sleepy', 'Silence is a source of great strength. - Lao Tzu'),
        ('sleepy', 'Nature does not hurry, yet everything is accomplished. - Lao Tzu'),
        ('sleepy', 'He who knows that enough is enough will always have enough. - Lao Tzu'),
        ('sleepy', 'Who acts in stillness finds stillness in his life. - Lao Tzu'),
        
        ('moody', 'When I let go of what I am, I become what I might be. - Lao Tzu'),
        ('moody', 'Do the difficult things while they are easy and do the great things while they are small. - Lao Tzu'),
        ('moody', 'New beginnings are often disguised as painful endings. - Lao Tzu'),
        ('moody', 'He who knows does not speak; he who speaks does not know. - Lao Tzu'),
        ('moody', 'Music in the soul can be heard by the universe. - Lao Tzu'),
        
        ('happy', 'Great acts are made up of small deeds. - Lao Tzu'),
        ('happy', 'Health is the greatest possession. Contentment is the greatest treasure. - Lao Tzu'),
        ('happy', 'A journey of a thousand miles begins beneath one’s feet. - Lao Tzu'),
        ('happy', 'From caring comes courage. - Lao Tzu'),
        ('happy', 'The wise man is one who knows what he does not know. - Lao Tzu'),
        
        ('sad', 'He who conquers others is strong; He who conquers himself is mighty. - Lao Tzu'),
        ('sad', 'Being deeply loved by someone gives you strength, while loving someone deeply gives you courage. - Lao Tzu'),
        ('sad', 'If you realize that all things change, there is nothing you will try to hold on to. - Lao Tzu'),
        ('sad', 'The flame that burns twice as bright burns half as long. - Lao Tzu'),
        ('sad', 'When the best leader’s work is done the people say, "We did it ourselves." - Lao Tzu')
) AS quotes_data (mood_name, quote)
ON moods.mood_name = quotes_data.mood_name;


-- Insert songs dynamically based on mood names
INSERT INTO songs (mood_id, title, url)
SELECT moods.id, songs_data.title, songs_data.url
FROM moods
JOIN (
    -- Songs data for each mood
    VALUES
        -- Energized
        ('energized', 'Ob-La-Di, Ob-La-Da', 'https://youtu.be/9x5WY_jmsko'),
        ('energized', 'Go Your Own Way', 'https://youtu.be/oiosqtFLBBA'),
        ('energized', 'Daydreaming', 'https://www.youtube.com/watch?v=G2BYATpr4uY'),
        ('energized', 'What is Life', 'https://www.youtube.com/watch?v=fiH9edd25Bc'),
        ('energized', 'Red Desert', 'https://www.youtube.com/watch?v=_q95ri8GVyk'),
        ('energized', 'Dang!', 'https://www.youtube.com/watch?v=LR3GQfryp9M'),
        ('energized', 'Happiness in Liquid', 'https://www.youtube.com/watch?v=7h4_cD6A5Bs'),
        ('energized', 'Close My Eyes', 'https://youtu.be/wfkcnek1wE8'),
        ('energized', 'Too Sweet', 'https://www.youtube.com/watch?v=aezstCBHOPQ'),
        ('energized', 'Houdini', 'https://www.youtube.com/watch?v=22tVWwmTie8'),
        ('energized', 'Glorious', 'https://www.youtube.com/watch?v=7OrLroFa0AI'),
        
        -- Sleepy
        ('sleepy', 'Im Only Sleeping', 'https://www.youtube.com/watch?v=5XwXliCK19Y'),
        ('sleepy', 'Never Going Back Again', 'https://www.youtube.com/watch?v=_HM6FrSitvc'),
        ('sleepy', 'From the Dining Table', 'https://youtu.be/1ZxF_nA1SxQ'),
        ('sleepy', 'Behind That Locked Door', 'https://www.youtube.com/watch?v=kuIXiy_eqzw'),
        ('sleepy', 'Tenerife Sea', 'https://youtu.be/2tHes1FQfwU'),
        ('sleepy', 'Slow Dancing In a Burning Room', 'https://www.youtube.com/watch?v=IfFi4Q7ueA8'),
        ('sleepy', 'All The Pretty Girls', 'https://www.youtube.com/watch?v=FNwgOkl5nRY'),
        ('sleepy', 'Repeat', 'https://www.youtube.com/watch?v=UzjITlO0eEg'),
        ('sleepy', 'Cherry Wine', 'https://www.youtube.com/watch?v=SdSCCwtNEjA'),
        ('sleepy', 'Mockingbird', 'https://youtu.be/S9bCLPwzSC0'),
        ('sleepy', 'Whered you go', 'https://www.youtube.com/watch?v=Y9SUZGOOXkY'),
        
        -- Moody
        ('moody', 'Come Together', 'https://www.youtube.com/watch?v=45cYwDMibGo'),
        ('moody', 'The Chain', 'https://www.youtube.com/watch?v=xwTPvcPYaOo'),
        ('moody', 'Lights Up', 'https://www.youtube.com/watch?v=9NZvM1918_E'),
        ('moody', 'Iron Sky', 'https://www.youtube.com/watch?v=ELKbtFljucQ'),
        ('moody', 'Thin White Lies', 'https://www.youtube.com/watch?v=lTEzy5WnoYk'),
        ('moody', 'Self Care', 'https://www.youtube.com/watch?v=SsKT0s5J8ko'),
        ('moody', 'Mad About You ', 'https://youtu.be/6EA-MIYY1bg'),
        ('moody', 'You Need Me, I Dont Need You', 'https://www.youtube.com/watch?v=ZXvzzTICvJs'),
        ('moody', 'Francesca', 'https://youtu.be/UOUXV6-_DyY'),
        ('moody', 'Puke', 'https://www.youtube.com/watch?v=4GUk3V0iXyE'),
        ('moody', 'Final Warning', 'https://youtu.be/ToOFtvvFGGo'),

        -- Happy
        ('happy', 'Hey Ya!', 'https://www.youtube.com/watch?v=Jx_O6PHdWww'),
        ('happy', 'Achey Bones', 'https://www.youtube.com/watch?v=ml9nOWpLCU4'),
        ('happy', 'Still Young ', 'https://www.youtube.com/watch?v=9v7RVkPZkls'),
        ('happy', 'Levitating', 'https://youtu.be/TUVcZfQe-Kw'),
        ('happy', 'Give Me the Night', 'https://www.youtube.com/watch?v=Omnpu8mzX4c'),
        ('happy', 'Hands Up', 'https://www.youtube.com/watch?v=NR2qjvsqNSk'),
        ('happy', 'Dont Stop Til You Get Enough', 'https://youtu.be/yURRmWtbTbo'),
        ('happy', 'Super Freak', 'https://www.youtube.com/watch?v=QYHxGBH6o4M'),
        ('happy', 'Movies', 'https://www.youtube.com/watch?v=XyOCbEVGv9g'),
        ('happy', 'Keep Moving', 'https://youtu.be/7-lWzQd_xeQ'),
        ('happy', 'New Shoes', 'https://www.youtube.com/watch?v=LaecIn0iLfU'),

        -- Sad
        ('sad', 'Hey Jude', 'https://youtu.be/A_MjCqQoLLA'),
        ('sad', 'Songbird', 'https://www.youtube.com/watch?v=y9Hqn8x6a8s'),
        ('sad', 'Sara', 'https://youtu.be/Ma7BK2MJNqo'),
        ('sad', 'Falling', 'https://youtu.be/olGSAVOkkTI'),
        ('sad', 'Lie to Me', 'https://youtu.be/du7paNLQN9M'),
        ('sad', 'To Be Loved', 'https://www.youtube.com/watch?v=_dlExeOyFh4'),
        ('sad', 'Jealous', 'https://youtu.be/50VWOBi0VFs'),
        ('sad', 'Afire Love', 'https://www.youtube.com/watch?v=JznXx1Ns374'),
        ('sad', 'All Things End', 'https://youtu.be/potq6EfzFTI'),
        ('sad', 'Acid Eyes', 'https://www.youtube.com/watch?v=JoKCyeqBSbs'),
        ('sad', 'Invisible', 'https://youtu.be/NVVrT_wNw_Y')
        
) AS songs_data (mood_name, title, url)
ON moods.mood_name = songs_data.mood_name;

-- Insert movements dynamically based on mood names
INSERT INTO movements (mood_id, image_url)
SELECT moods.id, movement_data.image_url
FROM moods
JOIN (
    -- movement data for each mood
    VALUES
        ('energized', 'https://www.egreenway.com/taichichuan/images/ST12a.gif'),
        ('sleepy', 'https://www.egreenway.com/taichichuan/images/ST10b.gif'),
        ('moody', 'https://www.egreenway.com/taichichuan/images/ST21a.gif'),
        ('happy', 'https://www.egreenway.com/taichichuan/images/ST17a.gif'),
        ('sad', 'https://www.egreenway.com/taichichuan/images/ST9a.gif')
) AS movement_data (mood_name, image_url)
ON moods.mood_name = movement_data.mood_name;
