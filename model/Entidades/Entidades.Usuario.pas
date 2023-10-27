unit Entidades.Usuario;

interface

type
  TUsuario = class
  private
    FId: Integer;
    FNome: string;
    FValorRenda: Double;
    function GetId: Integer;

  public
    property Id: Integer read GetId write Fid;
    property Nome: string read FNome write FNome;
    property ValorRenda: Double read FValorRenda write FValorRenda;

    constructor Create(const pId: Integer;
                       const pNome: string;
                       const pValorRenda: Double);
  end;

implementation

{ TUsuario }

constructor TUsuario.Create(const pId: Integer; const pNome: string;
  const pValorRenda: Double);
begin
  Id := pId;
  Nome := pNome;
  ValorRenda := pValorRenda;
end;

function TUsuario.GetId: Integer;
begin
  Result := Fid;
end;

end.
