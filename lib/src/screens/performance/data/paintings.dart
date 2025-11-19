const paintingsDataStr = '''
[
  {
    "title": "Nature morte",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/41/Cezanne%2C_Still_Life%2C_ca._1890%2C_National_Gallery%2C_Oslo_%281%29_%2836298326492%29.jpg"
  },
  {
    "title": "Pommes et Oranges",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fd/Paul_c%C3%A9zanne%2C_mele_e_arance%2C_1899_ca._02.JPG"
  },
  {
    "title": "Garçon au gilet rouge",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9d/Le_Gar%C3%A7on_au_gilet_rouge%2C_par_Paul_C%C3%A9zanne%2C_National_Gallery_of_Art.jpg"
  },
  {
    "title": "La Montagne Sainte-Victoire vue de Bibémus",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/af/La_Montagne_Sainte-Victoire_vue_de_la_carri%C3%A8re_Bib%C3%A9mus%2C_par_Paul_C%C3%A9zanne.jpg"
  },
  {
    "title": "Les Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/69/Les_Joueurs_de_cartes%2C_par_Paul_C%C3%A9zanne.jpg"
  },
  {
    "title": "Les Grandes Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/25/Paul_C%C3%A9zanne%2C_French_-_The_Large_Bathers_-_Google_Art_Project.jpg"
  },
  {
    "title": "Un Hommage à Cézanne (titre de l'exposition)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/52/%22Ein_Ehrenplatz%22_f%C3%BCr_die_Gem%C3%A4lde_von_Paul_Cezanne_im_Museum_Granet._06.jpg"
  },
  {
    "title": "Sous-bois",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2c/Barberini_August_2023-Paul_C%C3%A9zanne_-_Unterholz%2C_1897-98_-_Sammlung_Hasso_Plattner.jpg"
  },
  {
    "title": "Berlin, Palais Max Libermann, Salon de musique",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ee/Berlin%2C_Palais_Max_Libermann%2C_Musikzimmer.jpg"
  },
  {
    "title": "Les Pêcheurs (Scène fantastique)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/8/87/Cezanne_-_The_Fishermen_%28Fantastic_Scene%29_-_with_frame.jpg"
  },
  {
    "title": "L'Homme au bonnet de coton",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/44/Cezanne_-_Antoine_Aubert%2C_the_Artist%27s_Uncle_-_with_frame.jpg"
  },
  {
    "title": "Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/95/Cezanne_-_Bathers_-_with_frame.jpg"
  },
  {
    "title": "Portrait de Mme Cézanne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fe/Cezanne_-_Madame_Cezanne_in_the_Conservatory_-_with_frame.jpg"
  },
  {
    "title": "Le golfe de Marseille vu de l'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/69/Cezanne_-_The_Gulf_of_Marseilles_Seen_from_L%27Estaque_-_with_frame.jpg"
  },
  {
    "title": "Le bassin du Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b6/Cezanne_-_The_pool_at_Jas_de_Buffon_-_with_frame.jpg"
  },
  {
    "title": "Vue du Domaine Saint-Joseph",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cezanne_-_View_of_the_Domaine_Saint-Joseph_-_with_frame.jpg"
  },
  {
    "title": "L'Homme à la blouse bleue",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/70/Cezanne_Man_in_a_blue_smock_2_Kimbell.jpg"
  },
  {
    "title": "Nature morte",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/57/Cezanne%2C_Still_Life%2C_ca._1890%2C_National_Gallery%2C_Oslo_%282%29_%2836298317162%29.jpg"
  },
  {
    "title": "Nature morte",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/eb/Paul_C%C3%A9zanne_-_Still_life_-_Nasjonalmuseet_-_IMG_9674ngo.jpg"
  },
  {
    "title": "Dahlias dans un grand vase de Delft",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/13/C%C3%A9zanne_Dahlias_dans_un_grand_vase_de_Delft.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/75/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51520492897.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/66/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51520492932.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/53/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51521306701.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/35/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51521306741.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c2/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51521307096.jpg"
  },
  {
    "title": "Exposition La collection Morozov - icônes de l’art moderne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/ca/Exposition_La_collection_Morozov_-_ic%C3%B4nes_de_l%E2%80%99art_moderne_-_Fondation_Louis_Vuitton_%C3%A0_Paris_-_Septembre_2021_-_51522214665.jpg"
  },
  {
    "title": "Portrait de Gustave Boyer (né en 1840) avec un chapeau de paille",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a3/Gustave_Boyer_%28b._1840%29_in_a_Straw_Hat_by_Paul_C%C3%A9zanne_in_the_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Portrait de Gustave Boyer (né en 1840) avec un chapeau de paille",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7a/Gustave_Boyer_%28b._1840%29_in_a_Straw_Hat_MET_DT1938.jpg"
  },
  {
    "title": "La route tournante en sous-bois",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/12/La_route_tournante_en_sous-bois_%281873-1875%29.jpg"
  },
  {
    "title": "Paysage au toit rouge, ou le pin à l'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/eb/Le_pin_%C3%A0_l%27Estaque_%28P._C%C3%A9zanne%2C_Mus%C3%A9e_de_l%27Orangerie%29.jpg"
  },
  {
    "title": "Le pont sur la Marne à Créteil",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/db/Le_pont_sur_la_Marne_%C3%A0_Cr%C3%A9teil._Paul_C%C3%A9zanne._1894.jpg"
  },
  {
    "title": "Maison dans la campagne aixoise",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/3f/Maison_dans_la_campagne_aixoise%2C_par_Paul_C%C3%A9zanne%2C_Dallas_Museum_of_Art%2C_avec_cadre.jpg"
  },
  {
    "title": "Nature morte, poire et pommes vertes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ef/Nature_morte%2C_poire_et_pommes_vertes.JPG"
  },
  {
    "title": "La Route vers l'étang",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/08/Pascal_KMM.JPG"
  },
  {
    "title": "Les Grandes Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/dd/Paul_cezanne%2C_grandi_bagnanti%2C_1906.JPG"
  },
  {
    "title": "La Montagne Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c3/Paul_cezanne%2C_mount_sainte-vistoire%2C_1902-04.JPG"
  },
  {
    "title": "Portrait d'un Paysan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/48/Paul_Cezanne%2C_Portrait_of_a_Peasant%2C_1905-06_%282%29_%2829314389085%29.jpg"
  },
  {
    "title": "Apothéose de Delacroix",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/de/Paul_C%C3%A9zanne_-_Apoth%C3%A9ose_de_Delacroix_01.jpg"
  },
  {
    "title": "Baigneurs",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b6/Paul_C%C3%A9zanne_-_Baigneurs_%2852254963362%29.jpg"
  },
  {
    "title": "Cour d'une ferme",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9e/Paul_C%C3%A9zanne_-_Cour_d%27une_ferme_%2852255951798%29.jpg"
  },
  {
    "title": "Nature morte au tiroir ouvert",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/5a/Paul_C%C3%A9zanne_-_Nature_morte_au_tiroir_ouvert_%2852259399203%29.jpg"
  },
  {
    "title": "Portrait d'Achille Emperaire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fa/Paul_c%C3%A9zanne%2C_achille_emperaire%2C_1867-68_ca.JPG"
  },
  {
    "title": "Autoportrait",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/64/Paul_c%C3%A9zanne%2C_autoritratto%2C_1880-81_ca.jpg"
  },
  {
    "title": "Autoportrait",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ed/Paul_c%C3%A9zanne%2C_autoritratto%2C_1883-87_ca.jpg"
  },
  {
    "title": "Baigneuses (Les Grandes Baigneuses)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e5/Paul_c%C3%A9zanne%2C_bagnanti_%28le_grandi_bagnanti%29%2C_1894-1905_ca.jpg"
  },
  {
    "title": "Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/40/Paul_c%C3%A9zanne%2C_bagnanti%2C_1890_circa.JPG"
  },
  {
    "title": "Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/07/Paul_c%C3%A9zanne%2C_bagnanti%2C_1899-1904.jpg"
  },
  {
    "title": "Barque et baigneurs",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/75/Paul_c%C3%A9zanne%2C_barca_e_bagnanti%2C_1890_ca._01.JPG"
  },
  {
    "title": "Maison en Provence",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/28/Paul_c%C3%A9zanne%2C_casa_in_provenza%2C_1886_ca.jpg"
  },
  {
    "title": "Collines en Provence",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/40/Paul_c%C3%A9zanne%2C_colline_in_provenza%2C_1890-92_ca.jpg"
  },
  {
    "title": "Paysan assis",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/26/Paul_c%C3%A9zanne%2C_contadino_seduto%2C_1900-04.JPG"
  },
  {
    "title": "Cour de ferme",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/3e/Paul_c%C3%A9zanne%2C_corte_di_fattoria%2C_1879_ca.JPG"
  },
  {
    "title": "Le Christ aux Limbes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e4/Paul_c%C3%A9zanne%2C_cristo_al_limbo%2C_1867-69_ca._01.JPG"
  },
  {
    "title": "Dahlias dans un grand vase de Delft",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7a/Paul_c%C3%A9zanne%2C_dalie_in_un_grande_vaso_di_delft%2C_1873_ca._01.JPG"
  },
  {
    "title": "Deux Pommes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e1/Paul_c%C3%A9zanne%2C_due_mele%2C_1895-1900_ca.jpg"
  },
  {
    "title": "Fleurs et Fruits",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c5/Paul_c%C3%A9zanne%2C_fiori_e_frutta%2C_1880_ca.JPG"
  },
  {
    "title": "Fleurs dans un vase bleu",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/ce/Paul_c%C3%A9zanne%2C_fiori_in_un_vaso_blu%2C_1880_ca.JPG"
  },
  {
    "title": "Fruits, pommes et biscuits",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e7/Paul_c%C3%A9zanne%2C_frutta%2C_mele_e_biscotti%2C_1879-80%2C_01.JPG"
  },
  {
    "title": "Fruits, nappe et bouteille de lait",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/59/Paul_c%C3%A9zanne%2C_frutta%2C_panno_e_bottiglia_di_latte%2C_1880-81%2C_01.JPG"
  },
  {
    "title": "Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/4e/Paul_c%C3%A9zanne%2C_giocatori_di_carte%2C_1890-92.JPG"
  },
  {
    "title": "Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/69/Paul_c%C3%A9zanne%2C_giocatori_di_carte%2C_1892-96_ca..JPG"
  },
  {
    "title": "Les outils de Cézanne. Nature morte avec la médaille de Philippe Solari",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/ac/Paul_c%C3%A9zanne%2C_gli_strumenti_di_c%C3%A9zanne._natura_morta_con_la_medaglia_di_philippe_solari%2C_1872.JPG"
  },
  {
    "title": "Grand Bouquet de Fleurs",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/11/Paul_c%C3%A9zanne%2C_grande_mazzo_di_fiori%2C_1892-95_ca.jpg"
  },
  {
    "title": "Portrait de Gustave Geffroy",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f2/Paul_c%C3%A9zanne%2C_gustave_geffroy%2C_1895-96%2C_01.JPG"
  },
  {
    "title": "Les Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b4/Paul_c%C3%A9zanne%2C_i_giocatori_a_carte%2C_1890-95%2C_01.JPG"
  },
  {
    "title": "Les Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/07/Paul_c%C3%A9zanne%2C_i_giocatori_a_carte%2C_1890-95%2C_02.JPG"
  },
  {
    "title": "Les Voleurs et l'Âne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/51/Paul_c%C3%A9zanne%2C_i_ladri_e_l%27asino%2C_1869-1870%2C_01.jpg"
  },
  {
    "title": "Le Panier de pommes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/5b/Paul_c%C3%A9zanne%2C_il_cesto_di_mele%2C_1893_ca.jpg"
  },
  {
    "title": "Le Jardinier Vallier",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/d2/Paul_c%C3%A9zanne%2C_il_giardiniere_vallier%2C_1906_ca._%28tate%29.jpg"
  },
  {
    "title": "Le Grand Pin",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/3c/Paul_c%C3%A9zanne%2C_il_grande_pino%2C_1890-96.JPG"
  },
  {
    "title": "Le Nègre Scipion",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/5a/Paul_c%C3%A9zanne%2C_il_negro_scipio%2C_1866-68.JPG"
  },
  {
    "title": "Portrait du père de l'artiste Louis-Auguste Cézanne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/17/Paul_c%C3%A9zanne%2C_il_padre_dell%27artista_louis-auguste_c%C3%A9zanne%2C_1865_ca.jpg"
  },
  {
    "title": "Le Vase de tulipes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/56/Paul_c%C3%A9zanne%2C_il_vaso_di_tulipani%2C_1890_ca.jpg"
  },
  {
    "title": "L'Allée au Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/1d/Paul_c%C3%A9zanne%2C_il_viale_al_jas_de_bouffan%2C_1871_ca.jpg"
  },
  {
    "title": "L'Avocat (L'Oncle Dominique)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e7/Paul_c%C3%A9zanne%2C_l%27avvocato_%28lo_zio_dominique%29%2C_1866.JPG"
  },
  {
    "title": "L'Estaque, Effet de soir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/23/Paul_c%C3%A9zanne%2C_l%27estaque%2C_effetto_di_sera.jpg"
  },
  {
    "title": "La Baie de Marseille vue de l'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7e/Paul_c%C3%A9zanne%2C_la_baia_di_marsiglia_vista_dall%27estaque%2C_1885_ca.jpg"
  },
  {
    "title": "La Maison du Pendu, Auvers-sur-Oise",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7a/Paul_c%C3%A9zanne%2C_la_casa_dell%27impiccato%2C_auvers-sur-oise%2C_1873.JPG"
  },
  {
    "title": "La Madeleine (La Douleur)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a5/Paul_c%C3%A9zanne%2C_la_maddalena_%28la_dolente%29%2C_1869_ca.JPG"
  },
  {
    "title": "Le Matin en Provence",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/63/Paul_c%C3%A9zanne%2C_la_mattina_in_provenza%2C_1900-06_ca.jpg"
  },
  {
    "title": "La Montagne Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/4b/Paul_c%C3%A9zanne%2C_la_montagna_a_saint-victoire%2C_1887_ca..JPG"
  },
  {
    "title": "Le Bassin du Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/8/8c/Paul_c%C3%A9zanne%2C_la_pescaia_del_Jas_de_bouffant%2C_1878-79_ca.jpg"
  },
  {
    "title": "La Clairière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/24/Paul_c%C3%A9zanne%2C_la_radura%2C_1890_ca.jpg"
  },
  {
    "title": "La Roche Rouge",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b4/Paul_c%C3%A9zanne%2C_la_roccia_rossa%2C_1895_ca.JPG"
  },
  {
    "title": "La Table de cuisine",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/00/Paul_c%C3%A9zanne%2C_la_tavola_di_cucina%2C_1888-90%2C_01.JPG"
  },
  {
    "title": "Le Lac d'Annecy",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b0/Paul_c%C3%A9zanne%2C_lago_ad_annecy%2C_1896.JPG"
  },
  {
    "title": "Les Terres du Château Noir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7a/Paul_c%C3%A9zanne%2C_le_terre_dello_chateau_noir%2C_1900-04_ca.jpg"
  },
  {
    "title": "Madame Cézanne dans le jardin",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/0c/Paul_c%C3%A9zanne%2C_madame_c%C3%A9zanne_in_giardino%2C_1879-80.JPG"
  },
  {
    "title": "Madame Cézanne sur une chaise jaune",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/04/Paul_c%C3%A9zanne%2C_madame_c%C3%A9zanne_su_una_sedia_gialla%2C_1888-90.jpg"
  },
  {
    "title": "Pommes et Oranges",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/00/Paul_c%C3%A9zanne%2C_mele_e_arance%2C_1899_ca._01.JPG"
  },
  {
    "title": "Montagne Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/67/Paul_c%C3%A9zanne%2C_montagna_di_sainte-victoire%2C_1890_ca.JPG"
  },
  {
    "title": "Mont Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/46/Paul_c%C3%A9zanne%2C_monte_sainte-victoire%2C_1904_ca.jpg"
  },
  {
    "title": "Nature morte avec bouilloire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b2/Paul_c%C3%A9zanne%2C_natura_morta_col_bollitore%2C_1867-69%2C_01.JPG"
  },
  {
    "title": "Nature morte avec broc",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c9/Paul_c%C3%A9zanne%2C_natura_morta_con_brocca%2C_1892-93_ca.jpg"
  },
  {
    "title": "Nature morte aux oignons",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2e/Paul_c%C3%A9zanne%2C_natura_morta_con_cipolle%2C_1896-98%2C_01.JPG"
  },
  {
    "title": "Nature morte avec Cupidon",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/11/Paul_c%C3%A9zanne%2C_natura_morta_con_cupido%2C_1894_ca..JPG"
  },
  {
    "title": "Nature morte avec gâteau",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/5a/Paul_c%C3%A9zanne%2C_natura_morta_con_dolce%2C_1877_o_1879.JPG"
  },
  {
    "title": "Nature morte avec pain et œufs",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f4/Paul_c%C3%A9zanne%2C_natura_morta_con_pane_e_uova%2C_1865.jpg"
  },
  {
    "title": "Nature morte avec poires et pommes vertes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/94/Paul_c%C3%A9zanne%2C_natura_morta_con_pere_e_mele_verdi%2C_1873_ca.JPG"
  },
  {
    "title": "Nature morte avec soupière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/93/Paul_c%C3%A9zanne%2C_natura_morta_con_zuppiera%2C_1877_ca._01.JPG"
  },
  {
    "title": "Nature morte en bleu avec citrons",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a6/Paul_c%C3%A9zanne%2C_natura_morta_in_blu_con_limoni%2C_1873-77_ca.jpg"
  },
  {
    "title": "Paysage avec peupliers",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fa/Paul_c%C3%A9zanne%2C_paesaggio_con_pioppi%2C_1885-87_ca.jpg"
  },
  {
    "title": "Paysage avec toits rouges (Le Pin à L'Estaque)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/6c/Paul_c%C3%A9zanne%2C_paesaggio_con_tetti_rossi_%28il_pino_a_l%27estaque%29%2C_1875-76%2C_01.JPG"
  },
  {
    "title": "Paysage près d'Aix avec la Tour de César",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/92/Paul_c%C3%A9zanne%2C_paesaggio_vicino_aix_con_la_tour_de_c%C3%A9sar%2C_1895.jpg"
  },
  {
    "title": "Paysage près d'Aix, la Plaine de la rivière Arc",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2a/Paul_c%C3%A9zanne%2C_paesaggio_vicino_aix%2C_la_pianura_del_fiume_arc%2C_1892-95.jpg"
  },
  {
    "title": "Pastorale (Idylle)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9e/Paul_c%C3%A9zanne%2C_pastorale_%28idillio%29%2C_1870%2C_01.JPG"
  },
  {
    "title": "Assiette de pommes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/93/Paul_c%C3%A9zanne%2C_piatto_con_mele%2C_1877_ca.jpg"
  },
  {
    "title": "Le Pigeonnier à Bellevue",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/21/Paul_c%C3%A9zanne%2C_piccionaia_a_bellevue%2C_1890%2C_01.jpg"
  },
  {
    "title": "Borne dans le parc du Château Noir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/1e/Paul_c%C3%A9zanne%2C_pietra_miliare_nel_parco_di_chateau_noir%2C_1898-1900.JPG"
  },
  {
    "title": "Le Pont de Maincy",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/15/Paul_c%C3%A9zanne%2C_ponte_di_maincy%2C_1879_ca.JPG"
  },
  {
    "title": "Déjeuner sur l'herbe",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/10/Paul_c%C3%A9zanne%2C_pranzo_sull%27erba%2C_1876-77%2C_01.JPG"
  },
  {
    "title": "Déjeuner sur l'herbe",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/6a/Paul_c%C3%A9zanne%2C_pranzo_sull%27erba%2C_1876-77%2C_02.JPG"
  },
  {
    "title": "Portrait de la fille de l'artiste",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e4/Paul_c%C3%A9zanne%2C_ritratto_della_figlia_dell%27artista%2C_1881-82.JPG"
  },
  {
    "title": "Portrait d'Ambroise Vollard",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2c/Paul_c%C3%A9zanne%2C_ritratto_di_ambroise_vollard%2C_1899%2C_01.JPG"
  },
  {
    "title": "Portrait de Madame Cézanne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/8/88/Paul_c%C3%A9zanne%2C_ritratto_di_madame_c%C3%A9zanne%2C_1890_ca.JPG"
  },
  {
    "title": "Rochers et branches à Bibémus",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/ff/Paul_c%C3%A9zanne%2C_rocce_e_rami_a_bib%C3%A9mus%2C_01.JPG"
  },
  {
    "title": "Rochers près des grottes sous Château-Noir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f9/Paul_c%C3%A9zanne%2C_rocce_presso_le_grotte_sotto_chateau-noir%2C_1904.JPG"
  },
  {
    "title": "Rochers au bord de la mer",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/cd/Paul_c%C3%A9zanne%2C_scogli_al_mare%2C_1865-66.jpg"
  },
  {
    "title": "Nature morte, rideau, pichet et corbeille de fruits",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ea/Paul_c%C3%A9zanne%2C_tenda%2C_brocca_e_cesto_di_frutta%2C_1893-94.jpg"
  },
  {
    "title": "Tête d'homme",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/75/Paul_c%C3%A9zanne%2C_testa_d%27uomo%2C_1865.jpg"
  },
  {
    "title": "Trois Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f6/Paul_c%C3%A9zanne%2C_tre_bagnanti%2C_1879-82.JPG"
  },
  {
    "title": "Homme à la pipe",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9d/Paul_c%C3%A9zanne%2C_uomo_con_la_pipa%2C_1892-96.JPG"
  },
  {
    "title": "Vase de fleurs et poires",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c4/Paul_c%C3%A9zanne%2C_vaso_di_fiori_e_pere%2C_1888-90_ca..JPG"
  },
  {
    "title": "Vieille femme au chapelet",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/72/Paul_c%C3%A9zanne%2C_vecchia_col_rosario%2C_1895-96_ca.jpg"
  },
  {
    "title": "Allée à Chantilly",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/cc/Paul_c%C3%A9zanne%2C_viale_a_chantilly%2C_1888_%28londra%29.jpg"
  },
  {
    "title": "Allée à Chantilly",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f8/Paul_c%C3%A9zanne%2C_viale_a_chantilly%2C_1888.jpg"
  },
  {
    "title": "Allée au Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/30/Paul_c%C3%A9zanne%2C_viale_al_jas_de_bouffan%2C_1890_ca..JPG"
  },
  {
    "title": "Maison derrière les arbres près du Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/19/Paul_C%C3%A9zanne-House_Behind_Trees_Near_the_Jas_de_Bouffan-Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Mont Sainte-Victoire et le Viaduc de la vallée de l'Arc",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9e/Paul_C%C3%A9zanne-Mont_Sainte-Victoire_and_the_Viaduct_of_the_Arc_River_Valley-Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Nature morte aux pommes et poires",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/8/89/Paul_C%C3%A9zanne-Still_life_with_Apples_and_Pears-The_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Portrait de l'Oncle Dominique",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fb/Portrait_of_Uncle_Dominique_by_Paul_C%C3%A9zanne_in_the_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Portrait de Dominique Aubert",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/ae/Portrait_painting_of_Dominique_Aubert_by_Paul_C%C3%A9zanne.jpg"
  },
  {
    "title": "Quartier Four Auvers-sur-Oise (Paysage Auvers)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/6/6b/Quartier_Four_Auvers-sur-Oise_%28Landscape_Auvers%29_PMA%284%29_%2849523535817%29.jpg"
  },
  {
    "title": "Paysan assis",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/27/Seated_Peasant_by_Paul_C%C3%A9zanne_at_the_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Les Joueurs de cartes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a2/The_Card_Players_by_Paul_C%C3%A9zanne_at_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Le Golfe de Marseille vu de L'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b0/The_Gulf_of_Marseilles_Seen_from_L%27Estaque%2C_c1885_by_Paul_C%C3%A9zanne_at_the_Metropolitan_Museum_of_Art.jpg"
  },
  {
    "title": "Pins et Rochers",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/28/WLA_moma_Paul_Czanne_Pines_and_Rocks_1.jpg"
  },
  {
    "title": "La Route tournante à Montgeroult",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b8/WLA_moma_Paul_Czanne_Turning_Road_at_Montgeroult.jpg"
  },
  {
    "title": "La Route tournante à Montgeroult",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/ff/WLA_moma_Turning_Road_at_Montgeroult_by_Paul_Czanne.jpg"
  },
  {
    "title": "Femme à la cafetière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/d4/Woman_with_a_Coffee_Pot_by_Paul_C%C3%A9zanne_%2852255926646%29.jpg"
  },
  {
    "title": "Femme à la cafetière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/55/Woman_with_a_Coffee_Pot_by_Paul_C%C3%A9zanne_%2852256424300%29.jpg"
  },
  {
    "title": "La Carrière de Bibémus",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/d/d9/Paul_C%C3%A9zanne_-_La_carri%C3%A8re_de_Bib%C3%A9mus_%28ca._1895%29.jpg"
  },
  {
    "title": "Rochers, pins et mer à l'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e8/Vue_sur_la_mer_%C3%A0_l%27Estaque%2C_par_Paul_C%C3%A9zanne%2C_Google_Art_Project.jpg"
  },
  {
    "title": "Nature morte, pot à lait et fruits sur une table",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/cc/Paul_C%C3%A9zanne_-_Still_life_-_Google_Art_Project.jpg"
  },
  {
    "title": "Le Garçon au gilet rouge",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2f/Paul_C%C3%A9zanne_-_Boy_in_a_Red_Waistcoat_-_Google_Art_Project.jpg"
  },
  {
    "title": "Les Marronniers du Jas de Bouffan en hiver",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/c0/Paul_C%C3%A9zanne_-_Chestnut_Trees_at_Jas_de_Bouffan_-_Google_Art_Project.jpg"
  },
  {
    "title": "Au bord d'une rivière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e4/Paul_C%C3%A9zanne_-_Au_bord_d%27une_rivi%C3%A8re_%28RISD%29.jpg"
  },
  {
    "title": "Mont Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/ac/Paul_C%C3%A9zanne_-_Mont_Sainte-Victoire_-_Google_Art_Project.jpg"
  },
  {
    "title": "La Carrière de Bibémus",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/ca/Paul_C%C3%A9zanne_-_Carri%C3%A8re_de_Bib%C3%A9mus_%281898-99%29.jpg"
  },
  {
    "title": "Maisons en Provence : Vallée des Riaux près de L'Estaque",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/30/Paul_C%C3%A9zanne_-_Houses_in_Provence-_The_Riaux_Valley_near_L%27Estaque_-_Google_Art_Project.jpg"
  },
  {
    "title": "Maison en Provence",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/2a/C%C3%A9zanne%2C_Paul_-_House_in_Provence_-_Google_Art_Project.jpg"
  },
  {
    "title": "Portrait d'Anthony Valabrègue",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ed/C%C3%A9zanne%2C_Paul_-_Portrait_of_Anthony_Valabr%C3%A8gue_-_Google_Art_Project.jpg"
  },
  {
    "title": "Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e3/Paul_Cezanne_-_Bathers_-_Google_Art_Project.jpg"
  },
  {
    "title": "Baigneurs au repos",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a1/Paul_Cezanne_-_Bathers_at_Rest_-_Google_Art_Project.jpg"
  },
  {
    "title": "Bol et boîte à lait",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/af/Paul_Cezanne_-_Bowl_and_Milk-Jug_-_Google_Art_Project.jpg"
  },
  {
    "title": "La Montagne Sainte-Victoire et Château Noir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/26/Paul_Cezanne_-_Mont_Sainte-Victoire_and_Ch%C3%A2teau_Noir_-_Google_Art_Project.jpg"
  },
  {
    "title": "Montagne Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/56/Paul_Cezanne_-_Montagne_Sainte-Victoire_-_Google_Art_Project.jpg"
  },
  {
    "title": "Vue matinale de L'Estaque contre le soleil",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/3e/Paul_Cezanne_-_Morning_View_of_L%27Estaque_Against_the_Sunlight_-_Google_Art_Project.jpg"
  },
  {
    "title": "Cézanne coiffé d'un chapeau mou",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/30/Paul_Cezanne_-_Self-Portrait_with_a_Hat_-_Google_Art_Project.jpg"
  },
  {
    "title": "Les Baigneurs (grande planche)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/c/cb/Paul_Cezanne_-_The_bathers_%28large_plate%29_-_Google_Art_Project.jpg"
  },
  {
    "title": "L'Éternel Féminin",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b2/Paul_C%C3%A9zanne_%28French_-_The_Eternal_Feminine_-_Google_Art_Project.jpg"
  },
  {
    "title": "Jeune femme italienne à table",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/f1/Paul_C%C3%A9zanne_%28French_-_Young_Italian_Woman_at_a_Table_-_Google_Art_Project.jpg"
  },
  {
    "title": "Achille Emperaire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/39/Paul_C%C3%A9zanne_-_Achille_Emperaire_-_Google_Art_Project.jpg"
  },
  {
    "title": "Allée de marronniers au Jas de Bouffan",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/95/Paul_C%C3%A9zanne_-_Avenue_of_Chestnut_Trees_at_the_Jas_de_Bouffan_-_Google_Art_Project.jpg"
  },
  {
    "title": "Bords de la Marne",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a3/Paul_C%C3%A9zanne_-_Banks_of_the_Marne_-_Google_Art_Project.jpg"
  },
  {
    "title": "Baigneuses (Les Grandes Baigneuses)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/f/fe/Paul_C%C3%A9zanne_-_Bathers_%28Les_Grandes_Baigneuses%29_-_Google_Art_Project.jpg"
  },
  {
    "title": "Baigneuses",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/a/a0/Paul_C%C3%A9zanne_-_Bathers_-_Google_Art_Project_%28520022%29.jpg"
  },
  {
    "title": "Baigneurs",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/9/9a/Paul_C%C3%A9zanne_-_Bathers_-_Google_Art_Project.jpg"
  },
  {
    "title": "Virage du Chemin des Lauves",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/b/b0/Paul_C%C3%A9zanne_-_Bend_Of_The_Road_At_The_Top_Of_The_Chemin_Des_Lauves_-_Google_Art_Project.jpg"
  },
  {
    "title": "Fond du ravin",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/ee/Paul_C%C3%A9zanne_-_Bottom_of_the_Ravine_-_Google_Art_Project.jpg"
  },
  {
    "title": "Boîte à lait et pommes",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/77/Paul_C%C3%A9zanne_-_Bo%C3%AEte_%C3%A0_lait_et_pommes_-_Google_Art_Project.jpg"
  },
  {
    "title": "Château Noir",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/7d/Paul_C%C3%A9zanne_-_Ch%C3%A2teau_Noir_-_Google_Art_Project.jpg"
  },
  {
    "title": "Château Noir devant la Montagne Sainte-Victoire",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/e/e6/Paul_C%C3%A9zanne_-_Ch%C3%A2teau_Noir_and_Mont_Sainte-Victoire%2C_c._1890-1895_-_Google_Art_Project.jpg"
  },
  {
    "title": "Maison de campagne au bord d'une rivière",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/0/0a/Paul_C%C3%A9zanne_-_Country_House_by_a_River_-_Google_Art_Project.jpg"
  },
  {
    "title": "Le Clos normand (Hattenville)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/24/Paul_C%C3%A9zanne_-_Farm_in_Normandy%2C_c._1885-86_-_Google_Art_Project.jpg"
  },
  {
    "title": "Cour de ferme",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/4/44/Paul_C%C3%A9zanne_-_Farmyard_-_Google_Art_Project.jpg"
  },
  {
    "title": "Campagnes de Bellevue",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/5/53/Paul_C%C3%A9zanne_-_Fields_at_Bellevue_-_Google_Art_Project.jpg"
  },
  {
    "title": "Fleurs dans un pot de gingembre et fruits",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/7/78/Paul_C%C3%A9zanne_-_Fleurs_dans_un_pot_de_gingembre_et_fruits_-_Google_Art_Project.jpg"
  },
  {
    "title": "Scène forestière (Chemin du Mas Jolie à Château Noir)",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/3/36/Paul_C%C3%A9zanne_-_Forest_Scene_%28Path_from_Mas_Jolie_to_Ch%C3%A2teau_noir%29_-_Google_Art_Project.jpg"
  },
  {
    "title": "Fruits et un pichet sur une table",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/2/29/Paul_C%C3%A9zanne_-_Fruit_and_a_Jug_on_a_Table_-_Google_Art_Project.jpg"
  },
  {
    "title": "Pot à gingembre avec grenade et poires",
    "image_url": "https://upload.wikimedia.org/wikipedia/commons/1/13/Paul_C%C3%A9zanne_-_Ginger_Pot_with_Pomegranate_and_Pears_-_Google_Art_Project.jpg"
  }
]
''';