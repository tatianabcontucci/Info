object dm: Tdm
  OldCreateOrder = False
  Height = 264
  Width = 408
  object cdsCliente: TClientDataSet
    PersistDataPacket.Data = {
      A50100009619E0BD010000001800000010000000000003000000A5010A436F64
      436C69656E74650400010000000000044E6F6D65010049000000010005574944
      5448020002006400025247010049000000010005574944544802000200140003
      4350460100490000000100055749445448020002001400034444440400010000
      0000000874656C65666F6E650100490000000100055749445448020002000F00
      05656D61696C010049000000010005574944544802000200640008656E646572
      65636F0100490000000100055749445448020002006400036365700100490000
      0001000557494454480200020014000A4C6F677261646F75726F010049000000
      0100055749445448020002006400064E756D65726F04000100000000000B436F
      6D706C656D656E746F0100490000000100055749445448020002006400064261
      6972726F01004900000001000557494454480200020064000643696461646501
      004900000001000557494454480200020064000645737461646F010049000000
      0100055749445448020002000200045061697301004900000001000557494454
      480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 56
    object cdsClienteNome: TStringField
      DisplayWidth = 27
      FieldName = 'Nome'
      Size = 100
    end
    object cdsClienteRG: TStringField
      DisplayWidth = 17
      FieldName = 'RG'
    end
    object cdsClienteCPF: TStringField
      DisplayWidth = 19
      FieldName = 'CPF'
    end
    object cdsClienteDDD: TIntegerField
      DisplayWidth = 5
      FieldName = 'DDD'
    end
    object cdsClientetelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 15
      FieldName = 'telefone'
      Size = 15
    end
    object cdsClienteemail: TStringField
      DisplayLabel = 'Email'
      DisplayWidth = 28
      FieldName = 'email'
      Size = 100
    end
    object cdsClienteendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'endereco'
      Size = 100
    end
    object cdsClientecep: TStringField
      DisplayLabel = 'CEP'
      DisplayWidth = 15
      FieldName = 'cep'
    end
    object cdsClienteLogradouro: TStringField
      DisplayWidth = 21
      FieldName = 'Logradouro'
      Size = 100
    end
    object cdsClienteNumero: TIntegerField
      DisplayLabel = 'N'#250'mero'
      DisplayWidth = 8
      FieldName = 'Numero'
    end
    object cdsClienteComplemento: TStringField
      DisplayWidth = 25
      FieldName = 'Complemento'
      Size = 100
    end
    object cdsClienteBairro: TStringField
      DisplayWidth = 21
      FieldName = 'Bairro'
      Size = 100
    end
    object cdsClienteCidade: TStringField
      DisplayWidth = 12
      FieldName = 'Cidade'
      Size = 100
    end
    object cdsClienteEstado: TStringField
      DisplayLabel = 'UF'
      DisplayWidth = 8
      FieldName = 'Estado'
      Size = 2
    end
    object cdsClientePais: TStringField
      DisplayLabel = 'Pa'#237's'
      DisplayWidth = 15
      FieldName = 'Pais'
      Size = 100
    end
  end
  object dscliente: TDataSource
    DataSet = cdsCliente
    Left = 148
    Top = 56
  end
  object dsconfigEmail: TDataSource
    DataSet = cdsConfigEmail
    Left = 112
    Top = 150
  end
  object cdsConfigEmail: TClientDataSet
    PersistDataPacket.Data = {
      770000009619E0BD010000001800000004000000000003000000770007757375
      6172696F01004900000001000557494454480200020032000573656E68610100
      49000000010005574944544802000200320004686F7374010049000000010005
      574944544802000200320005706F72746104000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 115
    object cdsConfigEmailusuario: TStringField
      FieldName = 'usuario'
      Size = 50
    end
    object cdsConfigEmailsenha: TStringField
      FieldName = 'senha'
      Size = 50
    end
    object cdsConfigEmailhost: TStringField
      FieldName = 'host'
      Size = 50
    end
    object cdsConfigEmailporta: TIntegerField
      FieldName = 'porta'
    end
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':465'
    MaxLineAction = maException
    Port = 465
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv2
    SSLOptions.SSLVersions = [sslvSSLv2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 274
    Top = 52
  end
  object IdSMTP1: TIdSMTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Port = 465
    SASLMechanisms = <>
    UseTLS = utUseImplicitTLS
    Left = 304
    Top = 50
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 322
    Top = 50
  end
end
