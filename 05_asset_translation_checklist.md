# 팀블위드 파크 한글화 — 이미지/폰트 에셋 체크리스트

문자열 번역(ThimbleweedText_*.tsv)은 완료된 것으로 간주하고, 이제 텍스트가 그림 안에 직접 그려져 있는 에셋들(이미지 + 폰트)을 손볼 차례.

## 작업 방식 (확정)

- 에셋들은 텍스처패커(TexturePacker) 아틀라스 형식: 하나의 큰 `XXXSheet.png` 안에 언어별 서브 이미지가 `이름_en`, `이름_de`, `이름_ru`처럼 프레임으로 나뉘어 들어있고, `XXXSheet.json`이 각 프레임의 좌표/크기를 정의함.
- **배포 전략 최종본 (2026-07-30, en→de로 변경됨, progress.md 13번 항목 참고)**: en이 아니라 **"de"(독일어) 슬롯을 한글로 덮어씀** — en 활성 상태에서는 컴파일된 엔진 로직 일부(메인 메뉴, 연결어, 동사 어순)가 tsv를 무시하는 문제가 있어서, 실제 선택 가능한 언어인 de로 전환함. 이미지 시트는 **모든 `_de` 프레임 좌표를 `_en` 프레임과 동일하게 리다이렉트**해서 이미지 번역 없이도 최소 영어로라도 보이게 처리 완료(27개 json, 120개 de 프레임, + HelpScreen_XX_de.png 39개 + tsv 밖 텍스트파일 6개도 en으로 폴백). 즉 **아래 A 목록(이미지 자체를 한글화하는 작업)은 필수가 아니라 선택 사항이 됨** — 지금은 영어로 폴백되고 있어서 급하지 않음. 나중에 여유 있으면 진행.
- 이미지 자체를 한글화할 경우 처리 순서: 1) 한글 번역 이미지를 새로 렌더링 → 2) 기존 `XXXSheet.png`의 **원본 픽셀은 건드리지 않고**, 캔버스를 확장해서 그 아래(또는 빈 공간)에 새 이미지로 추가 → 3) `XXXSheet.json`에서 해당 프레임의 좌표(x,y,w,h)를 새로 추가된 한글 이미지의 위치로 갱신.
- `HelpScreen_XX_de.png`류는 아틀라스가 아니라 **언어별로 파일 자체가 통째로 분리**돼있는 방식 — json 좌표 수정 없이 파일 자체를 통째로 교체하면 됨 (지금은 en 내용으로 폴백해둔 상태).

---

## A. 번역해야 할 이미지 시트

이미지 자체를 한글화한 시트 목록/진행 상황은 `png-translate/MANIFEST.md`
(작업 디렉터리 전용, git 미추적)에서 관리합니다. 2026-08-07 기준
EasyHardModeSheet/NewspaperSheet/HintTronFlyerCUSheet/FanSupportNumberCUSheet/
BStreetSheet/HardwareStoreSheet/CabinRoadSheet/CircusEntranceSheet/
FactoryCorridor4Sheet/FactoryFrontSheet/FactorySheet/MMucasFlemAdSheet
12개 완료, VerbSheet(36개 영역)·TitleCardsSheet(18개 영역)를 포함한 나머지는
계속 진행 중입니다.

| 시트 | 형식 | en 프레임/파일 수 | 비고 | 상태 |
|---|---|---|---|---|
| VerbSheet | 아틀라스 (VerbSheet.png/json) | 36개 (`close_en`, `open_en`, `pickup_en` 등 18개 동사 × modern/retro 2종) | 인터페이스 동사 버튼. `03_terminology_glossary.md`의 UI 동사 표기와 반드시 일치시킬 것 | [ ] |
| TitleCardsSheet | 아틀라스 | 18개 (`part1_en`~`part9_en`, `part1_title_en`~`part9_title_en`) | 각 파트 시작 타이틀 카드("Part One: The Meeting" 류) | [ ] |
| OpeningNoteSheet | 아틀라스, **주의** | en 접미사 프레임 없음 (`boris_note`, `ransome_note` — 언어 구분이 원래 없는 손글씨 이미지로 보임, 다른 언어(de/ru 등)에도 로컬라이즈된 버전이 있는지 먼저 확인 필요) | 오프닝의 보리스/랜섬 손글씨 메모 | [ ] |
| HelpScreen_01_en ~ HelpScreen_49_en | 파일별 분리 (39개 파일, 번호 불연속: 01-16, 20-25, 30-36, 40-49) | 39개 파일 | 게임 내 도움말/튜토리얼 스크린샷형 이미지, 낮은 우선순위 | [ ] |

## B. 고쳐야 할 폰트 (러시아어 글리프가 있는 것 = 실제 로컬라이즈 대상으로 확인된 것 전부)

