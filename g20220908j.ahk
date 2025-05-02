#Requires AutoHotkey v2.0

; グローバル変数
global prevInput := ""  ; 前回の入力を保持
global shiftKeys := "eiosf"  ; 後置シフトキー
global escPressed := false  ; ESCが押されたかどうか

; キーマッピング
global keyMap := Map(
    "q", "ー",
    "w", "か",
    "e", "ゃ",
    "r", "く",
    "t", "ま",
    "y", "ヴ",
    "u", "が",
    "i", "ぃ",
    "o", "ぇ",
    "p", "む",
    "@", "ふ",  ; [@] キーに変更
    "a", "し",
    "s", "ょ",
    "d", "う",
    "f", "ゅ",
    "g", "、",
    "h", "て",
    "j", "た",
    "k", "い",
    "l", "ん",
    ";", "に",
    ":", "こ",  ; [:] キーに変更
    "z", "き",
    "x", "で",
    "c", "は",
    "v", "の",
    "b", "け",
    "n", "な",
    "m", "と",
    ",", "す",
    ".", "。",
    "/", "っ",
    "qi", "ぢ",
    "wi", "ご",
    "ri", "ぽ",
    "ti", "ぴ",
    "yi", "ヴぃ",
    "ui", "つぃ",
    "pi", "ぞ",
    "@i", "ふぃ",  ; [@i] に変更
    "ai", "ね",
    "di", "うぃ",
    "gi", "ぺ",
    "hi", "てぃ",
    "ji", "り",
    "li", "ゆ",
    ";i", "げ",
    ":i", "ち",  ; [:i] に変更
    "zi", "づ",
    "xi", "でぃ",
    "vi", "ど",
    "bi", "ぃ",
    "ni", "じ",
    "mi", "そ",
    ".i", "ひ",
    "/i", "み",
    "wo", "め",
    "ro", "ぬ",
    "yo", "ヴぇ",
    "uo", "つぇ",
    "po", "ぎ",
    "@o", "ふぇ",  ; [@o] に変更
    "ao", "しぇ",
    "do", "うぇ",
    "go", "わ",
    "ho", "ぼ",
    "jo", "れ",
    "ko", "いぇ",
    ";o", "ら",
    ":o", "ちぇ",  ; [:o] に変更
    "co", "へ",
    "vo", "あ",
    "bo", "ぇ",
    "no", "じぇ",
    "mo", "ろ",
    ",o", "び",
    "qe", "ぢゃ",
    "we", "る",
    "re", "ぶ",
    "te", "ぴゃ",
    "ye", "ヴぁ",
    "ue", "つぁ",
    "pe", "ぎゃ",
    "@e", "ふぁ",  ; [@e] に変更
    "ae", "しゃ",
    "de", "ゃ",
    "he", "せ",
    "je", "りゃ",
    "ke", "ぱ",
    "le", "や",
    ";e", "にゃ",
    ":e", "ちゃ",  ; [:e] に変更
    "ze", "きゃ",
    "xe", "ゎ",
    "ve", "ぐ",
    "be", "ぁ",
    "ne", "じゃ",
    "me", "さ",
    ",e", "びゃ",
    ".e", "ひゃ",
    "/e", "みゃ",
    "qf", "ぢゅ",
    "wf", "え",
    "rf", "ゅ",
    "tf", "ぴゅ",
    "yf", "ヴゅ",
    "uf", "つ",
    "pf", "ぎゅ",
    "@f", "ふゅ",  ; [@f] に変更
    "af", "しゅ",
    "df", "お",
    "hf", "てゅ",
    "jf", "りゅ",
    "kf", "ず",
    "lf", "よ",
    ";f", "にゅ",
    ":f", "ちゅ",  ; [:f] に変更
    "zf", "きゅ",
    "xf", "でゅ",
    "cf", "ざ",
    "vf", "どぅ",
    "bf", "ぅ",
    "nf", "じゅ",
    "mf", "とぅ",
    ",f", "びゅ",
    ".f", "ひゅ",
    "/f", "みゅ",
    "qs", "ぢょ",
    "ws", "ょ",
    "rs", "べ",
    "ts", "ぴょ",
    "ys", "ヴぉ",
    "us", "つぉ",
    "ps", "ぎょ",
    "@s", "ふぉ",  ; [@s] に変更
    "as", "しょ",
    "ds", "うぉ",
    "gs", "ぜ",
    "hs", "だ",
    "js", "りょ",
    "ks", "ほ",
    "ls", "も",
    ";s", "にょ",
    ":s", "ちょ",  ; [:s] に変更
    "zs", "きょ",
    "cs", "ぷ",
    "vs", "ば",
    "bs", "ぉ",
    "ns", "じょ",
    "ms", "を",
    ",s", "びょ",
    ".s", "ひょ",
    "/s", "みょ",
    "2i", "!",
    "3i", "?",
    "4i", "・",
    "8e", "「",
    "9e", "(",
    "0e", ")",
    "^e", "」"  ; [^e] に変更
)

