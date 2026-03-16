-- ==========================================================
-- FICHIER : 3_insertion.sql
-- DESCRIPTION : Insertions de données réalistes (K-Dramas)
-- ==========================================================

-- 1. Table GENRE (Contrainte : Romance, Action, Thriller, Comédie, Historique, Fantastique)
INSERT INTO GENRE (id_genre, nom_genre) VALUES
(1, 'Romance'), (2, 'Action'), (3, 'Thriller'), 
(4, 'Comédie'), (5, 'Historique'), (6, 'Fantastique');

-- 2. Table UTILISATEUR (Contrainte : Email valide)
INSERT INTO UTILISATEUR (id_utilisateur, pseudonyme, email, mot_de_passe, date_inscription) VALUES
(1, 'KimChi Lover', 'kim@gmail.com', 'hash_123', '2025-01-10'),
(2, 'DramaQueen', 'sarah@yahoo.fr', 'hash_456', '2025-01-12'),
(3, 'OppaCollector', 'lucie@outlook.com', 'hash_789', '2025-01-15'),
(4, 'K-Fan99', 'test@gmail.com', 'pwd_101', '2025-02-01'),
(5, 'SeoulVibes', 'vibe@korea.kr', 'pwd_202', '2025-02-05'),
(6, 'HallyuWave', 'wave@gmail.com', 'pwd_303', '2025-02-10'),
(7, 'BingeWatcher', 'binge@mail.com', 'pwd_404', '2025-02-15'),
(8, 'K-Sound', 'music@naver.com', 'pwd_505', '2025-02-20'),
(9, 'NoonaFan', 'noona@gmail.com', 'pwd_606', '2025-02-25'),
(10, 'DramaKing', 'king@gmail.com', 'pwd_707', '2025-03-01');

-- 3. Table ACTEUR
INSERT INTO ACTEUR (id_acteur, nom_acteur, date_naissance, biographie) VALUES
(1, 'Gong Yoo', '1979-07-10', 'Acteur emblématique connu pour Goblin et Train to Busan.'),
(2, 'Kim Go-eun', '1991-07-02', 'Actrice talentueuse révélée dans Muse et Goblin.'),
(3, 'Lee Min-ho', '1987-06-22', 'Star internationale (Boys Over Flowers, The King).'),
(4, 'Park Shin-hye', '1990-02-18', 'Reine des comédies romantiques.'),
(5, 'Son Ye-jin', '1982-01-11', 'Actrice de Crash Landing on You.'),
(6, 'Hyun Bin', '1982-09-25', 'Acteur célèbre pour son rôle dans Secret Garden.'),
(7, 'Park Seo-joon', '1988-12-16', 'Star de Itaewon Class et What is wrong with Secretary Kim.'),
(8, 'IU (Lee Ji-eun)', '1993-05-16', 'Chanteuse et actrice (Hotel Del Luna).'),
(9, 'Song Joong-ki', '1985-09-19', 'Acteur principal de Vincenzo.'),
(10, 'Bae Suzy', '1994-10-10', 'Ancienne idole et actrice (Start-Up).');

-- 4. Table OEUVRE (Contraintes : type 'film'/'serie', duree > 0)
INSERT INTO OEUVRE (id_oeuvre, titre_oeuvre, type_oeuvre, date_sortie, resume, duree_totale, id_oeuvre_Oeuvre_originale) VALUES 
(1, 'Goblin', 'serie', '2016-12-02', 'Un être immortel cherche sa fiancée pour mettre fin à sa vie.', 1200, NULL), 
(2, 'Crash Landing on You', 'serie', '2019-12-14', 'Une héritière sud-coréenne atterrit par accident en Corée du Nord.', 1300, NULL), 
(3, 'Train to Busan', 'film', '2016-07-20', 'Une épidémie de zombies éclate dans un train vers Busan.', 118, NULL), 
(4, 'Vincenzo', 'serie', '2021-02-20', 'Un avocat de la mafia italienne revient en Corée.', 1600, NULL), 
(5, 'Hotel Del Luna', 'serie', '2019-07-13', 'Un hôtel qui accueille uniquement des fantômes.', 1100, NULL), 
(6, 'Parasite', 'film', '2019-05-30', 'Une famille pauvre s’immisce dans la vie d’une famille riche.', 132, NULL), 
(7, 'The King: Eternal Monarch', 'serie', '2020-04-17', 'Un empereur traverse un portail vers un monde parallèle.', 1150, NULL), 
(8, 'Start-Up', 'serie', '2020-10-17', 'Des jeunes entrepreneurs dans la Silicon Valley coréenne.', 1000, NULL), 
(9, 'Squid Game', 'serie', '2021-09-17', 'Des gens endettés jouent à des jeux mortels.', 480, NULL), 
(10, 'Oldboy', 'film', '2003-11-21', 'Un homme est séquestré pendant 15 ans sans raison.', 120, NULL);


-- 5. Table EPISODE (Seulement pour les séries)
INSERT INTO EPISODE (id_oeuvre, id_episode, numero_episode, titre_episode, duree_episode) VALUES
(1, 1, 1, 'La rencontre du destin', 75),
(1, 2, 2, 'La mariée du gobelin', 75),
(2, 3, 1, 'Atterrissage forcé', 85),
(4, 4, 1, 'Le retour de l’italien', 80),
(5, 5, 1, 'Bienvenue à l’hôtel', 70),
(7, 6, 1, 'Deux mondes', 70),
(8, 7, 1, 'Le rêve commence', 65),
(9, 8, 1, 'Un, deux, trois, soleil', 60),
(1, 9, 3, 'Le secret du passé', 75),
(2, 10, 2, 'Cachée chez l’officier', 85);

