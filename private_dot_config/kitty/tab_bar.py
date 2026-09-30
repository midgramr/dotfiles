from kitty.fast_data_types import get_boss, wcswidth
from kitty.tab_bar import as_rgb, draw_tab_with_separator


tab_widths = {}


def draw_tab(draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data):
    if extra_data.for_layout and index == 1:
        tab_widths[tab.os_window_id] = []
    session_name = ''
    if index == 1:
        manager = get_boss().os_window_map.get(tab.os_window_id)
        if manager is not None and manager.active_tab is not None:
            session_name = manager.active_tab.active_session_name
    if session_name:
        label = f" 󰉋 {session_name} "
        available = max(0, max_tab_length - 5)
        if wcswidth(label) > available:
            while label and wcswidth(label + '…') > available:
                label = label[:-1]
            label = label + '…' if available else ''
        fg, bg = screen.cursor.fg, screen.cursor.bg
        screen.cursor.fg = as_rgb(0xd3c6aa)
        screen.cursor.bg = as_rgb(0x475258)
        screen.draw(label)
        screen.cursor.bg = as_rgb(int(draw_data.default_bg))
        screen.cursor.fg, screen.cursor.bg = fg, bg
        max_tab_length -= screen.cursor.x - before
        before = screen.cursor.x
    if index == 1 and not extra_data.for_layout:
        width = sum(tab_widths.get(tab.os_window_id, []))
        padding = max(0, (screen.columns - width) // 2 - screen.cursor.x)
        bg = screen.cursor.bg
        screen.cursor.bg = as_rgb(int(draw_data.default_bg))
        screen.draw(' ' * padding)
        screen.cursor.bg = bg
        before = screen.cursor.x
    end = draw_tab_with_separator(
        draw_data, screen, tab, before, max_tab_length, index, is_last, extra_data
    )
    if extra_data.for_layout:
        tab_widths[tab.os_window_id].append(screen.cursor.x - before)
    return end
