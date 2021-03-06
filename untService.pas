unit untService;

{
  Propriedade Name: "VitorFornazieri_Delphi_Service_Example"
  - ? o nome que ser? registrado em uma chave de registro em HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services
  Propriedade DisplayNames "Vitor Fornazieri Delphi Service Example"
  - ? um nome mais amigavel, que aparece na lista de servi?os do windows


  Instalando o servi?o:
  - ir at? a pasta do exe e executar
  DelphiServiceExample.exe /install

  Desinstalando:
  - rodar o comando
  DelphiServiceExample.exe /uninstall

  Testando o servi?o:
  - abrir os servi?os do windows e "brincar" iniciando, pausando, reiniciando e parando o servi?o
  os eventos ser?o observados no log em c:/

}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TVitorFornazieri_Delphi_Service_Example = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  VitorFornazieri_Delphi_Service_Example: TVitorFornazieri_Delphi_Service_Example;

procedure doSaveLog(msg: String);

implementation

{$R *.dfm}

procedure doSaveLog(msg: String);
var
  vListaLog : TStringList;
  vNomeAqrLog : String;
begin
  try
    vNomeAqrLog := 'logDelphiServiceExample.txt';
    //cria uma lista de strings para armazenar o conteudo em log
    vListaLog := TStringList.Create;
    try
      //verifica se o arquivo de log ja existe
      if FileExists('c:\' + vNomeAqrLog) then
      begin
        vListaLog.LoadFromFile('c:\' + vNomeAqrLog); //carrega o arquivo existente
      end;

      vListaLog.Add(TimeToStr(Now()) + ' : ' + msg);

    except on E:Exception do
      begin
        vListaLog.Add(TimeToStr(Now()) + ' : Erro ' + E.Message);
      end;
    end;
  finally
    //atualiza o log e libera a lista da mem?ria
    vListaLog.SaveToFile('c:\' + vNomeAqrLog);
    vListaLog.Free;
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  VitorFornazieri_Delphi_Service_Example.Controller(CtrlCode);
end;

function TVitorFornazieri_Delphi_Service_Example.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceAfterInstall(
  Sender: TService);
begin
  doSaveLog('AfterInstall');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceAfterUninstall(
  Sender: TService);
begin
  doSaveLog('AfterUninstall');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceBeforeInstall(
  Sender: TService);
begin
  doSaveLog('BeforeInstall');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceBeforeUninstall(
  Sender: TService);
begin
  doSaveLog('BeforeUninstall');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceContinue(
  Sender: TService; var Continued: Boolean);
begin
  doSaveLog('Continue');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceCreate(
  Sender: TObject);
begin
  doSaveLog('Create');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceDestroy(
  Sender: TObject);
begin
  doSaveLog('Destroy');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceExecute(
  Sender: TService);
begin
  doSaveLog('Execute');
  while not self.Terminated do
    ServiceThread.ProcessRequests(true);
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServicePause(Sender: TService;
  var Paused: Boolean);
begin
  doSaveLog('Pause');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceShutdown(
  Sender: TService);
begin
  doSaveLog('Shutdown');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  doSaveLog('Start');
end;

procedure TVitorFornazieri_Delphi_Service_Example.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin
  doSaveLog('Stop');
end;

end.
