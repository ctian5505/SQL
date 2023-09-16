--Project Phases and Tasks:
  --Phase 1: Database Design (DDL)
   --Task 1: Define the Database Schema | Description: Create the database schema for the library management system, defining 
	-- Create Database 
CREATE DATABASE Library
	-- Create Table Book
CREATE TABLE Books(
BookID INT NOT NULL PRIMARY KEY,
Title NVARCHAR(150) NOT NULL,
Author NVARCHAR(100),
Language NVARCHAR(50),
DatePublished DATE,
GenreID INT)

	-- Create Table Genre
CREATE TABLE Genre(
GenreID INT PRIMARY KEY,
Genre NVARCHAR(150))


   --Task 2: Specify Keys and Constraints | Description: Define primary keys, foreign keys, constraints, and relationships between tables.
	-- Defining Primary Key for books table
ALTER TABLE Books
ADD CONSTRAINT PK_Books PRIMARY KEY(BookID)

	-- Defining Primary Key for books table
ALTER TABLE Books
ADD CONSTRAINT FK_Books_Genre FOREIGN KEY(GenreID)
REFERENCES Genre(GenreID)



-- Phase 2: Data Population (DML)
	-- Task 3: Populate the Database with Sample Data | Description: Insert sample data into the database, including books, user information, and transactions.
	-- Defining Primary Key for books table
	--INSERTING sample book records
