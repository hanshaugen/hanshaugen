# Publisering

To repoer styrer ett domene. Forsiden på hanshaugen.com nevner ingen kunder og lenker ikke til undersidene. En som fjerner stien etter skråstreken, skal bare se verkstedet.

| Repo | Mappe her | Adresse |
| --- | --- | --- |
| [hanshaugen/hanshaugen](https://github.com/hanshaugen/hanshaugen) | denne mappen, uten kunderepo | `hanshaugen.com` |
| [hanshaugen/smerteklinikkenoslo](https://github.com/hanshaugen/smerteklinikkenoslo) | `smerteklinikkenoslo/` | `hanshaugen.com/smerteklinikkenoslo/` |

`frontpage/` er forsiden. Mappen heter ikke `main`. GitHub Actions i dette repoet bygger `_site/`: innholdet fra `frontpage/` i roten, og klinikken kopiert inn som undermappe. Klinikkrepoet er kilden til undersiden. `README.md` i klinikkrepoet blir ikke med ut.

Se siden lokalt:

```bash
bash script/assemble.sh
python3 -m http.server 8765 --directory _site
```

Åpne [http://127.0.0.1:8765](http://127.0.0.1:8765) og [http://127.0.0.1:8765/smerteklinikkenoslo/](http://127.0.0.1:8765/smerteklinikkenoslo/).

## Oppsett som allerede er gjort

1. Begge repoene ligger på `main`.
2. Pages på `hanshaugen/hanshaugen` bygges med GitHub Actions («Publish hanshaugen.com»).
3. Hemmeligheten `HANSHAUGEN_PAT` på `smerteklinikkenoslo` er en finmasket token med Contents: Read and write, bare på repoet `hanshaugen`. Uten den oppdateres klinikksiden i git, men domenet bygges ikke på nytt av seg selv.
4. Custom domain er `hanshaugen.com`. Enforce HTTPS krysses av når sertifikatet er klart.
5. DNS hos GoDaddy er oppdatert 18. november 2026. Den får bruke tiden den trenger. Navnetjenerne blir på GoDaddy.

Repoene bør være offentlige. Da virker GitHub Pages på gratisplanen, og bygget kan hente klinikksiden uten ekstra token. Er `smerteklinikkenoslo` privat, legg en lese-token inn som hemmelighet `CLINIC_TOKEN` på `hanshaugen/hanshaugen`. Pages fra et privat repo krever i tillegg betalt GitHub-plan.

Offentlige repo-navn vises på github.com/hanshaugen. Forsiden lenker ikke dit.

## DNS som skal stå

E-posten peker til Microsoft 365 og må bli stående:

- MX `412809198.pamx1.hotmail.com`
- TXT `v=spf1 include:outlook.com -all`
- TXT `MS=ms71915740`
- CNAME `autodiscover` → `autodiscover.outlook.com`

Webben:

| Type | Navn | Verdi |
| --- | --- | --- |
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| CNAME | `www` | `hanshaugen.github.io` |

De gamle parkerings-A-postene (`76.223.105.230` og `13.248.243.5`) skal være borte. CNAME for `www` skal være `hanshaugen.github.io`, ikke repo-navnet. Videresending (forwarding) på domenet skal være av. Hvis GitHub viser en TXT-verdi for å bekrefte domenet, legg den til uten å slette TXT-postene som allerede ligger der.

`www.hanshaugen.com` sender GitHub videre til `hanshaugen.com`. Sertifikatet kommer etter at DNS stemmer, ofte innen en time, noen ganger et døgn.

## Etterpå

Et push til `hanshaugen` publiserer forsiden. Et push til `smerteklinikkenoslo` ber hovedrepoet bygge på nytt, så `/smerteklinikkenoslo/` følger klinikkrepoet.

Neste demo er et eget repo og en egen sti, i samme mønster. Den får ingen lenke på forsiden.
