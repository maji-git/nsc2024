FROM ubuntu:22.04

ARG GODOT_VERSION="4.2.1"

# Install Godot & templates
RUN apt update -y \
    && apt install -y wget unzip \
    && wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.arm64.zip \
    && wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mkdir -p ~/.cache ~/.config/godot ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && unzip Godot_v${GODOT_VERSION}-stable_linux*.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux*64 /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable \
    && rm Godot_v${GODOT_VERSION}-stable_export_templates.tpz Godot_v${GODOT_VERSION}-stable_linux*.zip

# Build application
WORKDIR /app

ENTRYPOINT [ "godot" ]

COPY . .
RUN mkdir -p build/linux \
    && godot -v --export-release "Linux/X11" --headless ./build/linux/game.x86_64

# MARK: Runner
FROM ubuntu:22.04
RUN apt update -y \
    && apt install -y expect-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/build/linux/ /app

# Unbuffer output so the logs get flushed
CMD ["sh", "-c", "unbuffer /app/game.x86_64 --verbose --headless -- --server | cat"]