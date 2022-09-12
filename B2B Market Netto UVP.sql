-- Titel: B2B Market Netto UVP
-- Beschreibung:
-- SQL Query zum Ändern des UVP von Brutto auf Netto
-- WooCommerce mit B2B Market von Marketpress.
-- Stand: 07 September 2022
-- Autor: © ZenSudo

-- Prüfen der Datenbankspalten (evtl. prefix von postmeta beachten!)
SELECT * FROM `DATABASE`.`postmeta` WHERE `meta_key` LIKE 'bm_rrp';

-- Backup der ursprünglichen Daten:
-- Neue Spalte anlegen
ALTER TABLE `DATABASE`.`postmeta`
ADD meta_value_backup VARCHAR(255) NULL;
-- Backup der UVP Preise in die neue Spalte
UPDATE `DATABASE`.`postmeta`
SET meta_value_backup=meta_value
WHERE `meta_key` LIKE 'bm_rrp';

-- Preisänderungen ausführen (nicht bei Variablen Produkten):
-- Update der Preise von Brutto auf Netto
UPDATE `DATABASE`.`postmeta`
SET meta_value=meta_value*1.19
WHERE `meta_key` LIKE 'bm_rrp' AND meta_value NOT LIKE 'a%';


-- Runden der Preise auf 2 Nachkommstellen
UPDATE `DATABASE`.`postmeta`
SET meta_value=ROUND (meta_value,2)
WHERE `meta_key` LIKE 'bm_rrp' AND meta_value NOT LIKE 'a%';



-- Backup Table löschen.
ALTER TABLE `DATABASE`.`postmeta`
DROP COLUMN meta_value_backup;