INSERT INTO Books(BookID, Title, Author, Language, DatePublished, GenreID)
VALUES	
(1, 'A Tale of Two Cities','Charles Dickens','English','1859',28),
(2, 'The Little Prince (Le Petit Prince)','Antoine de Saint-Exupéry','French','1943',41),
(3, 'Harry Potter and the Philosopher''s Stone','J. K. Rowling','English','1997',23),
(4, 'And Then There Were None','Agatha Christie','English','1939',36),
(5, 'Dream of the Red Chamber (紅樓夢)','Cao Xueqin','Chinese','1791',22),
(6, 'The Hobbit','J. R. R. Tolkien','English','1937',23),
(7, 'The Lion, the Witch and the Wardrobe','C. S. Lewis','English','1950',23),
(8, 'She: A History of Adventure','H. Rider Haggard','English','1887',1),
(9, 'Vardi Wala Gunda (वर्दी वाला गुंडा)','Ved Prakash Sharma','Hindi','1992',17),
(10, 'The Da Vinci Code','Dan Brown','English','2003',37),
(11, 'Harry Potter and the Chamber of Secrets','J. K. Rowling','English','1998',23),
(12, 'Harry Potter and the Prisoner of Azkaban','J. K. Rowling','English','1999',23),
(13, 'Harry Potter and the Goblet of Fire','J. K. Rowling','English','2000',23),
(14, 'Harry Potter and the Order of the Phoenix','J. K. Rowling','English','2003',23),
(15, 'Harry Potter and the Half-Blood Prince','J. K. Rowling','English','2005',23),
(16, 'Harry Potter and the Deathly Hallows','J. K. Rowling','English','2007',23),
(17, 'The Alchemist (O Alquimista)','Paulo Coelho','Portuguese','1988',23),
(18, 'The Catcher in the Rye','J. D. Salinger','English','1951',13),
(19, 'The Bridges of Madison County','Robert James Waller','English','1992',46),
(20, 'Ben-Hur: A Tale of the Christ','Lew Wallace','English','1880',28),
(21, 'You Can Heal Your Life','Louise Hay','English','1984',53),
(22, 'One Hundred Years of Solitude (Cien años de soledad)','Gabriel García Márquez','Spanish','1967',33),
(23, 'Lolita','Vladimir Nabokov','English','1955',40),
(24, 'Heidi','Johanna Spyri','German','1880',7),
(25, 'The Common Sense Book of Baby and Child Care','Benjamin Spock','English','1946',34),
(26, 'Anne of Green Gables','Lucy Maud Montgomery','English','1908',9),
(27, 'Black Beauty','Anna Sewell','English','1877',8),
(28, 'The Name of the Rose (Il Nome della Rosa)','Umberto Eco','Italian','1980',30),
(29, 'The Eagle Has Landed','Jack Higgins','English','1975',63),
(30, 'Watership Down','Richard Adams','English','1972',23),
(31, 'The Hite Report','Shere Hite','English','1976',55),
(32, 'Charlotte''s Web','E. B. White; illustrated by Garth Williams','English','1952',7),
(33, 'The Ginger Man','J. P. Donleavy','English','1955',40),
(34, 'The Tale of Peter Rabbit','Beatrix Potter','English','1902',8),
(35, 'Jonathan Livingston Seagull','Richard Bach','English','1970',41),
(36, 'The Very Hungry Caterpillar','Eric Carle','English','1969',8),
(37, 'A Message to Garcia','Elbert Hubbard','English','1899',21),
(38, 'To Kill a Mockingbird','Harper Lee','English','1960',58),
(39, 'Flowers in the Attic','V. C. Andrews','English','1979',26),
(40, 'Cosmos','Carl Sagan','English','1980',44),
(41, 'Sophie''s World (Sofies verden)','Jostein Gaarder','Norwegian','1991',42),
(42, 'Angels & Demons','Dan Brown','English','2000',37),
(43, 'Kane and Abel','Jeffrey Archer','English','1979',40),
(44, 'How the Steel Was Tempered (Как закалялась сталь)','Nikolai Ostrovsky','Russian','1932',57),
(45, 'War and Peace (Война и мир)','Leo Tolstoy','Russian','1869',30),
(46, 'The Adventures of Pinocchio (Le avventure di Pinocchio)','Carlo Collodi','Italian','1881',23),
(47, 'The Diary of Anne Frank (Het Achterhuis)','Anne Frank','Dutch','1947',29),
(48, 'Your Erroneous Zones','Wayne Dyer','English','1976',53),
(49, 'The Thorn Birds','Colleen McCullough','English','1977',48),
(50, 'The Purpose Driven Life','Rick Warren','English','2002',11),
(51, 'The Kite Runner','Khaled Hosseini','English','2003',4),
(52, 'Valley of the Dolls','Jacqueline Susann','English','1966',40),
(53, 'Alcoholics Anonymous Big Book','Bill Wilson','English','1939',53),
(54, 'How to Win Friends and Influence People','Dale Carnegie','English','1936',53),
(55, 'The Great Gatsby','F. Scott Fitzgerald','English','1925',40),
(56, 'Gone with the Wind','Margaret Mitchell','English','1936',28),
(57, 'Rebecca','Daphne du Maurier','English','1938',27),
(58, 'Nineteen Eighty-Four','George Orwell','English','1949',19),
(59, 'The Revolt of Mamie Stover','William Bradford Huie','English','1951',25),
(60, 'The Girl with the Dragon Tattoo (Män som hatar kvinnor)','Stieg Larsson','Swedish','2005',25),
(61, 'The Lost Symbol','Dan Brown','English','2009',25),
(62, 'The Hunger Games','Suzanne Collins','English','2008',64),
(63, 'James and the Giant Peach','Roald Dahl','English','1961',9),
(64, 'The Young Guard (Молодая гвардия)','Alexander Alexandrovich Fadeyev','Russian','1945',65),
(65, 'Who Moved My Cheese?','Spencer Johnson','English','1998',53),
(66, 'A Brief History of Time','Stephen Hawking','English','1988',44),
(67, 'Paul et Virginie','Jacques-Henri Bernardin de Saint-Pierre','French','1788',40),
(68, 'Lust for Life','Irving Stone','English','1934',5),
(69, 'The Wind in the Willows','Kenneth Grahame','English','1908',8),
(70, 'The 7 Habits of Highly Effective People','Stephen R. Covey','English','1989',53),
(71, 'Virgin Soil Upturned (Поднятая целина)','Mikhail Sholokhov','Russian','1935',40),
(72, 'The Celestine Prophecy','James Redfield','English','1993',39),
(73, 'The Fault in Our Stars','John Green','English','2012',67),
(74, 'The Girl on the Train','Paula Hawkins','English','2015',59),
(75, 'The Shack','William P. Young','English','2007',40),
(76, 'Uncle Styopa (Дядя Стёпа)','Sergey Mikhalkov','Russian','1936',8),
(77, 'The Godfather','Mario Puzo','English','1969',15),
(78, 'Love Story','Erich Segal','English','1970',47),
(79, 'Catching Fire','Suzanne Collins','English','2009',66),
(80, 'Mockingjay','Suzanne Collins','English','2010',66),
(81, 'Kitchen (キッチン)','Banana Yoshimoto','Japanese','1988',32),
(82, 'Andromeda Nebula (Туманность Андромеды)','Ivan Yefremov','Russian','1957',52),
(83, 'Autobiography of a Yogi (योगी कथामृत)','Paramahansa Yogananda','Hindi','1946',3),
(84, 'Gone Girl','Gillian Flynn','English','2012',16),
(85, 'All Quiet on the Western Front (Im Westen nichts Neues)','Erich Maria Remarque','German','1929',62),
(87, 'Things Fall Apart ','Chinua Achebe','English','1958',40),
(88, 'Animal Farm ','George Orwell','English','1945',50),
(89, 'Wolf Totem (狼图腾)','Jiang Rong','Chinese','2004',54),
(90, 'The Happy Hooker: My Own Story','Xaviera Hollander','English','1971',35),
(91, 'Jaws','Peter Benchley','English','1974',59),
(92, 'Love You Forever','Robert Munsch','English','1986',8),
(93, 'The Women''s Room','Marilyn French','English','1977',24),
(94, 'What to Expect When You''re Expecting','Arlene Eisenberg and Heidi Murkoff','English','1984',45),
(95, 'Adventures of Huckleberry Finn','Mark Twain','English','1885',43),
(96, 'The Secret Diary of Adrian Mole, Aged 13¾','Sue Townsend','English','1982',66),
(97, 'Pride and Prejudice','Jane Austen','English','1813',12),
(98, 'Kon-Tiki: Across the Pacific in a Raft (Kon-Tiki ekspedisjonen)','Thor Heyerdahl','Norwegian','1950',60),
(99, 'The Good Soldier Švejk (Osudy dobrého vojáka Švejka za světové války)','Jaroslav Hašek','Czech','1923',61),
(100, 'Where the Wild Things Are','Maurice Sendak','English','1963',10),
(101, 'The Power of Positive Thinking','Norman Vincent Peale','English','1952',53),
(102, 'The Secret','Rhonda Byrne','English','2006',53),
(103, 'Fear of Flying','Erica Jong','English','1973',49),
(104, 'Dune','Frank Herbert','English','1965',52),
(105, 'Charlie and the Chocolate Factory','Roald Dahl','English','1964',6),
(106, 'The Naked Ape','Desmond Morris','English','1968',56),
(107, 'Where the Crawdads Sing','Delia Owens','English','2018',14),
(108, 'Totto-chan, the Little Girl at the Window (窓ぎわのトットちゃん)','Tetsuko Kuroyanagi','Japanese','1981',2),
(109, 'Matilda','Roald Dahl','English','1988',8),
(110, 'The Book Thief','Markus Zusak','English','2005',64),
(112, 'Goodnight Moon','Margaret Wise Brown','English','1947',8),
(113, 'The Neverending Story (Die unendliche Geschichte)','Michael Ende','German','1979',8),
(114, 'All the Light We Cannot See','Anthony Doerr','English','2014',28),
(115, 'Fifty Shades of Grey','E. L. James','English','2011',20),
(120, 'The Pillars of the Earth','Ken Follett','English','1989',28),
(126, 'The Hitchhiker''s Guide to the Galaxy','Douglas Adams','English','1979',51),
(135, 'The Giver','Lois Lowry','English','1993',18),
(144, 'The Exorcist','William Peter Blatty','English','1971',31),
(146, 'Fifty Shades Darker','E. L. James','English','2012',20)

