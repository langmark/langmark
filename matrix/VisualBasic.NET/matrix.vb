Imports System
Imports System.Collections.Generic

Module Matrix
    Public Sub Main(args as String())
        Dim print_out As Boolean = False
        If args.Length >= 1 Then
            print_out = True
        End If

        Dim matrix(3, 512, 512) As Integer
        Dim seed As Integer = 42
        Dim sum As Integer = 0

        For i As Integer = 0 To 1
          For j As Integer = 0 To 511
            For k As Integer = 0 To 511
              matrix(i, j, k) = seed
              seed = seed * 25189
              seed = seed Mod 32749
            Next k
          Next j
        Next i

        For i As Integer = 0 To 511
          For j As Integer = 0 To 511
            For k As Integer = 0 To 511
              matrix(2, i, j) = matrix(2, i, j) + matrix(0, i, k) * matrix(1, k, j)
              matrix(2, i, j) = matrix(2, i, j) Mod 65536
            Next k
            sum = sum + ((i*j) Mod 256) * matrix(2, i, j)
            sum = sum Mod 65536
          Next j
        Next i

        If print_out Then
            Console.WriteLine(sum)
        End If
    End Sub
End Module
