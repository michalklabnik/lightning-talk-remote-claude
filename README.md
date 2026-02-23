# Lightning Talk Remote Claude

https://klabnik.link/talk-remote-claude

---

## 1. Claude lokálně

**Výhody**
Jednoduché a přímočaré.
Vše po ruce.

**Nevýhody**
Může se dostat ve všemu (klíče a tajemství).
Nároky na HW (build aplikace a i Claude něco žere).

---

## 2. Claude polo-vzdáleně

**Výhody**
Neběží přímo na hostovi.

**Nevýhody**
Build aplikace do Docker image.
Nestabilní.

Jak to začalo:
```shell
alias dclaude=docker run --rm-it-v$WD:/app current-claude --dangerously-skip-permissions
```
Jak to pokračuje:
https://github.com/michalklabnik/claude-sandbox

---

## 3. Claude "autonomně"

**Výhody**
Stačí napojit na GitHub repozitář:
https://claude.ai/code/onboarding
Nebo tagnout `@claude` v PR nebo issue:
https://code.claude.com/docs/en/github-actions

**Nevýhody**
Vyžaduje API klíč.
Pouze pro GitHub repozitáře.

---

## 4. Claude lokálně-vzdáleně

**Výhody**
Ulevím hostovi.
YOLO mód.

**Nevýhody**
Přitíží se peněžence.
Chce to péči.

**Kde pronajmout?**
Vlastní HW.
Kredit v Azure MSDN.
Hetzner https://www.hetzner.com/cloud/. _Zvyšuje ceny https://docs.hetzner.com/general/infrastructure-and-availability/price-adjustment/._
Oracle Cloud Free tier https://www.oracle.com/cloud/free/. _Nedostupné kapacity._

**Jak fungovat?**
Jaká práva dostane, aby to bylo relativně bezpečné?
Jak se k němu připojit, aby to bylo relativně pohodlné?
Jak ho udržovat, aby to bylo relativně stabilní?

---

### 4.1. Poznámky

VM přes OpenTofu/Terraform.
Instalace a nastavení přes Cloud init.
Vzdálené připojení přes Tailscale.
Remote connect přes IntelliJ IDEA.
Claude Agent team a `--allow-dangerously-skip-permissions`.

---

## 5. Doplňkově

Claude Agent tým
https://code.claude.com/docs/en/agent-teams

`/remote-control` od 2.1.52
https://code.claude.com/docs/en/remote-control

Sandbox (MicroVM) E2B
https://e2b.dev/

---

## 6. Pro zábavu

OpenClaw začal mazat inbox ředitelce pro bezpečnost AI v Metě
https://www.root.cz/zpravicky/openclaw-zacal-mazat-inbox-reditelce-pro-bezpecnost-ai-v-mete/

Peonping
https://www.peonping.com/#packs=peasant_cz,peon_cz

