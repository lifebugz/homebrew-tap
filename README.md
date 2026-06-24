# homebrew-tap

A [Homebrew](https://brew.sh) tap for [`ccpz`](https://github.com/lifebugz/ccpluginizer) — the CLI that pluginizes non-plugin Claude Code repos. Source, docs, and issues live in the [main repo](https://github.com/lifebugz/ccpluginizer).

## Install

```bash
brew install lifebugz/tap/ccpz
```

or:

```bash
brew tap lifebugz/tap
brew install ccpz
```

## Supported platforms

| Platform | Supported |
|----------|-----------|
| macOS arm64 (Apple Silicon) | ✅ |
| Linux x64 | ✅ |
| Linux arm64 | ✅ |
| macOS Intel (x64) | ❌ |
| Windows | ❌ |

On **Intel macOS** or **Windows**, install via Bun instead:

```bash
bun add -g @ccpluginizer/ccpz
```

Windows users can also download the `windows-x64` native binary from the
[releases page](https://github.com/lifebugz/ccpluginizer/releases). See the
[main repo](https://github.com/lifebugz/ccpluginizer) for all install paths.

## Usage

```bash
ccpz validate <entry>    # Validate an entry / dir / array against the schema
ccpz scan <owner/repo>   # Generate a marketplace entry (heavier; interactive/LLM-capable)
```

## Note

`Formula/ccpz.rb` is auto-generated on each `ccpz` release. **Do not hand-edit it** —
changes are overwritten by CI.
