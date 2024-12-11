#  .\deploy-dev-mydomain.ps1 `
# -dockerUsername <username> `
# -dockerPassword <password> `
# -dockerEmail <email> `
# -nodeSelectorHostname <node-name> `
# -nodeSelectorNodeGroup <node-group-name>`
# -serviceAccountRole "arn:aws:iam::{{AWS:AccountId}}:role/<iam-role-name>" `
# -tag <specific-tag> `
# -debug $true

param(
  [string] $dockerUsername,
  [string] $dockerPassword,
  [string] $dockerEmail,
  [string] $nodeSelectorHostname,
  [string] $nodeSelectorNodeGroup,
  [string] $serviceAccountRole,
  [string] $route53Region = 'us-east-1',
  [string] $tlsPassword = 'tlsDevPassword',
  [string] $namespace = 'dev',
  [string] $rootDomain = 'mydomain.com',
  [string] $angularDomain = 'dev.mydomain.com',
  [string] $authserverDomain = 'dev-auth.mydomain.com',
  [string] $gatewayDomain = 'dev-gw.mydomain.com',
  [bool] $debug = $false,
  [string] $tag = 'latest'
)

if ($debug -eq $true) {
  helm upgrade --install --debug --dry-run dev MyK8sChart --namespace $namespace --create-namespace -f ./MyK8sChart/values.eks.yaml `
  --set-string secrets.dockerRegcred.username="$dockerUsername" `
  --set-string secrets.dockerRegcred.password="$dockerPassword" `
  --set-string secrets.dockerRegcred.email="$dockerEmail" `
  --set-string secrets.route53creds.tlsPassword="$tlsPassword" `
  --set-string serviceaccount.annotations[0].value=$serviceAccountRole `
  --set-string certmanager.dnsProvider.route53.role=$serviceAccountRole `
  --set-string certmanager.dnsProvider.route53.region="$route53Region" `
  --set-string certmanager.root.commonName="$rootDomain" `
  --set "certmanager.root.dnsNames={`"$rootDomain`",`"*.$rootDomain`"}" `
  --set-string certmanager.angular.commonName="$angularDomain" `
  --set "certmanager.angular.dnsNames={`"$angularDomain`",`"*.$angularDomain`"}" `
  --set-string certmanager.authserver.commonName="$authserverDomain" `
  --set "certmanager.authserver.dnsNames={`"$authserverDomain`",`"*.$authserverDomain`"}" `
  --set-string certmanager.gateway.commonName="$gatewayDomain" `
  --set "certmanager.gateway.dnsNames={`"$gatewayDomain`",`"*.$gatewayDomain`"}" `
  --set-string global.nodeSelector.kubernetes\.io/hostname="$nodeSelectorHostname" `
  --set-string global.nodeSelector.eks\.amazonaws\.com/nodegroup="$nodeSelectorNodeGroup"

  return;
}

helm upgrade --install dev MyK8sChart --namespace $namespace --create-namespace -f ./MyK8sChart/values.eks.yaml `
  --set-string secrets.dockerRegcred.username="$dockerUsername" `
  --set-string secrets.dockerRegcred.password="$dockerPassword" `
  --set-string secrets.dockerRegcred.email="$dockerEmail" `
  --set-string secrets.route53creds.tlsPassword="$tlsPassword" `
  --set-string serviceaccount.annotations[0].value=$serviceAccountRole `
  --set-string certmanager.dnsProvider.route53.role=$serviceAccountRole `
  --set-string certmanager.dnsProvider.route53.region="$route53Region" `
  --set-string certmanager.root.commonName="$rootDomain" `
  --set "certmanager.root.dnsNames={`"$rootDomain`",`"*.$rootDomain`"}" `
  --set-string certmanager.angular.commonName="$angularDomain" `
  --set "certmanager.angular.dnsNames={`"$angularDomain`",`"*.$angularDomain`"}" `
  --set-string certmanager.authserver.commonName="$authserverDomain" `
  --set "certmanager.authserver.dnsNames={`"$authserverDomain`",`"*.$authserverDomain`"}" `
  --set-string certmanager.gateway.commonName="$gatewayDomain" `
  --set "certmanager.gateway.dnsNames={`"$gatewayDomain`",`"*.$gatewayDomain`"}" `
  --set-string global.nodeSelector.kubernetes\.io/hostname="$nodeSelectorHostname" `
  --set-string global.nodeSelector.eks\.amazonaws\.com/nodegroup="$nodeSelectorNodeGroup"
  