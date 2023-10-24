unit Entidades.Usuario;

interface

type
  TUsuario = class
  private
    FId: Integer;
    FNome: string;
    FValorRenda: Double;

  public
    property Id: Integer read FId write Fid;
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

end.
