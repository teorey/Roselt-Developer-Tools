unit Roselt.CodeFormatting;

interface

uses
  Roselt.Utility,
  System.SysUtils,
  System.Classes,
  System.StrUtils;


//type
//  THTMLAttribute = record
//    Name: String;
//    Value: String;
//  end;
//
//  THTMLElement = class
//    TagName: String;
//    Attributes: array of THTMLAttribute;
//    Children: array of THTMLElement;
//    Parent: THTMLElement;
//  end;

function FormatDelphi(delphi: String): String;
function FormatHTML(html: String): String;
function FormatCSS(css: String): String;
function FormatJavaScript(js: String): String;
function FormatSQL(sql: String; InFormatToDelphi:Boolean; varName:string): TStringList;
function FormatSQLByWord(sql: String; sWord:string): String;
function Occurrences(const Substring, Text: string): integer;
function ReturnPositionsOfAString(const SubStr, s: string): TStringList;

implementation
const
 CRLF = #13#10;

function FormatDelphi(delphi: String): String;
begin

end;

function FormatHTML(html: String): String;
//  Doesn't work yet. Just testing things out.
begin
  html := RemoveEmptyLinesAndWhitespace(html);
  html := html.Replace(#10,'',[rfReplaceAll]).Replace(#13,'',[rfReplaceAll]); 


  html := html.Replace('>','>'+sLineBreak);   
  html := html.Replace('<',sLineBreak+'<'); 
  html := RemoveEmptyLinesAndWhitespace(html);


  var SL := TStringList.Create;
  SL.Text := html;


  for var I := 0 to SL.Count-1 do
  begin
    var ElementTagName := '';
    if (SL[I][1] = '<') and (SL[I][SL[I].Length] = '>') then
    begin
      ElementTagName := SL[I].Substring(1,SL[I].Length-2);
      ElementTagName := RemoveEmptyLinesAndWhitespace(ElementTagName);
    end;

    var fsf := '';
    
  end;
           
  Result := SL.Text;
  SL.Free;
end;

function FormatCSS(css: String): String;
begin

end;

function FormatJavaScript(js: String): String;
begin

end;

function FormatSQL(sql: String; InFormatToDelphi:Boolean; varName:string): TStringList;
var
  lstWords :TStringList;
  curChar : Char;
  iPos, iComma, iCommaPrev:integer;
  lstPositions: TStringList;
  lstResult : TStringList;
begin
  lstResult:=TStringList.Create;
// When From, Where, order --> then insert enter before
  sql := sql.ToUpper;
  lstWords := TStringList.Create;
  lstWords.AddStrings(['FROM', 'JOIN', 'WHERE', 'AND', 'ORDER']);
  for var sWord in lstWords do
  begin
    sql := FormatSQLByWord(sql, sWord);
  end;

  // Formatear comas
  iComma:=sql.IndexOf(',');
  iCommaPrev:=0;
  var numCommas:integer:=0;
  for iPos := 1 to (sql.Length) do
  begin
    if (sql[iPos] = ',') and (sql[iPos+1] <> '''') then
    begin
      if iPos <> iComma then      //Es la segunda ocurrencia
      begin
        iCommaPrev := iComma;
        iComma:=iPos;

        if (iComma - iCommaPrev) > 22 then
        begin
          sql :=sql.Insert(iCommaPrev-1, CRLF);
          numCommas:=0;
        end
        else if numCommas>3 then
        begin
          sql :=sql.Insert(iCommaPrev-1, CRLF);
          numCommas:=0;
        end;
      end;
      if sql[iPos] = ',' then
        Inc(numCommas);
    end;
  end;
  sql :=sql.Insert(iComma-1, CRLF);

  // If Indent to Delphi

  if (InFormatToDelphi=True) then
  begin

    lstPositions := TStringList.Create;
    sql:= sql.Replace('''', '''''');
    lstPositions.Text := sql;

    sql:='';
    var maxStringLength:=0;
    for var s in lstPositions do
    begin
      if s.Length >= maxStringLength then
        maxStringLength := s.Length;
    end;
    var curline:string:='';

    for var s in lstPositions do
    begin
      curLine:= s;

      var curLineLength : integer := curLine.Length;
      curLine:= ''+varName+' := '+varName+' + '''+ curLine + DupeString(' ', maxStringLength - curLineLength) + ''';';
      lstResult.Add(curLine);
    end;

  end
  else
    lstResult.Text:=sql;

  Result := lstResult;
end;

function FormatSQLByWord(sql: String; sWord: string): String;
begin
  sql := sql.Replace(sWord, CRLF+sWord);
  Result := sql;
end;

function Occurrences(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

function ReturnPositionsOfAString(const SubStr, s: string): TStringList;
var
  sResult: TStringList;
  offset: integer;
begin
  try
    sResult:= TStringList.Create;
    offset := PosEx(SubStr, s, 1);
    if offset <> 0 then
      sResult.Add(offset.ToString);

    while offset <> 0 do
    begin
      offset := PosEx(SubStr, s, offset + length(SubStr));
      sResult.Add(offset.ToString);
    end;
  finally
    result := sResult;
  end;

end;

end.