; かな→ローマ字変換マップ
global hiraganaToRomaji := Map(
    "あ", "a", "い", "i", "う", "u", "え", "e", "お", "o",
    "か", "ka", "き", "ki", "く", "ku", "け", "ke", "こ", "ko",
    "が", "ga", "ぎ", "gi", "ぐ", "gu", "げ", "ge", "ご", "go",
    "さ", "sa", "し", "si", "す", "su", "せ", "se", "そ", "so",
    "ざ", "za", "じ", "ji", "ず", "zu", "ぜ", "ze", "ぞ", "zo",
    "た", "ta", "ち", "ti", "つ", "tu", "て", "te", "と", "to",
    "だ", "da", "ぢ", "di", "づ", "du", "で", "de", "ど", "do",
    "な", "na", "に", "ni", "ぬ", "nu", "ね", "ne", "の", "no",
    "は", "ha", "ひ", "hi", "ふ", "hu", "へ", "he", "ほ", "ho",
    "ば", "ba", "び", "bi", "ぶ", "bu", "べ", "be", "ぼ", "bo",
    "ぱ", "pa", "ぴ", "pi", "ぷ", "pu", "ぺ", "pe", "ぽ", "po",
    "ま", "ma", "み", "mi", "む", "mu", "め", "me", "も", "mo",
    "や", "ya", "ゆ", "yu", "よ", "yo",
    "ら", "ra", "り", "ri", "る", "ru", "れ", "re", "ろ", "ro",
    "わ", "wa", "を", "wo",
    "ん", "xn",
    "ゃ", "xya", "ゅ", "xyu", "ょ", "xyo",
    "ぁ", "la", "ぃ", "xi", "ぅ", "xu", "ぇ", "le", "ぉ", "xo",
    "ゔ", "vu",
    "ー", "-", "、", ",", "。", ".",
    ; 以下、拗音・外来音の専用ローマ字
    "きゃ", "kya", "きゅ", "kyu", "きょ", "kyo",
    "ぎゃ", "gya", "ぎゅ", "gyu", "ぎょ", "gyo",
    "しゃ", "sha", "しゅ", "shu", "しぇ", "she", "しょ", "sho",
    "じゃ", "ja", "じゅ", "ju", "じぇ", "je", "じょ", "jo",
    "ちゃ", "cha", "ちゅ", "chu", "ちぇ", "che", "ちょ", "cho",
    "ぢゃ", "dya", "ぢゅ", "dyu", "ぢょ", "dyo",
    "にゃ", "nya", "にゅ", "nyu", "にょ", "nyo",
    "ひゃ", "hya", "ひゅ", "hyu", "ひょ", "hyo",
    "びゃ", "bya", "びゅ", "byu", "びょ", "byo",
    "ぴゃ", "pya", "ぴゅ", "pyu", "ぴょ", "pyo",
    "みゃ", "mya", "みゅ", "myu", "みょ", "myo",
    "りゃ", "rya", "りゅ", "ryu", "りょ", "ryo",
    "うぃ", "wi", "うぇ", "we", "うぉ", "who",
    "ヴぁ", "va", "ヴぃ", "vi", "ヴゅ", "vyu", "ヴぇ", "ve", "ヴぉ", "vo",
    "つぁ", "tsa", "つぃ", "tsi", "つぇ", "tse", "つぉ", "tso",
    "ふぁ", "fa", "ふぃ", "fi", "ふゅ", "fyu", "ふぇ", "fe", "ふぉ", "fo",
    "てぃ", "thi", "でぃ", "dhi",
    "てゅ", "thu", "でゅ", "dhu",
    "とぅ", "twu", "どぅ", "dwu"
)

