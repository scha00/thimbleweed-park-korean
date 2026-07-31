#!/bin/bash
set -euo pipefail

echo "=== Thimbleweed Park 한글패치 제거 (Mac) ==="
echo ""

if [ -n "${1:-}" ]; then
  GAME_DIR="$1"
else
  read -rp "게임 Resources 폴더 경로를 입력하세요: " GAME_DIR
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