-- INSERTING sample Genre records
INSERT INTO Genre(GenreID, Genre)
VALUES
(2, 'Autobiographical novel'),
(3, 'Autobiography'),
(4, 'Bildungsroman'),
(5, 'Biographical novel'),
(6, 'Children''s fantasy novel'),
(7, 'Children''s fiction'),
(8, 'Children''s literature'),
(9, 'Children''s novel'),
(10, 'Children''s picture book'),
(11, 'Christian literature'),
(12, 'Classic regency novel'),
(13, 'Coming-of-age'),
(14, 'Coming-of-age Murder mystery'),
(15, 'Crime novel'),
(16, 'Crime thriller novel'),
(17, 'Detective'),
(18, 'Dystopian fiction'),
(19, 'Dystopian'),
(20, 'Erotica'),
(21, 'Essay/Literature'),
(22, 'Family saga'),
(23, 'Fantasy'),
(24, 'Feminist novel'),
(25, 'Fiction'),
(26, 'Gothic horror'),
(27, 'Gothic novel'),
(28, 'Historical fiction'),
(29, 'Historical non-fiction'),
(30, 'Historical novel'),
(31, 'Horror'),
(32, 'Japanese novel'),
(33, 'Magic realism'),
(34, 'Manual'),
(35, 'Memoir'),
(36, 'Mystery'),
(37, 'Mystery thriller'),
(38, 'Mystery thriller'),
(39, 'New-age spiritual novel'),
(40, 'Novel'),
(41, 'Novella'),
(42, 'Philosophical novel'),
(43, 'Picaresque novel'),
(44, 'Popular science'),
(45, 'Pregnancy guide'),
(46, 'Romance'),
(47, 'Romance novel'),
(48, 'Romantic family saga'),
(49, 'Romantic novel'),
(50, 'Satirical allegorical novella'),
(51, 'Science fiction'),
(52, 'Science fiction novel'),
(53, 'Self-help'),
(54, 'Semi-autobiographical novel'),
(55, 'Sexology'),
(56, 'Social Science'),
(57, 'Socialist realist novel'),
(58, 'Southern Gothic'),
(59, 'Thriller'),
(60, 'Travel literature'),
(61, 'Unfinished satirical dark comedy novel'),
(62, 'War novel'),
(63, 'War'),
(64, 'Young adult fiction'),
(65, 'Young adult historical novel'),
(66, 'Young adult novel'),
(67, 'Young adult romantic novel')



	-- Task 4: Implement Data Modification | Description: Create SQL scripts for updating, deleting, and modifying data as needed.
UPDATE Books
SET Title = 'Dream of the Red Chamber'
WHERE BookID = 5

UPDATE Books
SET Title = 'Vardi Wala Gunda'
WHERE BookID = 9

UPDATE Books
SET Title = 'How the Steel Was Tempered'
WHERE BookID = 44

UPDATE Books
SET Title = 'War and Peace'
WHERE BookID = 45

UPDATE Books
SET Title = 'The Young Guard'
WHERE BookID = 64

UPDATE Books
SET Title = 'Virgin Soil Upturned'
WHERE BookID = 71

UPDATE Books
SET Title = 'Uncle Styopa'
WHERE BookID = 76

UPDATE Books
SET Title = 'Kitchen'
WHERE BookID = 81

UPDATE Books
SET Title = 'Andromeda Nebula'
WHERE BookID = 82


UPDATE Books
SET Title = 'Autobiography of a Yogi'
WHERE BookID = 83

UPDATE Books
SET Title = 'Wolf Totem'
WHERE BookID = 89


UPDATE Books
SET Title = 'Totto-chan, the Little Girl at the Window'
WHERE BookID = 108




