import typer
from loguru import logger


def main(required_arg: str, optional_arg: str = None) -> None:
    logger.info(f"Hello! required_arg = {required_arg}, optional_arg = {optional_arg}")

    try:
        from rich.console import Console
        from rich.table import Table
    except ModuleNotFoundError:
        raise ModuleNotFoundError("rich must be installed to use this method. Try `pip install rich`.")

    # See: https://rich.readthedocs.io/en/stable/tables.html

    table = Table(show_header=True, header_style="bold blue")
    table.add_column("Date", style="dim", width=12)
    table.add_column("Title")
    table.add_column("Production Budget", justify="right")
    table.add_column("Box Office", justify="right")
    table.add_row(
        "Dev 20, 2019", "Star Wars: The Rise of Skywalker", "$275,000,000", "$375,126,118"
    )
    table.add_row(
        "May 25, 2018",
        "[red]Solo[/red]: A Star Wars Story",
        "$275,000,000",
        "$393,151,347",
    )
    table.add_row(
        "Dec 15, 2017",
        "Star Wars Ep. VIII: The Last Jedi",
        "$262,000,000",
        "[bold]$1,332,539,889[/bold]",
    )

    console = Console()
    console.print(table)


if __name__ == "__main__":
    typer.run(main)
