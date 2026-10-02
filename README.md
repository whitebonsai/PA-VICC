# Secure Remote Access Gateway (Azure)

Praxisarbeit VICC: WireGuard-VPN mit Web-Verwaltung (wg-easy) auf zwei Azure-VMs, Failover über Azure Traffic Manager. Die Infrastruktur ist mit OpenTofu beschrieben.

## Voraussetzungen

- Azure-Subscription
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- [OpenTofu](https://opentofu.org/docs/intro/install/)
- SSH-Schlüsselpaar

## Deployment

1. Bei Azure anmelden:

   ```bash
   az login
   ```

2. Ressourcenanbieter registrieren (einmalig pro Subscription):

   ```bash
   az provider register --namespace Microsoft.Compute
   az provider register --namespace Microsoft.Network
   az provider register --namespace Microsoft.Storage
   az provider register --namespace Microsoft.KeyVault
   az provider register --namespace Microsoft.OperationalInsights
   az provider register --namespace Microsoft.Insights
   ```

3. Variablen anlegen:

   ```bash
   cd terraform
   cp terraform.tfvars.example terraform.tfvars
   ```

   Danach `terraform.tfvars` mit eigenen Werten ausfüllen.

4. Deployen:

   ```bash
   tofu init
   tofu plan
   tofu apply
   ```

   Das dauert etwa 10 bis 20 Minuten. Nach dem Apply braucht Cloud-Init auf den VMs noch einige Minuten, bis wg-easy läuft.

## Nutzung

```bash
tofu output
```

zeigt unter anderem den Traffic-Manager-Namen. Die Web-Oberfläche ist danach unter `http://<traffic_manager_fqdn>:51821` erreichbar (nur von den IP-Adressen in `admin_ip`). Clients werden nur auf VM1 angelegt und alle 5 Minuten auf VM2 synchronisiert.

## Aufräumen

```bash
tofu destroy
```