; 子音を抽出する関数
getConsonant(romaji) {
    if !romaji
        return ""
    ; 最初の文字が母音なら空文字を返す
    if InStr("aeiou", SubStr(romaji, 1, 1))
        return ""
    ; 特殊な変換規則
    if SubStr(romaji, 1, 2) = "ch"
        return "ch"
    if SubStr(romaji, 1, 2) = "sh"
        return "sh"
    if SubStr(romaji, 1, 2) = "th"
        return "th"
    if SubStr(romaji, 1, 2) = "dh"
        return "dh"
    ; それ以外は最初の子音を返す
    return SubStr(romaji, 1, 1)
}

; 入力を確定して出力する
outputConfirmed(kana, isSpace := false) {
    static previousKana := ""
    if kana {
        romaji := hiraganaToRomaji.Get(kana, kana)
        
        ; スペースで確定する場合
        if isSpace && kana = "っ" {
            SendText("ltu")
            previousKana := ""
            return
        }
        
        ; 前の文字が「っ」で、現在の文字が「っ」でない場合
        if previousKana = "っ" && kana != "っ" {
            consonant := getConsonant(romaji)
            if consonant
                SendText(consonant)  ; 子音を重ねる
        }
        
        if kana != "っ"  ; 「っ」以外の文字を出力
            SendText(romaji)
            
        previousKana := kana
    }
}

; キー入力の処理
handleInput(key) {
    global prevInput, escPressed

    if key = " " {
        ; ESC後のスペースは通常のスペースとして出力
        if escPressed {
            SendText(" ")
            escPressed := false
            return false
        }

        ; スペースが押されたとき、待機中の入力があれば確定
        if prevInput && keyMap.Has(prevInput) {
            outputConfirmed(keyMap[prevInput], true)
            prevInput := ""
        }
        return false
    }

    if !prevInput {
        ; 最初の入力
        if InStr(shiftKeys, key) {
            return false  ; シフトキーは単独では無視
        }
        prevInput := key
        return false
    }

    ; シフトキーの場合
    if InStr(shiftKeys, key) {
        combination := prevInput key
        if keyMap.Has(combination) {
            outputConfirmed(keyMap[combination])
        }
        prevInput := ""
        return false
    }

    ; 通常キーの場合
    newCombination := prevInput key
    if keyMap.Has(newCombination) {
        ; 新しい組み合わせが存在する場合は待機
        prevInput := newCombination
    } else {
        ; 前の入力を確定させて新しい入力を保持
        if keyMap.Has(prevInput) {
            outputConfirmed(keyMap[prevInput])
        }
        prevInput := key
    }
    return false
}

; キーバインディング
#HotIf true
    ; ESCキーの処理
    Escape::
    {
        global escPressed := true
        return false
    }

    Space::handleInput(" ")
    a::handleInput("a")
    b::handleInput("b")
    c::handleInput("c")
    d::handleInput("d")
    e::handleInput("e")
    f::handleInput("f")
    g::handleInput("g")
    h::handleInput("h")
    i::handleInput("i")
    j::handleInput("j")
    k::handleInput("k")
    l::handleInput("l")
    m::handleInput("m")
    n::handleInput("n")
    o::handleInput("o")
    p::handleInput("p")
    q::handleInput("q")
    r::handleInput("r")
    s::handleInput("s")
    t::handleInput("t")
    u::handleInput("u")
    v::handleInput("v")
    w::handleInput("w")
    x::handleInput("x")
    y::handleInput("y")
    z::handleInput("z")
    @::handleInput("@")    ; [@] キーに変更
    `;::handleInput(";")
    :::handleInput(":")    ; [:] キーに変更
    ,::handleInput(",")
    .::handleInput(".")
    /::handleInput("/")
    2::handleInput("2")
    3::handleInput("3")
    4::handleInput("4")
    8::handleInput("8")
    9::handleInput("9")
    0::handleInput("0")
    ^::handleInput("^")    ; [^] キーに変更
#HotIf