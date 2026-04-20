import SwiftUI

extension Color {
    // Base
    public static let black = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    public static let white = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    public static let primaryColor = UIColor(hex: "#ffe700ff")
    public static let secondaryColor = UIColor(hex: "#ffe700ff")
    public static let secoColor = UIColor(hex: "#ffe700ff")

    // Slate
    public static let slate50 = Color(UIColor(red: 248/255, green: 250/255, blue: 252/255, alpha: 1))
    public static let slate100 = Color(UIColor(red: 241/255, green: 245/255, blue: 249/255, alpha: 1))
    public static let slate200 = Color(UIColor(red: 226/255, green: 232/255, blue: 240/255, alpha: 1))
    public static let slate300 = Color(UIColor(red: 203/255, green: 213/255, blue: 225/255, alpha: 1))
    public static let slate400 = Color(UIColor(red: 148/255, green: 163/255, blue: 184/255, alpha: 1))
    public static let slate500 = Color(UIColor(red: 100/255, green: 116/255, blue: 139/255, alpha: 1))
    public static let slate600 = Color(UIColor(red: 71/255, green: 85/255, blue: 105/255, alpha: 1))
    public static let slate700 = Color(UIColor(red: 51/255, green: 65/255, blue: 81/255, alpha: 1))
    public static let slate800 = Color(UIColor(red: 30/255, green: 41/255, blue: 59/255, alpha: 1))
    public static let slate900 = Color(UIColor(red: 15/255, green: 23/255, blue: 42/255, alpha: 1))
    public static let slate950 = Color(UIColor(red: 2/255, green: 6/255, blue: 23/255, alpha: 1))

    // Gray
    public static let gray50 = Color(UIColor(red: 249/255, green: 250/255, blue: 251/255, alpha: 1))
    public static let gray100 = Color(UIColor(red: 243/255, green: 244/255, blue: 246/255, alpha: 1))
    public static let gray200 = Color(UIColor(red: 229/255, green: 231/255, blue: 235/255, alpha: 1))
    public static let gray300 = Color(UIColor(red: 209/255, green: 213/255, blue: 219/255, alpha: 1))
    public static let gray400 = Color(UIColor(red: 156/255, green: 163/255, blue: 175/255, alpha: 1))
    public static let gray500 = Color(UIColor(red: 107/255, green: 114/255, blue: 128/255, alpha: 1))
    public static let gray600 = Color(UIColor(red: 75/255, green: 85/255, blue: 99/255, alpha: 1))
    public static let gray700 = Color(UIColor(red: 55/255, green: 65/255, blue: 81/255, alpha: 1))
    public static let gray800 = Color(UIColor(red: 31/255, green: 41/255, blue: 55/255, alpha: 1))
    public static let gray900 = Color(UIColor(red: 17/255, green: 24/255, blue: 39/255, alpha: 1))
    public static let gray950 = Color(UIColor(red: 3/255, green: 7/255, blue: 18/255, alpha: 1))

