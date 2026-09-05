"""Exercise MCP discovery, R-backed analysis and R export on synthetic data."""
import asyncio
import json
from pathlib import Path
import tempfile
from fastmcp import Client
from maftools_mcp.server import mcp

async def main():
    root=Path(__file__).resolve().parents[1]
    fixture=root/"examples/data/synthetic.maf"
    with tempfile.TemporaryDirectory(prefix="maftools-smoke-") as tmp:
        async with Client(mcp) as client:
            tools=await client.list_tools()
            assert len(tools)==60, f"Expected 60 registered tools, found {len(tools)}"
            schemas={t.name:t.inputSchema for t in tools}
            print(f"Discovered {len(tools)} MCP tools")
            calls=[("list_genes",{"maf_path":str(fixture),"output_file":str(Path(tmp)/"gene_list.txt")}),
                   ("get_gene_summary",{"maf_path":str(fixture),"output_dir":tmp})]
            for name,params in calls:
                # Fail loudly if the source API changes; do not substitute parameters.
                result=await client.call_tool(name,params)
                assert not result.is_error, result
                text="\n".join(getattr(c,"text","") for c in result.content)
                assert "❌" not in text,text
                print(name, "completed")
            genes=list(Path(tmp).glob("*gene*"))
            assert genes and any("TP53" in f.read_text() for f in genes)
            result=await client.call_tool("export_r_script",{
                "tool_name":"plot_oncoplot",
                "parameters":{"maf_path":str(fixture),"output_dir":tmp,"top":3},
                "output_dir":tmp,"script_basename":"synthetic_oncoplot"})
            assert not result.is_error,result
            assert (Path(tmp)/"synthetic_oncoplot.R").exists()
            print("R script export completed")

if __name__ == "__main__": asyncio.run(main())
