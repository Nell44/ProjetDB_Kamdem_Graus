CREATE TABLE OEUVRE(
   id_oeuvre INT,
   titre_oeuvre VARCHAR(150),
   type_oeuvre VARCHAR(10),
   date_sortie DATE,
   resume VARCHAR(2000),
   duree_totale INT,
   id_oeuvre_Oeuvre_originale INT,
   PRIMARY KEY(id_oeuvre),
   FOREIGN KEY(id_oeuvre_Oeuvre_originale) REFERENCES OEUVRE(id_oeuvre)
);
 
CREATE TABLE EPISODE(
   id_oeuvre INT,
   id_episode INT, 
   numero_episode INT,
   titre_episode VARCHAR(150),
   duree_episode INT,
   PRIMARY KEY(id_oeuvre, id_episode),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre) ON DELETE CASCADE
);
 
CREATE TABLE ACTEUR(
   id_acteur INT,
   nom_acteur VARCHAR(100),
   date_naissance DATE,
   biographie VARCHAR(3000),
   PRIMARY KEY(id_acteur)
);
 
CREATE TABLE MUSIQUE(
   id_musique INT,
   titre_musique VARCHAR(150),
   artiste VARCHAR(100),
   duree_musique INT,
   id_oeuvre INT NOT NULL,
   PRIMARY KEY(id_musique),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre) ON DELETE CASCADE
);
 
CREATE TABLE UTILISATEUR(
   id_utilisateur INT,
   pseudonyme VARCHAR(50),
   email VARCHAR(150),
   mot_de_passe VARCHAR(255),
   date_inscription DATE,
   PRIMARY KEY(id_utilisateur)
);
 
CREATE TABLE PLAYLIST(
   id_playlist INT,
   nom_playlist VARCHAR(100),
   statut_playlist VARCHAR(10),
   id_utilisateur INT,
   PRIMARY KEY(id_playlist),
   FOREIGN KEY(id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE SET NULL
);
 
CREATE TABLE EXTRAIT(
   id_extrait INT,
   type_extrait VARCHAR(20),
   nombre_vues INT,
   date_publication DATE,
   id_oeuvre INT NOT NULL,
   PRIMARY KEY(id_extrait),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre) ON DELETE CASCADE
);
 
CREATE TABLE GENRE(
   id_genre INT,
   nom_genre VARCHAR(50),
   PRIMARY KEY(id_genre)
);
 
CREATE TABLE JOUER(
   id_oeuvre INT,
   id_acteur INT,
   nom_role VARCHAR(150),
   PRIMARY KEY(id_oeuvre, id_acteur),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre)ON DELETE CASCADE,
   FOREIGN KEY(id_acteur) REFERENCES ACTEUR(id_acteur)ON DELETE CASCADE
);
 
CREATE TABLE AJOUTER(
   id_musique INT,
   id_playlist INT,
   PRIMARY KEY(id_musique, id_playlist),
   FOREIGN KEY(id_musique) REFERENCES MUSIQUE(id_musique)ON DELETE CASCADE,
   FOREIGN KEY(id_playlist) REFERENCES PLAYLIST(id_playlist)ON DELETE CASCADE
);
 
CREATE TABLE CLASSER(
   id_oeuvre INT,
   id_genre INT,
   PRIMARY KEY(id_oeuvre, id_genre),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre)ON DELETE CASCADE,
   FOREIGN KEY(id_genre) REFERENCES GENRE(id_genre)ON DELETE CASCADE
);
 
CREATE TABLE NOTER_PRESTATION(
   id_oeuvre INT,
   id_acteur INT,
   id_utilisateur INT,
   note_prestation INT,
   PRIMARY KEY(id_oeuvre, id_acteur, id_utilisateur),
   FOREIGN KEY(id_oeuvre) REFERENCES OEUVRE(id_oeuvre) ON DELETE CASCADE,
   FOREIGN KEY(id_acteur) REFERENCES ACTEUR(id_acteur) ON DELETE CASCADE,
   FOREIGN KEY(id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE
);