    // Zinc
    public static let zinc50 = Color(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
    public static let zinc100 = Color(UIColor(red: 244/255, green: 244/255, blue: 245/255, alpha: 1))
    public static let zinc200 = Color(UIColor(red: 228/255, green: 228/255, blue: 231/255, alpha: 1))
    public static let zinc300 = Color(UIColor(red: 212/255, green: 212/255, blue: 216/255, alpha: 1))
    public static let zinc400 = Color(UIColor(red: 161/255, green: 161/255, blue: 170/255, alpha: 1))
    public static let zinc500 = Color(UIColor(red: 113/255, green: 113/255, blue: 122/255, alpha: 1))
    public static let zinc600 = Color(UIColor(red: 82/255, green: 82/255, blue: 91/255, alpha: 1))
    public static let zinc700 = Color(UIColor(red: 63/255, green: 63/255, blue: 70/255, alpha: 1))
    public static let zinc800 = Color(UIColor(red: 39/255, green: 39/255, blue: 42/255, alpha: 1))
    public static let zinc900 = Color(UIColor(red: 24/255, green: 24/255, blue: 27/255, alpha: 1))
    public static let zinc950 = Color(UIColor(red: 9/255, green: 9/255, blue: 11/255, alpha: 1))

    // Neutral
    public static let neutral50 = Color(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1))
    public static let neutral100 = Color(UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1))
    public static let neutral200 = Color(UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1))
    public static let neutral300 = Color(UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1))
    public static let neutral400 = Color(UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1))
    public static let neutral500 = Color(UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1))
    public static let neutral600 = Color(UIColor(red: 82/255, green: 82/255, blue: 82/255, alpha: 1))
    public static let neutral700 = Color(UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1))
    public static let neutral800 = Color(UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1))
    public static let neutral900 = Color(UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1))
    public static let neutral950 = Color(UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1))

    // Stone
    public static let stone50 = Color(UIColor(red: 250/255, green: 250/255, blue: 249/255, alpha: 1))
    public static let stone100 = Color(UIColor(red: 245/255, green: 245/255, blue: 244/255, alpha: 1))
    public static let stone200 = Color(UIColor(red: 231/255, green: 229/255, blue: 228/255, alpha: 1))
    public static let stone300 = Color(UIColor(red: 211/255, green: 211/255, blue: 209/255, alpha: 1))
    public static let stone400 = Color(UIColor(red: 162/255, green: 162/255, blue: 158/255, alpha: 1))
    public static let stone500 = Color(UIColor(red: 120/255, green: 113/255, blue: 108/255, alpha: 1))
    public static let stone600 = Color(UIColor(red: 87/255, green: 83/255, blue: 78/255, alpha: 1))
    public static let stone700 = Color(UIColor(red: 68/255, green: 64/255, blue: 60/255, alpha: 1))
    public static let stone800 = Color(UIColor(red: 41/255, green: 37/255, blue: 36/255, alpha: 1))
    public static let stone900 = Color(UIColor(red: 28/255, green: 25/255, blue: 23/255, alpha: 1))
    public static let stone950 = Color(UIColor(red: 12/255, green: 10/255, blue: 9/255, alpha: 1))

    // Red
    public static let red50 = Color(UIColor(red: 254/255, green: 242/255, blue: 242/255, alpha: 1))
    public static let red100 = Color(UIColor(red: 254/255, green: 226/255, blue: 226/255, alpha: 1))
    public static let red200 = Color(UIColor(red: 254/255, green: 202/255, blue: 202/255, alpha: 1))
    public static let red300 = Color(UIColor(red: 252/255, green: 165/255, blue: 165/255, alpha: 1))
    public static let red400 = Color(UIColor(red: 248/255, green: 113/255, blue: 113/255, alpha: 1))
    public static let red500 = Color(UIColor(red: 239/255, green: 68/255, blue: 68/255, alpha: 1))
    public static let red600 = Color(UIColor(red: 220/255, green: 38/255, blue: 38/255, alpha: 1))
    public static let red700 = Color(UIColor(red: 185/255, green: 28/255, blue: 28/255, alpha: 1))
    public static let red800 = Color(UIColor(red: 153/255, green: 27/255, blue: 27/255, alpha: 1))
    public static let red900 = Color(UIColor(red: 127/255, green: 29/255, blue: 29/255, alpha: 1))
    public static let red950 = Color(UIColor(red: 69/255, green: 10/255, blue: 10/255, alpha: 1))

    // Orange
    public static let orange50 = Color(UIColor(red: 255/255, green: 247/255, blue: 237/255, alpha: 1))
    public static let orange100 = Color(UIColor(red: 255/255, green: 237/255, blue: 213/255, alpha: 1))
    public static let orange200 = Color(UIColor(red: 254/255, green: 215/255, blue: 170/255, alpha: 1))
    public static let orange300 = Color(UIColor(red: 253/255, green: 186/255, blue: 116/255, alpha: 1))
    public static let orange400 = Color(UIColor(red: 251/255, green: 146/255, blue: 74/255, alpha: 1))
    public static let orange500 = Color(UIColor(red: 249/255, green: 115/255, blue: 22/255, alpha: 1))
    public static let orange600 = Color(UIColor(red: 234/255, green: 88/255, blue: 12/255, alpha: 1))
    public static let orange700 = Color(UIColor(red: 194/255, green: 64/255, blue: 12/255, alpha: 1))
    public static let orange800 = Color(UIColor(red: 154/255, green: 52/255, blue: 12/255, alpha: 1))
    public static let orange900 = Color(UIColor(red: 124/255, green: 45/255, blue: 12/255, alpha: 1))
    public static let orange950 = Color(UIColor(red: 67/255, green: 20/255, blue: 7/255, alpha: 1))

    // Amber
    public static let amber50 = Color(UIColor(red: 255/255, green: 251/255, blue: 235/255, alpha: 1))
    public static let amber100 = Color(UIColor(red: 254/255, green: 243/255, blue: 199/255, alpha: 1))
    public static let amber200 = Color(UIColor(red: 254/255, green: 230/255, blue: 153/255, alpha: 1))
    public static let amber300 = Color(UIColor(red: 253/255, green: 211/255, blue: 91/255, alpha: 1))
    public static let amber400 = Color(UIColor(red: 251/255, green: 191/255, blue: 36/255, alpha: 1))
    public static let amber500 = Color(UIColor(red: 245/255, green: 158/255, blue: 11/255, alpha: 1))
    public static let amber600 = Color(UIColor(red: 217/255, green: 119/255, blue: 6/255, alpha: 1))
    public static let amber700 = Color(UIColor(red: 180/255, green: 83/255, blue: 9/255, alpha: 1))
    public static let amber800 = Color(UIColor(red: 146/255, green: 64/255, blue: 14/255, alpha: 1))
    public static let amber900 = Color(UIColor(red: 120/255, green: 53/255, blue: 15/255, alpha: 1))
    public static let amber950 = Color(UIColor(red: 69/255, green: 26/255, blue: 8/255, alpha: 1))

    // Yellow
    public static let yellow50 = Color(UIColor(red: 254/255, green: 252/255, blue: 232/255, alpha: 1))
    public static let yellow100 = Color(UIColor(red: 254/255, green: 249/255, blue: 195/255, alpha: 1))
    public static let yellow200 = Color(UIColor(red: 254/255, green: 242/255, blue: 130/255, alpha: 1))
    public static let yellow300 = Color(UIColor(red: 254/255, green: 230/255, blue: 61/255, alpha: 1))
    public static let yellow400 = Color(UIColor(red: 253/255, green: 211/255, blue: 13/255, alpha: 1))
    public static let yellow500 = Color(UIColor(red: 234/255, green: 181/255, blue: 4/255, alpha: 1))
    public static let yellow600 = Color(UIColor(red: 193/255, green: 143/255, blue: 0/255, alpha: 1))
    public static let yellow700 = Color(UIColor(red: 158/255, green: 100/255, blue: 3/255, alpha: 1))
    public static let yellow800 = Color(UIColor(red: 126/255, green: 86/255, blue: 3/255, alpha: 1))
    public static let yellow900 = Color(UIColor(red: 99/255, green: 81/255, blue: 5/255, alpha: 1))
    public static let yellow950 = Color(UIColor(red: 66/255, green: 48/255, blue: 2/255, alpha: 1))

    // Lime
    public static let lime50 = Color(UIColor(red: 247/255, green: 254/255, blue: 231/255, alpha: 1))
    public static let lime100 = Color(UIColor(red: 240/255, green: 254/255, blue: 208/255, alpha: 1))
    public static let lime200 = Color(UIColor(red: 223/255, green: 252/255, blue: 175/255, alpha: 1))
    public static let lime300 = Color(UIColor(red: 198/255, green: 247/255, blue: 120/255, alpha: 1))
    public static let lime400 = Color(UIColor(red: 174/255, green: 239/255, blue: 56/255, alpha: 1))
    public static let lime500 = Color(UIColor(red: 140/255, green: 219/255, blue: 15/255, alpha: 1))
    public static let lime600 = Color(UIColor(red: 107/255, green: 185/255, blue: 13/255, alpha: 1))
    public static let lime700 = Color(UIColor(red: 78/255, green: 154/255, blue: 6/255, alpha: 1))
    public static let lime800 = Color(UIColor(red: 62/255, green: 125/255, blue: 3/255, alpha: 1))
    public static let lime900 = Color(UIColor(red: 52/255, green: 101/255, blue: 3/255, alpha: 1))
    public static let lime950 = Color(UIColor(red: 26/255, green: 69/255, blue: 2/255, alpha: 1))

    // Green
    public static let green50 = Color(UIColor(red: 240/255, green: 253/255, blue: 244/255, alpha: 1))
    public static let green100 = Color(UIColor(red: 220/255, green: 252/255, blue: 231/255, alpha: 1))
    public static let green200 = Color(UIColor(red: 187/255, green: 245/255, blue: 201/255, alpha: 1))
    public static let green300 = Color(UIColor(red: 134/255, green: 239/255, blue: 163/255, alpha: 1))
    public static let green400 = Color(UIColor(red: 77/255, green: 222/255, blue: 108/255, alpha: 1))
    public static let green500 = Color(UIColor(red: 34/255, green: 197/255, blue: 94/255, alpha: 1))
    public static let green600 = Color(UIColor(red: 22/255, green: 160/255, blue: 76/255, alpha: 1))
    public static let green700 = Color(UIColor(red: 21/255, green: 128/255, blue: 61/255, alpha: 1))
    public static let green800 = Color(UIColor(red: 22/255, green: 102/255, blue: 49/255, alpha: 1))
    public static let green900 = Color(UIColor(red: 20/255, green: 83/255, blue: 39/255, alpha: 1))
    public static let green950 = Color(UIColor(red: 5/255, green: 46/255, blue: 22/255, alpha: 1))

    // Emerald
    public static let emerald50 = Color(UIColor(red: 236/255, green: 253/255, blue: 245/255, alpha: 1))
    public static let emerald100 = Color(UIColor(red: 209/255, green: 250/255, blue: 229/255, alpha: 1))
    public static let emerald200 = Color(UIColor(red: 167/255, green: 243/255, blue: 208/255, alpha: 1))
    public static let emerald300 = Color(UIColor(red: 110/255, green: 235/255, blue: 183/255, alpha: 1))
    public static let emerald400 = Color(UIColor(red: 52/255, green: 211/255, blue: 153/255, alpha: 1))
    public static let emerald500 = Color(UIColor(red: 16/255, green: 185/255, blue: 129/255, alpha: 1))
    public static let emerald600 = Color(UIColor(red: 6/255, green: 147/255, blue: 106/255, alpha: 1))
    public static let emerald700 = Color(UIColor(red: 4/255, green: 120/255, blue: 87/255, alpha: 1))
    public static let emerald800 = Color(UIColor(red: 6/255, green: 95/255, blue: 70/255, alpha: 1))
    public static let emerald900 = Color(UIColor(red: 3/255, green: 77/255, blue: 56/255, alpha: 1))
    public static let emerald950 = Color(UIColor(red: 2/255, green: 44/255, blue: 32/255, alpha: 1))

    // Teal
    public static let teal50 = Color(UIColor(red: 239/255, green: 252/255, blue: 255/255, alpha: 1))
    public static let teal100 = Color(UIColor(red: 204/255, green: 253/255, blue: 255/255, alpha: 1))
    public static let teal200 = Color(UIColor(red: 148/255, green: 250/255, blue: 255/255, alpha: 1))
    public static let teal300 = Color(UIColor(red: 77/255, green: 245/255, blue: 255/255, alpha: 1))
    public static let teal400 = Color(UIColor(red: 36/255, green: 229/255, blue: 239/255, alpha: 1))
    public static let teal500 = Color(UIColor(red: 14/255, green: 192/255, blue: 205/255, alpha: 1))
    public static let teal600 = Color(UIColor(red: 9/255, green: 145/255, blue: 171/255, alpha: 1))
    public static let teal700 = Color(UIColor(red: 8/255, green: 118/255, blue: 144/255, alpha: 1))
    public static let teal800 = Color(UIColor(red: 11/255, green: 100/255, blue: 126/255, alpha: 1))
    public static let teal900 = Color(UIColor(red: 13/255, green: 78/255, blue: 98/255, alpha: 1))
    public static let teal950 = Color(UIColor(red: 4/255, green: 47/255, blue: 59/255, alpha: 1))

    // Cyan
    public static let cyan50 = Color(UIColor(red: 236/255, green: 255/255, blue: 255/255, alpha: 1))
    public static let cyan100 = Color(UIColor(red: 207/255, green: 250/255, blue: 254/255, alpha: 1))
    public static let cyan200 = Color(UIColor(red: 165/255, green: 243/255, blue: 252/255, alpha: 1))
    public static let cyan300 = Color(UIColor(red: 101/255, green: 230/255, blue: 247/255, alpha: 1))
    public static let cyan400 = Color(UIColor(red: 34/255, green: 211/255, blue: 238/255, alpha: 1))
    public static let cyan500 = Color(UIColor(red: 6/255, green: 182/255, blue: 212/255, alpha: 1))
    public static let cyan600 = Color(UIColor(red: 8/255, green: 141/255, blue: 165/255, alpha: 1))
    public static let cyan700 = Color(UIColor(red: 14/255, green: 114/255, blue: 139/255, alpha: 1))
    public static let cyan800 = Color(UIColor(red: 21/255, green: 94/255, blue: 120/255, alpha: 1))
    public static let cyan900 = Color(UIColor(red: 22/255, green: 78/255, blue: 102/255, alpha: 1))
    public static let cyan950 = Color(UIColor(red: 8/255, green: 51/255, blue: 67/255, alpha: 1))

    // Sky
    public static let sky50 = Color(UIColor(red: 240/255, green: 249/255, blue: 255/255, alpha: 1))
    public static let sky100 = Color(UIColor(red: 224/255, green: 242/255, blue: 255/255, alpha: 1))
    public static let sky200 = Color(UIColor(red: 186/255, green: 230/255, blue: 255/255, alpha: 1))
    public static let sky300 = Color(UIColor(red: 125/255, green: 211/255, blue: 255/255, alpha: 1))
    public static let sky400 = Color(UIColor(red: 56/255, green: 182/255, blue: 255/255, alpha: 1))
    public static let sky500 = Color(UIColor(red: 14/255, green: 165/255, blue: 235/255, alpha: 1))
    public static let sky600 = Color(UIColor(red: 2/255, green: 132/255, blue: 201/255, alpha: 1))
    public static let sky700 = Color(UIColor(red: 3/255, green: 105/255, blue: 161/255, alpha: 1))
    public static let sky800 = Color(UIColor(red: 7/255, green: 89/255, blue: 133/255, alpha: 1))
    public static let sky900 = Color(UIColor(red: 12/255, green: 74/255, blue: 110/255, alpha: 1))
    public static let sky950 = Color(UIColor(red: 8/255, green: 47/255, blue: 73/255, alpha: 1))

    // Blue
    public static let blue50 = Color(UIColor(red: 239/255, green: 246/255, blue: 255/255, alpha: 1))
    public static let blue100 = Color(UIColor(red: 219/255, green: 234/255, blue: 254/255, alpha: 1))
    public static let blue200 = Color(UIColor(red: 191/255, green: 219/255, blue: 254/255, alpha: 1))
    public static let blue300 = Color(UIColor(red: 147/255, green: 197/255, blue: 253/255, alpha: 1))
    public static let blue400 = Color(UIColor(red: 96/255, green: 165/255, blue: 250/255, alpha: 1))
    public static let blue500 = Color(UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1))
    public static let blue600 = Color(UIColor(red: 37/255, green: 99/255, blue: 235/255, alpha: 1))
    public static let blue700 = Color(UIColor(red: 29/255, green: 78/255, blue: 216/255, alpha: 1))
    public static let blue800 = Color(UIColor(red: 30/255, green: 64/255, blue: 175/255, alpha: 1))
    public static let blue900 = Color(UIColor(red: 30/255, green: 58/255, blue: 138/255, alpha: 1))
    public static let blue950 = Color(UIColor(red: 16/255, green: 36/255, blue: 58/255, alpha: 1))

    // Indigo
    public static let indigo50 = Color(UIColor(red: 238/255, green: 242/255, blue: 255/255, alpha: 1))
    public static let indigo100 = Color(UIColor(red: 213/255, green: 219/255, blue: 255/255, alpha: 1))
    public static let indigo200 = Color(UIColor(red: 174/255, green: 191/255, blue: 255/255, alpha: 1))
    public static let indigo300 = Color(UIColor(red: 123/255, green: 157/255, blue: 251/255, alpha: 1))
    public static let indigo400 = Color(UIColor(red: 82/255, green: 134/255, blue: 255/255, alpha: 1))
    public static let indigo500 = Color(UIColor(red: 61/255, green: 92/255, blue: 219/255, alpha: 1))
    public static let indigo600 = Color(UIColor(red: 48/255, green: 71/255, blue: 159/255, alpha: 1))
    public static let indigo700 = Color(UIColor(red: 38/255, green: 57/255, blue: 128/255, alpha: 1))
    public static let indigo800 = Color(UIColor(red: 33/255, green: 45/255, blue: 107/255, alpha: 1))
    public static let indigo900 = Color(UIColor(red: 26/255, green: 35/255, blue: 86/255, alpha: 1))
    public static let indigo950 = Color(UIColor(red: 12/255, green: 18/255, blue: 44/255, alpha: 1))

    // Violet
    public static let violet50 = Color(UIColor(red: 245/255, green: 243/255, blue: 255/255, alpha: 1))
    public static let violet100 = Color(UIColor(red: 237/255, green: 233/255, blue: 254/255, alpha: 1))
    public static let violet200 = Color(UIColor(red: 221/255, green: 214/255, blue: 254/255, alpha: 1))
    public static let violet300 = Color(UIColor(red: 196/255, green: 181/255, blue: 253/255, alpha: 1))
    public static let violet400 = Color(UIColor(red: 167/255, green: 139/255, blue: 250/255, alpha: 1))
    public static let violet500 = Color(UIColor(red: 139/255, green: 92/255, blue: 246/255, alpha: 1))
    public static let violet600 = Color(UIColor(red: 124/255, green: 58/255, blue: 233/255, alpha: 1))
    public static let violet700 = Color(UIColor(red: 109/255, green: 40/255, blue: 217/255, alpha: 1))
    public static let violet800 = Color(UIColor(red: 91/255, green: 33/255, blue: 185/255, alpha: 1))
    public static let violet900 = Color(UIColor(red: 76/255, green: 29/255, blue: 149/255, alpha: 1))
    public static let violet950 = Color(UIColor(red: 41/255, green: 16/255, blue: 91/255, alpha: 1))

    // Purple
    public static let purple50 = Color(UIColor(red: 250/255, green: 245/255, blue: 255/255, alpha: 1))
    public static let purple100 = Color(UIColor(red: 245/255, green: 228/255, blue: 254/255, alpha: 1))
    public static let purple200 = Color(UIColor(red: 237/255, green: 200/255, blue: 254/255, alpha: 1))
    public static let purple300 = Color(UIColor(red: 219/255, green: 159/255, blue: 251/255, alpha: 1))
    public static let purple400 = Color(UIColor(red: 190/255, green: 118/255, blue: 246/255, alpha: 1))
    public static let purple500 = Color(UIColor(red: 157/255, green: 100/255, blue: 225/255, alpha: 1))
    public static let purple600 = Color(UIColor(red: 135/255, green: 84/255, blue: 194/255, alpha: 1))
    public static let purple700 = Color(UIColor(red: 112/255, green: 69/255, blue: 168/255, alpha: 1))
    public static let purple800 = Color(UIColor(red: 96/255, green: 58/255, blue: 146/255, alpha: 1))
    public static let purple900 = Color(UIColor(red: 79/255, green: 43/255, blue: 122/255, alpha: 1))
    public static let purple950 = Color(UIColor(red: 42/255, green: 20/255, blue: 66/255, alpha: 1))

    // Fuchsia
    public static let fuchsia50 = Color(UIColor(red: 254/255, green: 243/255, blue: 255/255, alpha: 1))
    public static let fuchsia100 = Color(UIColor(red: 254/255, green: 220/255, blue: 254/255, alpha: 1))
    public static let fuchsia200 = Color(UIColor(red: 252/255, green: 191/255, blue: 252/255, alpha: 1))
    public static let fuchsia300 = Color(UIColor(red: 251/255, green: 148/255, blue: 249/255, alpha: 1))
    public static let fuchsia400 = Color(UIColor(red: 249/255, green: 96/255, blue: 245/255, alpha: 1))
    public static let fuchsia500 = Color(UIColor(red: 236/255, green: 32/255, blue: 221/255, alpha: 1))
    public static let fuchsia600 = Color(UIColor(red: 196/255, green: 12/255, blue: 185/255, alpha: 1))
    public static let fuchsia700 = Color(UIColor(red: 160/255, green: 9/255, blue: 148/255, alpha: 1))
    public static let fuchsia800 = Color(UIColor(red: 130/255, green: 6/255, blue: 120/255, alpha: 1))
    public static let fuchsia900 = Color(UIColor(red: 109/255, green: 6/255, blue: 98/255, alpha: 1))
    public static let fuchsia950 = Color(UIColor(red: 60/255, green: 3/255, blue: 53/255, alpha: 1))

    // Pink
    public static let pink50 = Color(UIColor(red: 255/255, green: 245/255, blue: 247/255, alpha: 1))
    public static let pink100 = Color(UIColor(red: 255/255, green: 221/255, blue: 235/255, alpha: 1))
    public static let pink200 = Color(UIColor(red: 254/255, green: 182/255, blue: 217/255, alpha: 1))
    public static let pink300 = Color(UIColor(red: 252/255, green: 128/255, blue: 196/255, alpha: 1))
    public static let pink400 = Color(UIColor(red: 248/255, green: 72/255, blue: 173/255, alpha: 1))
    public static let pink500 = Color(UIColor(red: 231/255, green: 20/255, blue: 135/255, alpha: 1))
    public static let pink600 = Color(UIColor(red: 190/255, green: 11/255, blue: 104/255, alpha: 1))
    public static let pink700 = Color(UIColor(red: 157/255, green: 8/255, blue: 89/255, alpha: 1))
    public static let pink800 = Color(UIColor(red: 131/255, green: 6/255, blue: 75/255, alpha: 1))
    public static let pink900 = Color(UIColor(red: 110/255, green: 8/255, blue: 62/255, alpha: 1))
    public static let pink950 = Color(UIColor(red: 60/255, green: 4/255, blue: 33/255, alpha: 1))
    
    // Rose
    public static let rose50 = Color(UIColor(red: 255/255, green: 241/255, blue: 242/255, alpha: 1))
    public static let rose100 = Color(UIColor(red: 255/255, green: 228/255, blue: 230/255, alpha: 1))
    public static let rose200 = Color(UIColor(red: 254/255, green: 205/255, blue: 213/255, alpha: 1))
    public static let rose300 = Color(UIColor(red: 252/255, green: 171/255, blue: 192/255, alpha: 1))
    public static let rose400 = Color(UIColor(red: 251/255, green: 113/255, blue: 161/255, alpha: 1))
    public static let rose500 = Color(UIColor(red: 244/255, green: 63/255, blue: 130/255, alpha: 1))
    public static let rose600 = Color(UIColor(red: 214/255, green: 18/255, blue: 94/255, alpha: 1))
    public static let rose700 = Color(UIColor(red: 190/255, green: 10/255, blue: 76/255, alpha: 1))
    public static let rose800 = Color(UIColor(red: 157/255, green: 10/255, blue: 63/255, alpha: 1))
    public static let rose900 = Color(UIColor(red: 136/255, green: 9/255, blue: 56/255, alpha: 1))
    public static let rose950 = Color(UIColor(red: 76/255, green: 4/255, blue: 28/255, alpha: 1))
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
