#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATCH_DIR="$SCRIPT_DIR/../patch"
NGPACK="$SCRIPT_DIR/ngpack-tool"

echo "=== Thimbleweed Park 한글패치 설치 (Mac) ==="
echo ""
echo "게임 앱을 Finder에서 우클릭 > '패키지 내용 보기'로 열면"
echo "Contents/Resources 폴더 안에 ThimbleweedPark.ggpack1 파일이 있습니다."
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
  read -rp "그 폴더(Resources) 경로를 입력하세요 (Steam/GOG 기본 설치 위치라면 그냥 Enter): " GAME_DIR
  if [ -z "$GAME_DIR" ]; then
    if [ -f "$STEAM_DEFAULT/ThimbleweedPark.ggpack1" ]; then
      GAME_DIR="$STEAM_DEFAULT"
      echo "Steam 기본 경로에서 자동으로 찾았습니다: $GAME_DIR"
    elif [ -f "$GOG_DEFAULT/ThimbleweedPark.ggpack1" ]; then
      GAME_DIR="$GOG_DEFAULT"
      echo "GOG 기본 경로에서 자동으로 찾았습니다: $GAME_DIR"
    else
      echo "오류: 기본 설치 경로에서 게임을 찾지 못했습니다. 스크립트를 다시 실행해서 경로를 직접 입력하세요."
      exit 1
    fi
  fi
fi

GGPACK="$GAME_DIR/ThimbleweedPark.ggpack1"
if [ ! -f "$GGPACK" ]; then
  echo "오류: $GGPACK 파일을 찾을 수 없습니다. 경로를 다시 확인하세요."
  exit 1
fi

BACKUP="$GAME_DIR/ThimbleweedPark.ggpack1.orig"
if [ ! -f "$BACKUP" ]; then
  echo "원본 백업 중... ($BACKUP)"
  cp "$GGPACK" "$BACKUP"
else
  echo "기존 백업을 그대로 사용합니다 (재설치)."
fi

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

cp "$BACKUP" "$WORKDIR/ThimbleweedPark.ggpack1"

cd "$WORKDIR"
echo "게임 파일 압축 해제 중..."
"$NGPACK" extract ThimbleweedPark.ggpack1 -p "*"
rm ThimbleweedPark.ggpack1

echo "한글 번역 파일 적용 중... ($(find "$PATCH_DIR" -type f | wc -l | tr -d ' ')개 파일)"
cp -R "$PATCH_DIR"/. .

echo "다시 압축하는 중..."
"$NGPACK" create ThimbleweedPark.ggpack1 -k auto -p "*"

echo "게임 파일 교체 중..."
cp "$WORKDIR/ThimbleweedPark.ggpack1" "$GGPACK"

echo ""
echo "설치 완료!"
echo "게임을 실행해서 옵션 > 언어(Language) 목록에서 'Korean Text'를 선택하면 한글로 표시됩니다."
