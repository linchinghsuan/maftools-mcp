"""Protocol-clean launcher; analytical implementation is preserved in server.py."""
import argparse
import sys

def main():
    # R progress must never enter the JSON-RPC stdout channel.
    from rpy2.rinterface_lib import callbacks
    callbacks.consolewrite_print = lambda message: sys.stderr.write(message)
    from .server import mcp
    parser = argparse.ArgumentParser(description="Maftools-MCP")
    parser.add_argument("--transport", choices=["stdio", "http"], default="stdio")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8000)
    parser.add_argument("--path", default="/mcp")
    args = parser.parse_args()
    if args.transport == "stdio":
        mcp.run(transport="stdio", show_banner=False)
    else:
        mcp.run(transport="streamable-http", host=args.host, port=args.port,
                path=args.path, show_banner=False)

if __name__ == "__main__":
    main()