-- 6. Table MUSIQUE
INSERT INTO MUSIQUE (id_musique, titre_musique, artiste, duree_musique, id_oeuvre) VALUES
(1, 'Stay With Me', 'Chanyeol & Punch', 193, 1),
(2, 'Beautiful', 'Crush', 228, 1),
(3, 'Sunset', 'Davichi', 215, 2),
(4, 'Give You My Heart', 'IU', 221, 2),
(5, 'Adrenaline', 'Solar', 207, 4),
(6, 'Another Day', 'Monday Kiz', 218, 5),
(7, 'Future', 'Red Velvet', 190, 8),
(8, 'Way to Busan', 'Score', 300, 3),
(9, 'Pink Soldiers', '23', 150, 9),
(10, 'Orbit', 'Hwasa', 185, 7);

-- 7. Table PLAYLIST (Contrainte : 'privée' / 'publique')
INSERT INTO PLAYLIST (id_playlist, nom_playlist, statut_playlist, id_utilisateur) VALUES
(1, 'Best OST 2024', 'publique', 1),
(2, 'Tristes K-Dramas', 'privée', 1),
(3, 'Action Vibes', 'publique', 2),
(4, 'Romance Night', 'publique', 3),
(5, 'My Favorites', 'privée', 4),
(6, 'Work Out Kpop', 'publique', 5),
(7, 'Study Piano', 'privée', 6),
(8, 'Squid Game Style', 'publique', 7),
(9, 'IU Best Songs', 'publique', 8),
(10, 'Chill Drama', 'privée', 9);

-- 8. Table EXTRAIT (Contrainte : vues >= 0)
INSERT INTO EXTRAIT (id_extrait, type_extrait, nombre_vues, date_publication, id_oeuvre) VALUES
(1, 'Trailer', 500000, '2016-11-01', 1),
(2, 'Teaser 1', 250000, '2019-11-15', 2),
(3, 'Making-of', 120000, '2016-08-01', 3),
(4, 'Interview', 85000, '2021-02-25', 4),
(5, 'Scène Culte', 1000000, '2019-08-20', 5),
(6, 'Trailer 2', 450000, '2019-05-10', 6),
(7, 'Teaser', 300000, '2020-03-30', 7),
(8, 'Behind scenes', 95000, '2020-11-01', 8),
(9, 'Teaser Final', 2000000, '2021-09-01', 9),
(10, 'Promo', 60000, '2003-10-15', 10);

-- 9. Table JOUER
INSERT INTO JOUER (id_oeuvre, id_acteur, nom_role) VALUES
(1, 1, 'Kim Shin'),
(1, 2, 'Ji Eun-tak'),
(2, 5, 'Yoon Se-ri'),
(2, 6, 'Ri Jeong-hyeok'),
(3, 1, 'Seok-woo'),
(4, 9, 'Vincenzo Cassano'),
(5, 8, 'Jang Man-wol'),
(7, 3, 'Lee Gon'),
(8, 10, 'Seo Dal-mi'),
(8, 7, 'Han Ji-pyeong (cameo/ref)');

-- 10. Table AJOUTER
INSERT INTO AJOUTER (id_musique, id_playlist) VALUES
(1, 1), (2, 1), (3, 1), (4, 4), (5, 3), 
(6, 2), (7, 6), (9, 8), (1, 10), (10, 5);

-- 11. Table CLASSER
INSERT INTO CLASSER (id_oeuvre, id_genre) VALUES
(1, 1), (1, 6), (2, 1), (2, 4), (3, 2), 
(3, 3), (4, 3), (5, 6), (6, 3), (9, 3);

-- 12. Table NOTER_PRESTATION (Contrainte : note entre 1 et 5)
INSERT INTO NOTER_PRESTATION (id_oeuvre, id_acteur, id_utilisateur, note_prestation) VALUES
(1, 1, 1, 5),
(1, 2, 1, 4),
(2, 5, 2, 5),
(2, 6, 2, 5),
(3, 1, 3, 5),
(4, 9, 4, 4),
(5, 8, 5, 5),
(7, 3, 6, 3),
(8, 10, 7, 4),
(9, 9, 8, 5); -- Note fictive pour l'exemple

-- Insertion de boys over flower pour illustrer le remake 
INSERT INTO OEUVRE (id_oeuvre, titre_oeuvre, type_oeuvre, date_sortie, resume, duree_totale, id_oeuvre_Oeuvre_originale) 
VALUES (11, 'Hana Yori Dango', 'serie', '2005-10-21', 'La version originale japonaise du célèbre manga.', 550, NULL);
INSERT INTO OEUVRE (id_oeuvre, titre_oeuvre, type_oeuvre, date_sortie, resume, duree_totale, id_oeuvre_Oeuvre_originale)  
VALUES (12, 'Boys Over Flowers', 'serie', '2009-01-05', 'Une jeune fille pauvre intègre un lycée d’élite dominé par le F4.', 1500, 11);
INSERT INTO CLASSER (id_oeuvre, id_genre) VALUES (12, 1);
INSERT INTO JOUER (id_oeuvre, id_acteur, nom_role) VALUES (12, 3, 'Gu Jun-pyo');
