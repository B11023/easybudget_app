# EasyBudget – Flutter 記帳應用

EasyBudget 是一款以 Flutter 開發的跨平台記帳應用程式，整合 Google OAuth 登入、RESTful API 串接、資料統計分析與深色模式支援。專案採用分層架構設計，強調狀態管理與統計邏輯分離。

---

## 技術棧

- Flutter 3.35.2
- Dart
- Provider（狀態管理）
- Dio（RESTful API 串接）
- Freezed + JsonSerializable（Immutable Model）
- Google Sign-In（OAuth2）
- FlChart（資料視覺化）
- Material 3 Theme System

---

## 核心架構設計

### 1. Feature-based Folder Structure
# EasyBudget – Flutter 記帳應用

EasyBudget 是一款以 Flutter 開發的跨平台記帳應用程式，整合 Google OAuth 登入、RESTful API 串接、資料統計分析與深色模式支援。專案採用分層架構設計，強調狀態管理與統計邏輯分離，展現中階 Flutter 工程能力。

---

## 技術棧

- Flutter 3.x
- Dart
- Provider（狀態管理）
- Dio（RESTful API 串接）
- Freezed + JsonSerializable（Immutable Model）
- Google Sign-In（OAuth2）
- FlChart（資料視覺化）
- Material 3 Theme System

---

## 核心架構設計

### 1. Feature-based Folder Structure

```text
lib/
├── common/
│ ├── models/
│ ├── services/
│ ├── provider/
│ └── theme/
├── core/
│ ├── auth/
│ └── network/
└── features/
├── home/
├── balance/
├── analyze/
├── login/
└── set/
```text

### 2. 狀態管理分離

- `EntryProvider`：交易資料與統計狀態
- `ThemeProvider`：主題模式控制
- `AuthProvider`：登入狀態管理

遵守 Single Responsibility Principle，避免 UI 混入業務邏輯。

---

### 3. 統計邏輯抽離（Service Layer）

所有統計計算集中於 `EntryQueryService`：

- 當月資料過濾
- 分日分組
- 類別加總
- 年度每月 balance 計算
- 全年總 balance 計算

UI 僅負責呈現，計算完全分離。

---

### 4. Tab 架構優化

- 使用 `IndexedStack` 實作 BottomNavigationBar
- 避免 Navigator 模擬 Tab
- 保留頁面狀態
- 避免畫面閃爍與重建問題

---

### 5. RESTful API 整合

- Dio 統一管理 BaseOptions
- Bearer Token 動態注入
- API Layer 抽象封裝
- 錯誤狀態管理（LoadStatus）

---

## 功能特色

- 月份切換統計
- 年度折線圖分析
- 類別圓餅圖分析
- 分日交易紀錄列表
- Google OAuth 登入
- RESTful API 同步
- Light / Dark / System 主題模式

---

## 工程亮點

- Immutable Model（Freezed）
- 強型別 enum 管理收入／支出
- Provider 與 UI 解耦
- 統計邏輯集中管理
- IndexedStack 優化頁面切換
- 清晰命名規範與資料流設計
