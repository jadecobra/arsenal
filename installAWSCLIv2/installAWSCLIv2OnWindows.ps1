$aws_cli = "AWSCLIV2.msi"
curl "https://awscli.amazonaws.com/$aws_cli" -o $aws_cli
msiexec /i $aws_cli
Remove-Item $aws_cli