# Microsoft Sentinel Detection-as-Code & SOAR Lab

Ein praxisnahes Cloud-Security-Projekt zum Aufbau einer reproduzierbaren SIEM- und SOAR-Infrastruktur auf Microsoft Azure mittels Terraform und GitHub Actions.

---

## Architektur- & Design-Entscheidungen

### 1. Secretless CI/CD via OpenID Connect (OIDC)
Ich habe mich bewusst gegen klassische Client Secrets in GitHub entschieden. Mit OIDC (OpenID Connect) entfällt das Risiko, statische Credentials beim Development oder Deployment versehentlich im Code oder in Pipeline-Logs zu leaken. Azure verifiziert kryptografisch direkt die Identität des GitHub-Token-Herausgebers.

### 2. Least-Privilege & Blast-Radius-Kontrolle
Die CI/CD-Pipeline arbeitet strikt nach dem Least-Privilege-Prinzip:
- Der Service Principal besitzt lediglich die **Contributor-Rolle auf Ebene der Ziel-Ressourcengruppe (`rg-sentinel-dac-lab`)**.
- Berechtigungen auf Subscription- oder Tenant-Ebene wurden bewusst verweigert.
- **Ziel:** Sollte die Pipeline kompromittiert werden oder fehlerhafter Code gepusht werden, bleibt der Schaden rein auf das isolierte Lab begrenzt (Blast Radius Minimierung).

### 3. FinOps & Kostenkontrolle (Zweistufiges Schutznetz)
Um die Kosten im Blick zu behalten und Überraschungen zu vermeiden, ist ein zweistufiges Schutznetz aktiv:
1. **Azure Cost Management Alerts:** Mehrere Budgets/Warnschwellen informieren per E-Mail über den tatsächlichen Verbrauch. Auf Forecast-Warnungen habe ich bewusst verzichtet, um Alert Fatigue zu vermeiden.
2. **Log Analytics Daily Cap:** In Terraform ist ein hartes Ingestion-Cap von **0.5 GB / Tag** konfiguriert. Selbst bei Datenüberflutung stoppt Azure automatisch die Aufnahme, bevor unkontrollierte Ingestion-Kosten entstehen.