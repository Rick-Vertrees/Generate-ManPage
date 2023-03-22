[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
$OPEN_AI_ORG = <Your Open AI Org ID>
$OPEN_AI_KEY = <Your Open AI Secret Key>
$Uri = "https://api.openai.com/v1/chat/completions"
$contenttype = “application/json”
$Model = "gpt-3.5-turbo"
$Content = Get-Content 'E:\PowerShell\Ops Test\Tif_Counter.ps1'
$Content = "Please create a man page for the below code: `r`n" + $Content

$Header = @{
    Authorization = "Bearer $OPEN_AI_KEY"
    "OpenAI-Organization" = $OPEN_AI_ORG
    }

$Body = @{
    model = $Model
    messages = @(@{
        role = "assistant"
        content = $Content
        }
    )
    temperature = 0.2
    } | ConvertTo-Json

$Response = Invoke-RestMethod -Uri $Uri -Headers $Header -Body $Body -Method Post -ContentType $contenttype
