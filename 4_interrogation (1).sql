-- ==========================================================
-- DESCRIPTION : Interrogation de la base de données K-MusicDrama
-- ==========================================================

-- ==========================================================
-- SCÉNARIOS D'UTILISATION
-- ==========================================================

-- SCÉNARIO 1 — Lucas, Modérateur de la plateforme
-- Lucas est chargé de surveiller la qualité des données et
-- des interactions des utilisateurs sur K-MusicDrama.
-- Il vérifie les notes attribuées, les playlists créées,
-- les extraits publiés, et s'assure que le contenu est
-- conforme aux règles de la plateforme.

-- SCÉNARIO 2 — Lena, Fan avancée
-- Lena est une grande fan de K-Dramas. Elle navigue sur
-- la plateforme pour trouver des œuvres selon ses genres
-- préférés, découvrir de nouvelles OST, et consulter les
-- playlists publiques d'autres fans.

-- SCÉNARIO 3 — Emma, Responsable des contenus
-- Emma gère le catalogue de la plateforme. Elle vérifie
-- quelles séries ont des épisodes enregistrés, quelles
-- œuvres ont des OST associées, et identifie les contenus
-- qui manquent d'extraits vidéo pour les compléter.
-- ==========================================================


-- ==========================================================
-- SCÉNARIO 1 : Lucas — Modérateur de la plateforme
-- ==========================================================

-- Liste de tous les utilisateurs inscrits, triés par date d'inscription
-- Lucas veut voir les nouveaux inscrits en premier
SELECT pseudonyme, email, date_inscription
FROM UTILISATEUR
ORDER BY date_inscription DESC;

-- Playlists publiques existantes sur la plateforme
-- Lucas verifie les playlists visibles par tous les utilisateurs
SELECT nom_playlist, statut_playlist, id_utilisateur
FROM PLAYLIST
WHERE statut_playlist = 'publique'
ORDER BY nom_playlist;

-- Extraits publiés entre 2019 et 2021 avec leur nombre de vues
-- Lucas surveille les extraits publiés sur une période donnée
SELECT type_extrait, nombre_vues, date_publication
FROM EXTRAIT
WHERE date_publication BETWEEN '2019-01-01' AND '2021-12-31'
ORDER BY nombre_vues DESC;

-- Utilisateurs dont l'email contient "gmail"
-- Lucas cherche les comptes associés à Gmail
SELECT pseudonyme, email
FROM UTILISATEUR
WHERE email LIKE '%gmail%';

-- Notes de prestation comprises entre 4 et 5
-- Lucas vérifie les meilleures évaluations d'acteurs
SELECT id_oeuvre, id_acteur, id_utilisateur, note_prestation
FROM NOTER_PRESTATION
WHERE note_prestation BETWEEN 4 AND 5
ORDER BY note_prestation DESC;

-- Nombre de playlists par utilisateur
-- Lucas veut savoir quels utilisateurs sont les plus actifs
SELECT id_utilisateur, COUNT(*) AS nb_playlists
FROM PLAYLIST
GROUP BY id_utilisateur
ORDER BY nb_playlists DESC;

-- Nombre de notes attribuées par utilisateur
-- Lucas identifie les utilisateurs qui notent le plus
SELECT id_utilisateur, COUNT(*) AS nb_notes
FROM NOTER_PRESTATION
GROUP BY id_utilisateur
HAVING COUNT(*) >= 1
ORDER BY nb_notes DESC;

-- Moyenne des notes de prestation par acteur
-- Lucas surveille les acteurs les mieux/moins bien notés
SELECT id_acteur, ROUND(AVG(note_prestation), 2) AS moyenne_note
FROM NOTER_PRESTATION
GROUP BY id_acteur
ORDER BY moyenne_note DESC;

-- Extraits ayant plus de 200 000 vues
-- Lucas repère les contenus viraux à surveiller
SELECT id_extrait, type_extrait, nombre_vues, id_oeuvre
FROM EXTRAIT
WHERE nombre_vues > 200000
ORDER BY nombre_vues DESC;

-- Lucas vérifie les notes avec le nom de l'utilisateur et de l'acteur
-- Jointure entre NOTER_PRESTATION, UTILISATEUR et ACTEUR
SELECT U.pseudonyme, A.nom_acteur, NP.note_prestation
FROM NOTER_PRESTATION NP
JOIN UTILISATEUR U ON NP.id_utilisateur = U.id_utilisateur
JOIN ACTEUR A ON NP.id_acteur = A.id_acteur
ORDER BY NP.note_prestation DESC;

