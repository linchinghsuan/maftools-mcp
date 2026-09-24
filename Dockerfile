# Release image built by overlaying the public source onto the
# author-packaged, immutable runtime image. The base digest fixes the complete
# Python/R runtime, including R 4.5.0 and maftools 2.26.0.
FROM lin97/maftools-mcp@sha256:2e3be5b768c9f77cbe942207025987fc4d39d4cc7a39563ea0fc159de9cf1b4b

WORKDIR /app
ENV RPY2_CFFI_MODE=ABI

# Keep the runtime from the pinned base image and replace only the server
# source with the version tracked in this repository.
COPY src/maftools_mcp/server.py /app/server.py

EXPOSE 8000

ENTRYPOINT ["fastmcp", "run", "server.py"]
CMD ["--transport", "stdio"]
