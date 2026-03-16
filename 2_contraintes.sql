alter table OEUVRE ADD CONSTRAINT chk_type_oeuvre 
check(type_oeuvre in ('film', 'serie'));

-- Dans MySQL, check ne sait pas gérer des fonctions dynamiques sans trigger
/* alter table OEUVRE ADD constraint chk_date_sortie
check (date_sortie <= current_date);
*/

ALTER TABLE OEUVRE ADD CONSTRAINT chk_duree_totale
check (duree_totale > 0);

alter table UTILISATEUR ADD CONSTRAINT chk_email
check (email like '%@%.%');

alter table playlist add constraint chk_statut
check (statut_playlist in ('privée', 'publique'));

alter table noter_prestation add constraint chk_note_prestation
check (note_prestation between 1 and 5);

alter table extrait add constraint chk_vues_positif
check (nombre_vues >= 0);

ALTER TABLE GENRE ADD CONSTRAINT chk_nom_genre 
CHECK (nom_genre IN ('Romance', 'Action', 'Thriller', 'Comédie', 'Historique', 'Fantastique'));