-- Liste des playlists avec le pseudonyme du propriétaire
-- Lucas associe chaque playlist à son créateur
SELECT P.nom_playlist, P.statut_playlist, U.pseudonyme
FROM PLAYLIST P
JOIN UTILISATEUR U ON P.id_utilisateur = U.id_utilisateur
ORDER BY U.pseudonyme;

-- Utilisateurs qui n'ont créé aucune playlist
-- Lucas repère les comptes inactifs
SELECT pseudonyme, email
FROM UTILISATEUR
WHERE id_utilisateur NOT IN (
    SELECT DISTINCT id_utilisateur FROM PLAYLIST
);

-- Acteurs qui n'ont reçu aucune note de prestation
-- Lucas identifie les acteurs sans évaluation sur la plateforme
SELECT nom_acteur
FROM ACTEUR
WHERE id_acteur NOT IN (
    SELECT DISTINCT id_acteur FROM NOTER_PRESTATION
);


-- ==========================================================
-- SCÉNARIO 2 : Lena — Fan avancée
-- ==========================================================

-- Lena cherche toutes les séries disponibles sur la plateforme
-- Projection et sélection sur le type d'oeuvre
SELECT titre_oeuvre, date_sortie, duree_totale
FROM OEUVRE
WHERE type_oeuvre = 'serie'
ORDER BY date_sortie DESC;

-- Lena cherche des œuvres classées dans le genre Romance ou Fantastique
-- Elle utilise IN pour filtrer par genres favoris
SELECT DISTINCT O.titre_oeuvre, O.type_oeuvre
FROM OEUVRE O
JOIN CLASSER C ON O.id_oeuvre = C.id_oeuvre
JOIN GENRE G ON C.id_genre = G.id_genre
WHERE G.nom_genre IN ('Romance', 'Fantastique')
ORDER BY O.titre_oeuvre;

-- Lena veut voir les OST disponibles avec leur série/film associé
-- Jointure entre MUSIQUE et OEUVRE
SELECT M.titre_musique, M.artiste, O.titre_oeuvre
FROM MUSIQUE M
JOIN OEUVRE O ON M.id_oeuvre = O.id_oeuvre
ORDER BY O.titre_oeuvre, M.titre_musique;

-- Lena consulte les playlists publiques avec les musiques qu'elles contiennent
-- Jointure multiple entre PLAYLIST, AJOUTER et MUSIQUE
SELECT P.nom_playlist, M.titre_musique, M.artiste
FROM PLAYLIST P
JOIN AJOUTER A ON P.id_playlist = A.id_playlist
JOIN MUSIQUE M ON A.id_musique = M.id_musique
WHERE P.statut_playlist = 'publique'
ORDER BY P.nom_playlist;

-- Lena veut voir les acteurs qui jouent dans des œuvres de genre Thriller
-- Requête imbriquée avec IN
SELECT DISTINCT A.nom_acteur
FROM ACTEUR A
WHERE A.id_acteur IN (
    SELECT J.id_acteur
    FROM JOUER J
    WHERE J.id_oeuvre IN (
        SELECT C.id_oeuvre
        FROM CLASSER C
        JOIN GENRE G ON C.id_genre = G.id_genre
        WHERE G.nom_genre = 'Thriller'
    )
);

-- Lena cherche les extraits tendance (Trailer ou Teaser) avec le plus de vues
SELECT type_extrait, nombre_vues, O.titre_oeuvre
FROM EXTRAIT E
JOIN OEUVRE O ON E.id_oeuvre = O.id_oeuvre
WHERE type_extrait LIKE '%Trailer%' OR type_extrait LIKE '%Teaser%'
ORDER BY nombre_vues DESC;

-- Lena veut voir les épisodes disponibles pour Goblin
-- Jointure entre EPISODE et OEUVRE avec sélection par titre
SELECT E.numero_episode, E.titre_episode, E.duree_episode
FROM EPISODE E
JOIN OEUVRE O ON E.id_oeuvre = O.id_oeuvre
WHERE O.titre_oeuvre = 'Goblin'
ORDER BY E.numero_episode;

