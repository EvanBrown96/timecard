module TimerGroup exposing (..)
import Bootstrap.Tab as Tab
import Maybe

type alias TimerGroup =
  { name : String
  , id   : String
  }

preserveSpecial : List Char
preserveSpecial = ['-', '_', ':', '.']

idReplace : Char -> Maybe Char
idReplace char =
  if Char.isAlphaNum char
    then Just char
  else if char == ' '
    then Just '_'
  else if List.member char preserveSpecial
    then Just char
  else
    Nothing

dropWhile : (Char -> Bool) -> String -> String
dropWhile test string =
  String.foldl
    (\char (found, result) ->
        if found || (not << test) char then
          (True, result ++ String.fromChar char)
        else
          (False, "")
    )
    (False, "")
    string
    |> Tuple.second

getHtmlId : String -> Maybe String
getHtmlId string =
  let
    droppedString : String
    droppedString =
      dropWhile (not << Char.isAlpha) string
  in
  case String.uncons droppedString of
    Nothing ->
      Nothing
    Just (first, rest) ->
      let
        restStr : String
        restStr =
          String.foldr
            (\char acc ->
                case idReplace char of
                  Nothing ->
                    acc
                  Just newChar ->
                    String.cons newChar acc
            )
            ""
            rest
      in
      Just <| String.cons first restStr
