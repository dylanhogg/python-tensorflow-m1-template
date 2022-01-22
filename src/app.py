import typer
from tqdm import tqdm
from time import sleep
from loguru import logger
from library import env, log


def main(required_arg: str, optional_arg: str = None) -> None:
    logger.info(f"Hello! required_arg = {required_arg}, optional_arg = {optional_arg}")
    logger.info(f"PYTHONPATH = {env.get('PYTHONPATH', 'Not set')}")
    logger.info(f"LOG_STDERR_LEVEL = {env.get('LOG_STDERR_LEVEL', 'Not set. Copy `.env_template` to `.env`')}")
    logger.info(f"LOG_FILE_LEVEL = {env.get('LOG_FILE_LEVEL', 'Not set. Copy `.env_template` to `.env`')}")

    for i in tqdm(range(5)):
        sleep(0.1)


if __name__ == "__main__":
    log.configure()
    typer.run(main)
