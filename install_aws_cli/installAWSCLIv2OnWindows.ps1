$aws_cli = "AWSCLIV2.msi"
curl "https://awscli.amazonaws.com/$aws_cli" -o $aws_cli
Start-Process msiexec -ArgumentList "/i $aws_cli /passive" -PassThru -Wait
Remove-Item $aws_cli