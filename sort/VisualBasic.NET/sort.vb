Imports System
Imports System.Collections.Generic

Module Sort
    Public N As Integer = 4194304
    Public Sub Main(args as String())
        Dim print_out As Boolean = False
        If args.Length >= 1 Then
            print_out = True
        End If
        Dim v As List(Of Integer) = New List(Of Integer)
        Dim seed As Integer = 3
        Dim i As Integer
        For i = 0 To N - 1
            v.Add(seed)
            seed *= 27487
            seed = seed mod 30491
        Next
        v.Sort()
        If print_out Then
            Console.WriteLine(v(279121))
        End If
    End Sub
End Module
