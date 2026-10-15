# PREPare Brand Assets — V2

Source brand files for PREPare. The app uses copies of these in `PREPare/Assets.xcassets`.

## Contents

| Folder | Files | Notes |
|---|---|---|
| `00_Overview/` | `00_Cover`, `01_Logo`, `02_App_Icon`, `03_Branding`, `04_Colors` | Presentation sheets, for reference only |
| `01_Logo/` | `PREPare_Logo_Primary_Transparent` | Main logo, for light backgrounds (1020×801, transparent) |
| | `PREPare_Logo_Primary_OnWhite`, `PREPare_Logo_Primary_OnMist` | Main logo on a solid background (1387×1168) |
| | `PREPare_Logo_White_Transparent` | White logo, for dark backgrounds (1020×801, transparent) |
| | `PREPare_Logo_White_OnNavy` | White logo on Deep Navy (1387×1168) |
| `02_App_Icon/` | `PREPare_AppIcon_1024` | Master iOS app icon (1024×1024, no alpha) |
| | `PREPare_AppIcon_Preview_Rounded` | Rounded preview, for presentations only, not for the App Store |
| | `Sizes/PREPare_AppIcon_<px>` | Legacy fixed sizes (20–512 px). Xcode only needs the 1024 master. |
| `03_Colors/` | `PREPare_Colors.json`, `.css`, `.txt` | Color tokens |

## Colors

| Name | Role | Hex | RGB | In the app |
|---|---|---|---|---|
| Deep Navy | Primary | `#213C51` | 33, 60, 81 | `Color.primaryColor`, start of the splash gradient |
| Steel Blue | Primary | `#6594B1` | 101, 148, 177 | `Color.secondaryColor`, end of the splash gradient |
| Mist | Supporting | `#E8EFF5` | 232, 239, 245 | Logo background variant |
| Ink | Supporting | `#0E1821` | 14, 24, 33 | — |

Typography: SF Pro (iOS), Inter (web and documents).

## Usage

- Light backgrounds: the Primary logo.
- Deep Navy or dark backgrounds: the White logo.
- The app uses the 1024 icon (`AppIcon`) and the Primary transparent logo, centered on a square canvas at 66% width (`prepare_app_logo`, on the splash screen's white card).

## Missing

The overview sheet lists `.ai`, `.eps`, and `.svg` source files, but this package only contains PNGs. Ask the designer for vector files before making print or large-format material.

## Changes from the original package

- Renamed files to a consistent `PREPare_<Asset>_<Variant>` pattern and grouped them by type.
- Removed two exact duplicates of overview sheets (`Color_Swatches_V2.png` and `Branding_Mockups_V2.png`).
- Removed `.DS_Store` files.

The original zip is `~/Downloads/PREPare_Brand_Assets_V2.zip`.
