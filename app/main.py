# python test application

import asyncio
import aiohttp


async def fetch(session):
    """ fetch function """
    print('Query http://httpbin.org/get')
    async with session.get(
            'http://httpbin.org/get') as resp:
        print(resp.status)
        data = await resp.json()
        print(data)


async def fetch_from_source(loop):
    """ fetch loop """
    async with aiohttp.ClientSession(loop=loop) as session:
        await fetch(session)


def main():
    """ start main function """
    loop = asyncio.get_event_loop()
    loop.run_until_complete(fetch_from_source(loop))
    loop.close()


if __name__ == '__main__':
    main()
