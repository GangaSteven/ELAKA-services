# ELAKA SERVICES — interface de suivi

- Suivi maritime et aérien, sans création de compte client.
- Recherche par numéro exact ; champs publics explicitement limités.
- Logos originaux fournis intégrés dans `assets/`.

## Configuration avant utilisation
1. Supabase → Project Settings → API : copier la Project URL et la clé publique publishable (ou anon legacy).
2. Les saisir dans `supabase-config.js`.
3. Exécuter `supabase/migrations/202611190001_public_tracking.sql` dans le SQL Editor.
4. Tester avec un numéro réel créé dans la base.

Ne jamais placer une clé `service_role` dans le frontend.

## Non encore livré
Administration connectée, création/modification des expéditions, notifications SMS/push, API transporteurs et tests de sécurité de production.
