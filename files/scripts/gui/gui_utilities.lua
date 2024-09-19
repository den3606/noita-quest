--- @param gui userdata GUIオブジェクト
--- @param params { x: number, y: number, position_in_ui_scale: boolean?, margin_x: number?, margin_y: number? }
---   - x: number? (default: 0) - 配置するX座標
---   - y: number? (default: 0) - 配置するY座標
---   - position_in_ui_scale: boolean? (default: false) - UIスケールに基づいた位置調整を行うかどうか
---   - margin_x: number? (default: 0) - 水平方向のマージン
---   - margin_y: number? (default: 0) - 垂直方向のマージン
--- @param callback function レイアウト内で実行されるコールバック関数
function GuiLayoutHorizontalCallback(gui, params, callback)
  GuiLayoutBeginHorizontal(gui, params.x or 0, params.y or 0, params.position_in_ui_scale, params.margin_x, params.margin_y)
  callback()
  GuiLayoutEnd(gui)
end

--- @param gui userdata GUIオブジェクト
--- @param params { x: number?, y: number?, position_in_ui_scale: boolean?, margin_x: number?, margin_y: number? }
---   - x: number? (default: 0) - 配置するX座標
---   - y: number? (default: 0) - 配置するY座標
---   - position_in_ui_scale: boolean? (default: false) - UIスケールに基づいた位置調整を行うかどうか
---   - margin_x: number? (default: 0) - 水平方向のマージン
---   - margin_y: number? (default: 0) - 垂直方向のマージン
--- @param callback function レイアウト内で実行されるコールバック関数
function GuiLayoutVerticalCallback(gui, params,
                                   callback)
  GuiLayoutBeginVertical(gui, params.x or 0, params.y or 0, params.position_in_ui_scale, params.margin_x, params.margin_y)
  callback()
  GuiLayoutEnd(gui)
end

--- @param gui userdata GUIオブジェクト
--- @param params { margin: number?, size_min_x: number?, size_min_y: number?, mirrorize_over_x_axis: boolean?, x_axis: number?, sprite_filename: string?, sprite_highlight_filename: string? }
---   - margin: number? (default: 5) - ボックスのマージン
---   - size_min_x: number? (default: 0) - 最小Xサイズ
---   - size_min_y: number? (default: 0) - 最小Yサイズ
---   - mirrorize_over_x_axis: boolean? (default: false) - 水平方向の反転を行うかどうか
---   - x_axis: number? (default: 0) - X軸に対するオフセット
---   - sprite_filename: string? (default: "data/ui_gfx/decorations/9piece0_gray.png") - スプライトのファイル名
---   - sprite_highlight_filename: string? (default: "data/ui_gfx/decorations/9piece0_gray.png") - ハイライト時のスプライトファイル名
--- @param callback function コールバック関数
function GuiAutoBoxCallback(gui, params, callback)
  GuiBeginAutoBox(gui)
  callback()

  if not params.sprite_filename then
    params.sprite_filename = "data/ui_gfx/decorations/9piece0_gray.png"
  end

  if not params.sprite_highlight_filename then
    params.sprite_highlight_filename = "data/ui_gfx/decorations/9piece0_gray.png"
  end

  GuiEndAutoBoxNinePiece(gui, params.margin, params.size_min_x, params.size_min_y, params.mirrorize_over_x_axis, params.x_axis,
    params.sprite_filename)
end

--- @param gui userdata GUIオブジェクト
--- @param params { z_index: number } Zインデックスを指定するパラメータ
---   - z_index: number - Zインデックスの値
--- @param callback function コールバック関数
function GuiZCallback(gui, params, callback)
  GuiZSet(gui, params.z_index)
  callback()
  GuiZSet(gui, 0)
end

--- @param gui userdata GUIオブジェクト
--- @param params { id: number, x: number, y: number, width: number, height: number, scrollbar_gamepad_focusable: boolean?, margin_x: number?, margin_y: number? }
---   - id: number - コンテナの一意のID
---   - x: number? (default: 0) - コンテナのX座標
---   - y: number? (default: 0) - コンテナのY座標
---   - width: number - コンテナの幅
---   - height: number - コンテナの高さ
---   - scrollbar_gamepad_focusable: boolean? (default: true) - スクロールバーがゲームパッドでフォーカスできるかどうか
---   - margin_x: number? (default: 2) - 水平方向のマージン
---   - margin_y: number? (default: 2) - 垂直方向のマージン
--- @param callback function コールバック関数
function GuiScrollContainerCallback(gui, params, callback)
  GuiBeginScrollContainer(gui, params.id, params.x or 0, params.y or 0, params.width, params.height, params.scrollbar_gamepad_focusable or true,
    params.margin_x or 2, params.margin_y or 2)
  callback()
  GuiEndScrollContainer(gui)
end