완성형 한글 2,350자, 원본 라틴 캡하이트에 맞춰 크기 자동 보정 후 렌더링해서 각 .fnt/.png에 추가 완료 (`/tmp/font_gen.py` 파이프라인 사용 — 지정 TTF로 렌더링 → 기존 이미지 훼손 없이 캔버스 아래에 새 글리프 추가 → .fnt에 char 라인 append).

| 폰트 | 실제 사용 확인 | 적용 한글 폰트 | 상태 |
|---|---|---|---|
| FontModernSheet | 엔진 기본 폰트(대사/UI 대부분) | (기존 작업, 별도 방식) | [x] 완료 (2026-07-30) |
| FontRetroSheet | 엔진 기본 폰트(레트로 UI 모드) | (기존 작업, 별도 방식) | [x] 완료 (2026-07-30) |
| ArcadeFontBig | 미확인 | Galmuri11 Bold, 외곽선 없음 | [x] 완료 (2026-07-30) |
| ComputerFont | 미확인 | Galmuri9, 외곽선 없음 | [x] 완료 (2026-07-30) |
| ErrorFont | 미확인 | Pretendard Regular, 외곽선 1px | [x] 완료 (2026-07-30) |
| HeadingFont | 미확인 | Pretendard Bold, 외곽선 1px | [x] 완료 (2026-07-30) |
| LibraryBookCoverFont | 미확인 | Gowun Batang, 외곽선 없음 | [x] 완료 (2026-07-30) |
| LibraryBookPageFont | 미확인 | Gowun Batang, 외곽선 없음 | [x] 완료 (2026-07-30) |
| NewspaperFont | 미확인 | Nanum Myeongjo, 검은색 채움, 외곽선 없음 (원본이 검은 글씨라 매칭) | [x] 완료 (2026-07-30) |
| TronReport | **확인됨** (Notes.wimpy, CoronersOffice.wimpy, SheriffsOffice.wimpy — FingerTron/BloodTron/FaceTron/ArrestTron 보고서) | Galmuri9, 외곽선 없음 | [x] 완료 (2026-07-30) |
| UIFontLarge | 미확인 | Pretendard Regular, 외곽선 1px | [x] 완료 (2026-07-30) |
| UIFontMedium | 미확인 | Pretendard Regular, 외곽선 1px | [x] 완료 (2026-07-30) |
| UIFontSmall | 미확인 | Pretendard Regular, 외곽선 1px | [x] 완료 (2026-07-30) |
| UIFontSmallBold (UIFontSmall.png 공유 — 처리 순서 주의, 공유 캔버스라 UIFontSmall 먼저 처리 후 이어서 처리함) | 미확인 | Pretendard Bold, 외곽선 1px | [x] 완료 (2026-07-30) |
| WalterTurncoat12 | 미확인 | 사용자가 불필요 판단, 스킵 | [ ] 보류 |
| WalterTurncoat15 | 미확인 | 사용자가 불필요 판단, 스킵 | [ ] 보류 |
| WillFont | 미확인 (알고보니 "VCR OSD Mono" 모노스페이스 CRT체) | Galmuri9, 외곽선 없음 | [x] 완료 (2026-07-30) |

**제외 대상 (러시아어 글리프 자체가 없어서 원작도 로컬라이즈 안 한 폰트들, 손 안 대도 됨):** C64Pro16/24/32/44(Outline 포함), DialogFont, DialogFont_retro, PhonebookFont, Roboto24, SayLineFont, SayLineFont_retro, SentenceFont, SentenceFont_retro, SewerWritingFont, SpecialEliteFont, TinyFont

**참고:** `FontC64TermSheet`는 pack1 전체에서 미참조 확인된 죽은 에셋이라 대상에서 제외.

**원본 폰트 정체 (참고용, 스타일 재현 시 매칭 근거로 삼음):** ArcadeFontBig="Press Start 2P"(8비트), ComputerFont="Glass TTY VT220"(CRT터미널), ErrorFont/HeadingFont/LibraryBookCoverFont(Georgia)/LibraryBookPageFont(Georgia)/UIFontLarge/UIFontMedium/UIFontSmall(SmallBold)="Roboto Slab"(슬랩세리프), NewspaperFont="Special Elite"(타자기체), TronReport="5by7"(픽셀), WillFont="VCR OSD Mono"(모노스페이스 CRT).

**백업:** 원본 .fnt/.png는 전부 `pack1-font-backup/`에 보존해둠 (문제 생기면 여기서 복구).

---

## 진행률
- A. 이미지 시트: **12개 완료, 나머지 진행 중** (자세한 목록은 `png-translate/MANIFEST.md` 참고, de→en 리다이렉트라 미번역분은 영어로 정상 표시됨)
- B. 폰트: **15/17 완료** (WalterTurncoat12/15만 사용자 판단으로 보류, 나머지 전부 완료)
