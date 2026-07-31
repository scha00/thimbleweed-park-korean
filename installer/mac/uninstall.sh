#!/bin/bash
set -euo pipefail

echo "=== Thimbleweed Park 한글패치 제거 (Mac) ==="
echo ""
echo "예시 경로:"
echo "  Steam: ~/Library/Application Support/Steam/steamapps/common/Thimbleweed Park/Thimbleweed Park.app/Contents/Resources"
echo "  GOG:   /Applications/Thimbleweed Park.app/Contents/Resources"
echo ""

STEAM_DEFAULT="$HOME/Library/Application Support/Steam/steamapps/common/Thimbleweed Park/Thimbleweed Park.app/Contents/Resources"
GOG_DEFAULT="/Applications/Thimbleweed Park.app/Contents/Resources"

if [ -n "${1:-}" ]; then
  GAME_DIR="$1"
else
  read -rp "게임 Resources 폴더 경로를 입력하세요 (Steam/GOG 기본 설치 위치라면 그냥 Enter): " GAME_DIR
  if [ -z "$GAME_DIR" ]; then
    if [ -f "$STEAM_DEFAULT/ThimbleweedPark.ggpack1.orig" ]; then
      GAME_DIR="$STEAM_DEFAULT"
      echo "Steam 기본 경로에서 자동으로 찾았습니다: $GAME_DIR"
    elif [ -f "$GOG_DEFAULT/ThimbleweedPark.ggpack1.orig" ]; then
      GAME_DIR="$GOG_DEFAULT"
      echo "GOG 기본 경로에서 자동으로 찾았습니다: $GAME_DIR"
    else
      echo "오류: 기본 설치 경로에서 백업을 찾지 못했습니다. 스크립트를 다시 실행해서 경로를 직접 입력하세요."
      exit 1
    fi
  fi
fi

GGPACK="$GAME_DIR/ThimbleweedPark.ggpack1"
BACKUP="$GAME_DIR/ThimbleweedPark.ggpack1.orig"

if [ ! -f "$BACKUP" ]; then
  echo "오류: 백업 파일($BACKUP)을 찾을 수 없습니다."
  echo "패치가 설치되지 않았거나 이미 제거된 것 같습니다."
  exit 1
fi

cp "$BACKUP" "$GGPACK"
echo "원본으로 복원했습니다."
