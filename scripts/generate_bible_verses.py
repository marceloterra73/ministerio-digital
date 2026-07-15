import json
import urllib.request
import sys
import os

ACF_URL = "https://raw.githubusercontent.com/thiagobodruk/biblia/master/json/acf.json"
BOOKS_PATH = os.path.join(os.path.dirname(__file__), "..", "assets", "data", "bible_books.json")
OUTPUT_PATH = os.path.join(os.path.dirname(__file__), "..", "assets", "data", "bible_verses.json")

abbrev_to_name = {}
with open(BOOKS_PATH, "r", encoding="utf-8") as f:
    books = json.load(f)
    for b in books:
        abbrev_to_name[b["abbr"].lower()] = b["name"]

# Fix ACF-specific abbreviations that differ from bible_books.json
abbrev_to_name["atos"] = "Atos"

print(f"Baixando {ACF_URL}...")
with urllib.request.urlopen(ACF_URL) as response:
    acf_data = json.loads(response.read().decode("utf-8-sig"))

verses = []
for book in acf_data:
    abbrev = book["abbrev"]
    full_name = abbrev_to_name.get(abbrev.lower())
    if not full_name:
        print(f"Aviso: abreviatura '{abbrev}' nao encontrada no mapeamento")
        continue
    chapters = book["chapters"]
    for chapter_idx, chapter_verses in enumerate(chapters, 1):
        for verse_idx, text in enumerate(chapter_verses, 1):
            verses.append({
                "book": full_name,
                "chapter": chapter_idx,
                "verse": verse_idx,
                "text": text
            })

print(f"Gerando {len(verses)} versiculos...")
with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
    json.dump(verses, f, ensure_ascii=False, indent=2)

print(f"OK! Arquivo salvo em: {OUTPUT_PATH}")
