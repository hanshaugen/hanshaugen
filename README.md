<<<<<<< HEAD
## Hi there 👋

<!--
**hanshaugen/hanshaugen** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.

Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->
=======
# Hanshaugen

To repoer styrer ett domene.

| Repo | Mappe her | Adresse |
| --- | --- | --- |
| [hanshaugen/hanshaugen](https://github.com/hanshaugen/hanshaugen) | denne mappen, uten klinikken | `hanshaugen.com` |
| [hanshaugen/smerteklinikkenoslo](https://github.com/hanshaugen/smerteklinikkenoslo) | `smerteklinikkenoslo/` | `hanshaugen.com/smerteklinikkenoslo/` |

`frontpage/` er forsiden. Mappen heter ikke `main`. GitHub Actions i dette repoet bygger `_site/`: innholdet fra `frontpage/` i roten, og klinikken kopiert inn som undermappe. Klinikkrepoet er kilden til undersiden. Pitch-notatene i klinikkens `README.md` blir ikke med ut.

Se siden lokalt:

```bash
bash script/assemble.sh
python3 -m http.server 8765 --directory _site
```

Åpne [http://127.0.0.1:8765](http://127.0.0.1:8765) og [http://127.0.0.1:8765/smerteklinikkenoslo/](http://127.0.0.1:8765/smerteklinikkenoslo/).

## Det som må gjøres én gang

Repoene må være offentlige hvis GitHub-kontoen er på gratisplanen. Pages fra private repoer krever betalt plan.

1. Push dette repoet til `hanshaugen/hanshaugen`, gren `main`.
2. Push `smerteklinikkenoslo/` til `hanshaugen/smerteklinikkenoslo`, gren `main`.
3. På `hanshaugen/hanshaugen`: Settings → Pages → Build and deployment → Source: **GitHub Actions**.
4. Kjør workflowen «Publish hanshaugen.com» én gang, eller push til `main`. Den skal bli grønn før du rører DNS.
5. Lag en finmasket token på GitHub (bare repoet `hanshaugen`, tillatelse Contents: Read and write). Legg den inn som hemmelighet `HANSHAUGEN_PAT` på repoet `smerteklinikkenoslo`. Uten den oppdateres klinikksiden i git, men domenet bygges ikke på nytt av seg selv.
6. Når Pages har en grønn deploy: Settings → Pages → Custom domain → `hanshaugen.com`. Kryss av Enforce HTTPS når sertifikatet er klart. Hvis GitHub viser en TXT-verdi for å bekrefte domenet, legg den til. Ikke slett de TXT-postene som allerede ligger der.

## DNS hos GoDaddy

Navnetjenerne er GoDaddy (`domaincontrol.com`). De skal bli. E-posten peker til Microsoft 365 og må bli stående:

- MX `412809198.pamx1.hotmail.com`
- TXT `v=spf1 include:outlook.com -all`
- TXT `MS=ms71915740`
- CNAME `autodiscover` → `autodiscover.outlook.com`

Bytt bare webben. I dag peker A-postene på GoDaddy (`76.223.105.230` og `13.248.243.5`), og `www` er en CNAME til selve domenet.

| Type | Navn | Verdi |
| --- | --- | --- |
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `hanshaugen.github.io` |

Fjern de to gamle A-postene. Ikke legg repo-navnet i CNAME-en. Slå av eventuell videresending (forwarding) på domenet, den kjemper med A-postene.

`www.hanshaugen.com` sender GitHub videre til `hanshaugen.com`. Sertifikatet kommer etter at DNS stemmer, ofte innen en time, noen ganger et døgn.

## Etterpå

Et push til `hanshaugen` publiserer forsiden. Et push til `smerteklinikkenoslo` ber hovedrepoet bygge på nytt, så `/smerteklinikkenoslo/` følger klinikkrepoet. Neste demo er en ny mappe i samme mønster, pluss en lenke på forsiden.
>>>>>>> b785fd4 (Publiser hanshaugen.com fra de to repoene.)
