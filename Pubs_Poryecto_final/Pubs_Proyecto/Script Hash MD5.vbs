'##################################################
' Script para realizar un Hash MD5 de múltiples
' columnas en almacenarlo en una columna
'##################################################


''' Copiar y pegar en las importaciones
Imports Microsoft.SqlServer.Dts.Pipeline
Imports System.Text
Imports System.Security.Cryptography

''' Copiar y pegar en los nuevos métodos requeridos para realizar el hash MD5
Private inputBuffer As PipelineBuffer

Public Overrides Sub ProcessInput(ByVal InputID As Integer, ByVal Buffer As Microsoft.SqlServer.Dts.Pipeline.PipelineBuffer)

	inputBuffer = Buffer
        
	MyBase.ProcessInput(InputID, Buffer)
    
End Sub

Public Shared Function CreateHash(ByVal data As String) As String
	Dim dataToHash As Byte() = (New UnicodeEncoding()).GetBytes(data)
	Dim md5 As MD5 = New MD5CryptoServiceProvider()
	Dim hashedData As Byte() = md5.ComputeHash(dataToHash)
	RNGCryptoServiceProvider.Create().GetBytes(dataToHash)
	Dim s As String = Convert.ToBase64String(hashedData, Base64FormattingOptions.None)
	Return s
End Function

''' Copiar y pegar dentro de la funcionalidad del usuario
Dim counter As Integer = 0
Dim values As New StringBuilder
For counter = 0 To inputBuffer.ColumnCount - 1
Dim value As Object
value = inputBuffer.Item(counter)
values.Append(value)
Next
	
''' Recuerda cambiar el nombre de la columna que almacenará el valor
Row.StageMD5 = CreateHash(values.ToString())