-- Lena vérifie si une musique qu'elle aime est dans au moins une playlist publique
-- Requête avec EXISTS
SELECT M.titre_musique, M.artiste
FROM MUSIQUE M
WHERE EXISTS (
    SELECT 1
    FROM AJOUTER A
    JOIN PLAYLIST P ON A.id_playlist = P.id_playlist
    WHERE A.id_musique = M.id_musique
    AND P.statut_playlist = 'publique'
);


-- ==========================================================
-- SCÉNARIO 3 : Emma — Responsable des contenus
-- ==========================================================

-- Emma liste toutes les œuvres avec le nombre de genres associés
-- Elle vérifie la couverture éditoriale du catalogue
SELECT O.titre_oeuvre, COUNT(C.id_genre) AS nb_genres
FROM OEUVRE O
LEFT JOIN CLASSER C ON O.id_oeuvre = C.id_oeuvre
GROUP BY O.titre_oeuvre
ORDER BY nb_genres DESC;

-- Emma cherche les séries qui ont au moins 2 épisodes enregistrés
-- Elle contrôle la complétude des données
SELECT O.titre_oeuvre, COUNT(E.id_episode) AS nb_episodes
FROM OEUVRE O
JOIN EPISODE E ON O.id_oeuvre = E.id_oeuvre
GROUP BY O.titre_oeuvre
HAVING COUNT(E.id_episode) >= 2
ORDER BY nb_episodes DESC;

-- Emma identifie les œuvres sans aucune musique associée
-- Elle repère les contenus à compléter côté OST
SELECT titre_oeuvre, type_oeuvre
FROM OEUVRE
WHERE id_oeuvre NOT IN (
    SELECT DISTINCT id_oeuvre FROM MUSIQUE
);

-- Emma identifie les œuvres sans aucun extrait vidéo
-- Elle repère les contenus à compléter côté extraits
SELECT titre_oeuvre, type_oeuvre
FROM OEUVRE
WHERE id_oeuvre NOT IN (
    SELECT DISTINCT id_oeuvre FROM EXTRAIT
);

-- Emma veut le nombre de musiques par œuvre, uniquement pour celles qui en ont au moins 2
SELECT O.titre_oeuvre, COUNT(M.id_musique) AS nb_musiques
FROM OEUVRE O
JOIN MUSIQUE M ON O.id_oeuvre = M.id_oeuvre
GROUP BY O.titre_oeuvre
HAVING COUNT(M.id_musique) >= 2
ORDER BY nb_musiques DESC;

-- Emma veut les œuvres avec leur nombre d'acteurs, même celles sans acteur (LEFT JOIN)
SELECT O.titre_oeuvre, COUNT(J.id_acteur) AS nb_acteurs
FROM OEUVRE O
LEFT JOIN JOUER J ON O.id_oeuvre = J.id_oeuvre
GROUP BY O.titre_oeuvre
ORDER BY nb_acteurs DESC;

-- Emma cherche les œuvres dont tous les acteurs ont reçu une note
-- Requête avec NOT EXISTS pour trouver les œuvres sans acteur non noté
SELECT DISTINCT O.titre_oeuvre
FROM OEUVRE O
WHERE NOT EXISTS (
    SELECT 1
    FROM JOUER J
    WHERE J.id_oeuvre = O.id_oeuvre
    AND NOT EXISTS (
        SELECT 1
        FROM NOTER_PRESTATION NP
        WHERE NP.id_oeuvre = J.id_oeuvre
        AND NP.id_acteur = J.id_acteur
    )
);

-- Emma compare la durée totale des films vs des séries
-- Agrégation par type d'oeuvre
SELECT type_oeuvre,
       COUNT(*) AS nb_oeuvres,
       AVG(duree_totale) AS duree_moyenne,
       MAX(duree_totale) AS duree_max,
       MIN(duree_totale) AS duree_min
FROM OEUVRE
GROUP BY type_oeuvre;

-- Emma vérifie les acteurs qui jouent dans plus d'une œuvre
-- Elle identifie les acteurs récurrents du catalogue
SELECT A.nom_acteur, COUNT(J.id_oeuvre) AS nb_oeuvres
FROM ACTEUR A
JOIN JOUER J ON A.id_acteur = J.id_acteur
GROUP BY A.nom_acteur
HAVING COUNT(J.id_oeuvre) > 1
ORDER BY nb_oeuvres DESC;
