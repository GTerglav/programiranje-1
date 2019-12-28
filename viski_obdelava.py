import re
import orodja
import csv
import os
import requests

# definiratje URL glavne strani 
viski_frontpage_url = 'http://whiskyadvocate.com/ratings-reviews/?search=&submit=+&brand_id=0&rating=0&price=0&category=0&styles_id=0&issue_id=103'
# mapa, v katero bomo shranili podatke
viski_directory = 'viski_out'
# ime datoteke v katero bomo shranili glavno stran
frontpage_filename = 'index.html'
# ime CSV datoteke v katero bomo shranili podatke
csv_filename = 'viski.csv'



def download_url_to_string(url):
    """Funkcija kot argument sprejme niz in puskuša vrniti vsebino te spletne
    strani kot niz. V primeru, da med izvajanje pride do napake vrne None.
    """
    try:
        # del kode, ki morda sproži napako
        page_content = requests.get(url)
    except Exception as e:
        # koda, ki se izvede pri napaki
        # dovolj je če izpišemo opozorilo in prekinemo izvajanje funkcije
        print(e)
    # nadaljujemo s kodo če ni prišlo do napake
    return page_content.text

def save_string_to_file(text, directory, filename):
    """Funkcija zapiše vrednost parametra "text" v novo ustvarjeno datoteko
    locirano v "directory"/"filename", ali povozi obstoječo. V primeru, da je
    niz "directory" prazen datoteko ustvari v trenutni mapi.
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w', encoding='utf-8') as file_out:
        file_out.write(text)
    return None

def save_frontpage(page, directory, filename):
    """Funkcija shrani vsebino spletne strani na naslovu "page" v datoteko
    "directory"/"filename"."""

    page_data = download_url_to_string(page)
    save_string_to_file(page_data, directory, filename)


def read_file_to_string(directory, filename):
    """Funkcija vrne celotno vsebino datoteke "directory"/"filename" kot niz"""
    full_path = os.path.join(directory, filename)
    with open(full_path, "r", encoding="utf-8") as f:
        return f.read()

vzorec_bloka = re.compile(
    r'<div\sclass="review-top">.*?'
    r'<div class="line-bot-mob cf">',
    flags=re.DOTALL
)

vzorec_viskija = re.compile(
    r'"ratingValue">(?P<ocena>.*?)</sp.*?'
    r'="name">(?P<ime>.*?),\s(?P<alkohol>\d.*?)%</h1>.*?'
    r'"category">(?P<kategorija>.*?)<.*?'
    r'itemprop="price"\scontent="50.00">(?P<cena>.*?)m*l*\.*</span>.*?'
    r'itemprop="description">.*?class="p1">(?P<opis>.*?)<.*?'
    r'"author">(?P<ocenjevalec>.*?)<.*?'
    r'issue.*?>(?P<cas_ocene>.*?)<',
    flags=re.DOTALL
)

vzorec_viskija2 = re.compile(
    r'"ratingValue">(?P<ocena>.*?)</span>.*?'
    r'<h1\sitemprop="name">(?P<ime>.*?)(,"*\s+(?P<alkohol>\d.*?)%,*|</h1>).*?'
    r'<span itemprop="category">(?P<kategorija>.*?)</span>.*?'
    r'<span itemprop="price" content="50.00">(?P<cena>.*?)</span>.*?'
    r'<p>(<p class="p1">)*(<span class="s1">)*(?P<opis>.*?)(</span>)*(</p>)*</div>.*?'
    r'<p>Reviewed by: <span itemprop="author">(?P<ocenjevalec>.*?)</span>.*?'
    r'>(?P<cas_ocene>.*?)</a>\)</p>',
    flags=re.DOTALL
)

vzorec_alkohola = re.compile(
    r'<h1\sitemprop="name">.*?,\s(?P<alkohol>.*?)%,*</h1>.*?'
)

def izloci_podatke(blok):
    viski = vzorec_viskija2.search(blok).groupdict()
    viski['ocena'] = int(viski['ocena'])
    if viski['cena'].isdigit():
        viski['cena'] = int(viski['cena'])
    else:
        viski['cena'] = None
    #if viski['cena'] == '':
    #    viski['cena'] = None
    #else:
    #    if viski['cena'] > 40000:
    #        viski['cena'] = (viski['cena']//1000)*2
    #    else:
    #        viski['cena'] = int(viski['cena'].replace(',', '').replace('/', '')) 
    if viski['alkohol'] is None:
        viski['alkohol'] = None
    elif viski['alkohol'].isdigit():
        viski['alkohol'] = float(viski['alkohol'])
    else:
        viski['alkohol'] = None
    #alkohola = vzorec_alkohola.search(blok)
    #if alkohola:
    #    viski['alkohol'] = alkohola['alkohol']
    #else:
    #    viski['alkohol'] = None
    return viski


def blok_iz_dat(directory, filename):
    vsebina = read_file_to_string(directory, filename)
    for blok in vzorec_bloka.finditer(vsebina):
        yield izloci_podatke(blok.group(0))

def write_csv(fieldnames, rows, directory, filename):
    """
    Funkcija v csv datoteko podano s parametroma "directory"/"filename" zapiše
    vrednosti v parametru "rows" pripadajoče ključem podanim v "fieldnames"
    """
    os.makedirs(directory, exist_ok=True)
    path = os.path.join(directory, filename)
    with open(path, 'w') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row)
    return


def main(redownload=True, reparse=True):
    """Funkcija izvede celoten del pridobivanja podatkov:
    1. Oglase prenese iz bolhe
    2. Lokalno html datoteko pretvori v lepšo predstavitev podatkov
    3. Podatke shrani v csv datoteko
    """
    
    for i in range(50):
        viski_frontpage_url = 'http://whiskyadvocate.com/ratings-reviews/?search=&submit=+&brand_id=0&rating=0&price=0&category=0&styles_id=0&issue_id={}'.format(103-i)
        print(viski_frontpage_url)
        frontpage_filename = 'index{}.html'.format(i)
        save_frontpage(viski_frontpage_url, viski_directory, frontpage_filename)
    niz = ""
    for stevec in range(50):
        ime_dat = "index{}.html".format(stevec)
        podatki = read_file_to_string("viski_out", ime_dat)
        niz += podatki
    
    save_string_to_file(niz, "viski_out_full", "index_full.html")
    stevec = 0
    vsebina = read_file_to_string(viski_directory, frontpage_filename)
    for blok in vzorec_bloka.findall(vsebina):
        viski = vzorec_viskija2.search(blok).groupdict()
        stevec += 1
        print(stevec)

#
    viskiji = []
    for blok in blok_iz_dat("viski_out_full", "index_full.html"):
        viskiji.append(blok)
    viskiji.sort(key=lambda viski: viski['ocena'])
    orodja.zapisi_csv(
        viskiji,
        ['ocena', 'ime', 'alkohol', 'kategorija', 'cena', 'opis', 'ocenjevalec', 'cas_ocene'],
        csv_filename,
        
    )



if __name__ == '__main__':
    main()