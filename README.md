# iza-shishamixapi

## Popis

ShishaMixApi je RESTful API vytvořené přes webové rozhraní Vapor k mobilní iOS aplikaci ShishaMix. V současné době je nasazené na cloudové platformě Heroku společně s PostgreSQL databází.

##Účel mobilní aplikace

ShishaMix slouží pro milovníky vodních dýmek, kde si můžou ukládat a odebírat svoje nyní vlastněné tabáky, přidávat a odebírat svoje mixy, které si chtějí uložit a zároveň se s nimi podělit s ostatními uživateli aplikace. Uživatel může potom tyhle mixy vyhledat a podívat se, jakým způsobem si udělali ostatní uživatelé svoji dýmku( svůj mix tabáků).

    
##Účel Vapor API

Mobilní aplikace využívá API především k dotahování, přidávání, upravování a odstraňování dat z databáze díky controllerům, ale taky k připravování samotné PostgreSQL databáze skrz migrace a připravování datových modelů reprezentantů tabulek. Datové modely si mezi sebou aplikace a API vyměňuje skrz JSON.

##Současná funkčnost

Viz https://github.com/mzavrt/iza-shishamixapi/issues

##Plány do budoucna

- Uživatel si bude moct od ostatních uživatelů přidávat mixy do oblíbenych a hodnotit je 
- Vyhledávání mixů podle parametrů mixů(Podle tabáků, příchutě atd.)
- Přidání koláče k mixům skládající podle přidáných tabáků (svěží = zelená část, ovocná = třeba červená atd.)

##Využíté nástroje při vývoji

- Xcode
- Postman - CRUD dotazy
- Azure Data Studio - přístup k databázi
- Docker - pro vytvoření testovací PostgreSQL databáze
- Heroku - deploy api
