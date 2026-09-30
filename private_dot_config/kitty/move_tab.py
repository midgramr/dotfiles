from kittens.tui.handler import result_handler


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    manager = boss.active_tab_manager
    if manager is not None:
        tabs = tuple(manager.tabs_to_be_shown_in_tab_bar)
        if manager.active_tab in tabs:
            target = min(max(int(args[1]) - 1, 0), len(tabs) - 1)
            manager.move_tab(target - tabs.index(manager.active_tab))
