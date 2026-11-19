---
name: make-diagram
description: Produce a minimalist, light-themed flow or architecture diagram (rendered with Graphviz, shaped to fit a 16:9 slide) and/or a sequence diagram (rendered with D2), using a handful of pastel boxes with thin dark borders, plain black arrows and short labels, delivered as PDF plus slide-ready JPEG/PNG
---

## 1. Check prerequisites first

- Run `command -v dot && dot -V` before anything else. Flow and architecture diagrams need Graphviz
- Only when a sequence diagram is needed, also run `command -v d2 && d2 --version`
- If a tool is missing, warn me straight away, before you start designing the diagram:
  - say which one is missing and give the install command: `brew install graphviz` or `brew install d2`
  - for D2, mention that the first PDF export downloads a headless Chromium through Playwright, which needs network access
  - do not continue until I confirm it is installed
- Check the font with `fc-list | grep -i "helvetica neue"`. If it is missing, use `Helvetica` everywhere the template says `Helvetica Neue`

## 2. Understand what to draw

- Start from the subject I give you; if I gave none, ask me for it
- Explore the codebase, infrastructure files or docs whenever they can answer better than I can. For database tables, read the migrations and schemas to find the few columns that matter to the flow
- When other Claude sessions own the neighbouring services, ask them through SendMessage for the exact calls, queues, S3 keys and triggers, with file:line references, instead of guessing
- Decide which diagrams are needed:
  - **flow / architecture**: components and the flows between them, drawn with Graphviz
  - **sequence**: the ordered messages exchanged between participants for one scenario, drawn with D2
  - both, when I ask for both or when one alone would not explain the subject
- Ask me only about what you cannot find

## 3. Write the source

- Write sources in `$TMPDIR`, never in the current directory or the repository. They are intermediate files: do not persist them anywhere else unless I explicitly ask for it
- Make one source file per diagram:
  - flow / architecture: a `.dot` file. Start by copying `template.dot` from this skill's directory verbatim, add the content below it, and close the graph with `}`
  - sequence: a `.d2` file. Start by copying `template.d2` verbatim, then add the content below it
- Give every node the attributes of its kind and every edge the look of its class, exactly as in the tables below, so the same kind of component always looks the same everywhere
- If a component fits none of the kinds, pick the closest one rather than inventing a style

### Style: minimalist

The diagram must look clean and quiet: pastel fills, thin near-black borders, plain black arrows, regular text. Do not add:

- a title or a legend: the colours are self-explanatory once the diagram is read
- zones or nested containers, unless grouping is essential to understand the subject; then use one level of `group`
- monospace, code spans, colour-coded protocols, ports tables or markdown tables

### Node kinds

| Kind         | Use for                                                         | Graphviz attributes (on top of the template defaults)                                  | D2 class     |
|--------------|-----------------------------------------------------------------|-----------------------------------------------------------------------------------------|--------------|
| `entry`      | Where the flow starts: upstream or third-party system, trigger  | `fillcolor="#A5D8FF"`                                                                   | `entry`      |
| `process`    | Our service, worker, job, function, step that does something    | `fillcolor="#FFEC99"`                                                                   | `process`    |
| `data`       | Table, database, bucket, queue, cache: anything that holds data | `fillcolor="#B2F2BB"`                                                                   | `data`       |
| `decision`   | Branch in the flow                                              | `shape=diamond, style=filled, fillcolor="#FFC9C9"`                                      | `decision`   |
| `human`      | User, role, or the UI a human acts through                      | `fillcolor="#D0BFFF"`                                                                   | `human`      |
| `background` | Safety net, cron, fallback mechanism, out-of-band actor         | `style="filled,dashed", fillcolor="#F1F3F5"`                                            | `background` |
| `group`      | Optional grouping, only when essential                          | `subgraph cluster_<name> { style="rounded,dashed"; color="#ADB5BD"; fontcolor="#495057"; fontsize=12; label="..." }` | `group`      |

The single footnote is not a node in Graphviz: see the note under Layout.

### Edge classes

| Class       | Use for                                                        | Graphviz        | D2                   |
|-------------|----------------------------------------------------------------|-----------------|----------------------|
| `flow`      | Every main step, call, write or enqueue                        | template default | `{class: flow}`      |
| `secondary` | Safety net, read-only access, reference, optional or rare path | `style=dashed`  | `{class: secondary}` |

### Labels in Graphviz

- Node labels are HTML-like labels: a bold name on the first line, then at most three or four short lines of plain detail, often in parentheses. End every line with `<BR ALIGN="LEFT"/>` so the text is left-aligned:
    ```
    workers [fillcolor="#FFEC99", label=<<B>Record workers</B><BR ALIGN="LEFT"/>(one Oban job per SQS message:<BR ALIGN="LEFT"/>RecordMetadata, RecordOrigin...)<BR ALIGN="LEFT"/>>];
    ```
- For a table, put its name in bold, an empty line (`<BR ALIGN="LEFT"/><BR ALIGN="LEFT"/>`), then only the two or three columns the flow relies on, written as plain text (`id = receipt_id`, `status = pending`)
- For a step that does several things, put the name in bold, an empty line, then one `• ` bullet line per action
- A one-line label is just `label=<<B>Name</B>>`
- Escape `&`, `<` and `>` inside HTML labels as `&amp;`, `&lt;` and `&gt;`
- Edge labels are plain quoted strings with `\n` line breaks: lowercase plain phrases of a few words, e.g. `"upsert row\n(per column group)"`. Leave an edge unlabelled when the arrow speaks for itself
- When the order of operations matters, prefix each edge label with its step number (`"7a. request\n(file.dcm URI)"`), use the same number with letters for steps that run in parallel, and explain the numbering in the note
- When one service reads or writes storage, draw one arrow per reader or writer and name the file kinds on it (`"8a. read file.dcm"`). Point read arrows from the reader to the store too, so every arrow follows the call direction
- Write names as they appear in the code, without backticks, and use `→` for chains (`study → series → instance`)

### Layout: fit a 16:9 slide

- Aim for a drawing close to 16:9 (about 1.8:1), so it fills a slide without large blank bands. A long left-to-right chain ends up 4:1 or wider and leaves most of the slide empty
- Lay the diagram out in a few explicit rows with `rankdir=TB`. Fill each row with a `{ rank=same; a; b; c; }` group, for instance:
    - entry points and the first service
    - the central service
    - the services it calls
    - the stores they read and write
- Order the nodes inside a row with invisible edges (`a -> b -> c [style=invis];`) so that each node sits above or below the nodes it talks to
- Add `constraint=false` to arrows that go back up or across: results, callbacks, pushes, reads from a store in the same row. Without it, every return arrow adds a row
- Keep `rankdir=LR` only for a short chain that already fits 16:9, and use the same `rank=same` and `constraint=false` tools there to stack boxes into columns
- Merge components that always appear together and add nothing on their own, e.g. four related tables into one `data` node: `<B>patient · dicom_study ·</B><BR ALIGN="LEFT"/>dicom_series · dicom_instance`. Fold a sidecar into its host when it only adds width (`sonio-uplink + Orthanc`)
- Fold rules and invariants into one short note under the drawing, as plain sentences. Make it the graph label, not a node: a node sits in a row and widens it. Use this as a graph attribute, which keeps a gap above the dashed box:
    ```
    graph [labelloc=b, labeljust=c, label=<<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0"><TR><TD HEIGHT="24"></TD></TR><TR><TD><TABLE BORDER="1" STYLE="dashed" COLOR="#868E96" BGCOLOR="#F1F3F5" CELLPADDING="10" CELLSPACING="0"><TR><TD ALIGN="LEFT"><FONT POINT-SIZE="12" COLOR="#495057">First sentence.<BR ALIGN="LEFT"/>Second sentence.<BR ALIGN="LEFT"/></FONT></TD></TR></TABLE></TD></TR></TABLE>>];
    ```

### Sequence diagrams (D2)

- Set `shape: sequence_diagram` on the root, and give each participant the class of its kind from the table above
- Order participants left to right as they first appear in the scenario
- Use `flow` for messages and `secondary` for anything not awaited
- Use groups for `alt`, `opt` and `loop` blocks, and `note` for short annotations
- In a D2 markdown label, never write the `…` character: D2 drops the whole line it sits on. Write `...` instead. Always give a markdown label a class, or D2 renders it as bare text with no box
- D2 cannot reshape a flow diagram into rows: it ignores `direction` inside containers with ELK and dagre, and refuses `top`/`left` positions. Do not use it for flow diagrams

## 4. Render and check

- Render a preview and measure its shape:
    ```
    dot -Tpng -Gdpi=96 "$TMPDIR/<name>.dot" -o "$TMPDIR/<name>-preview.png"
    python3 -c "import struct,sys; f=open(sys.argv[1],'rb'); f.read(16); w,h=struct.unpack('>II',f.read(8)); print(w,h,round(w/h,2))" "$TMPDIR/<name>-preview.png"
    ```
- For a sequence diagram: `d2 --elk-nodeNodeBetweenLayers 60 --elk-edgeNodeBetweenLayers 20 "$TMPDIR/<name>.d2" "$TMPDIR/<name>.png" --scale 1.5`
- Read the preview and check it critically:
  - no overlapping labels or shapes, no edge label sitting on another one or hidden behind a box, no clipped or missing text
  - no needless edge crossings or long detours
  - a shape close to 16:9, with no large empty areas
  - every node and edge has the look of its kind
- Fix and re-render until all checks pass:
  - too wide: move nodes into fewer rows, add `constraint=false` to return arrows, or raise `ranksep`
  - too tall: lower `ranksep`, or put more nodes in a row
  - crossings: reorder a row with invisible edges

## 5. Deliver

- Export the final files in `$TMPDIR`:
  - PDF: `dot -Tpdf "$TMPDIR/<name>.dot" -o "$TMPDIR/<name>.pdf"`
  - JPEG and PNG for slides, as large as possible under the 25-megapixel limit of Google Slides (a larger image is rejected or misbehaves). Render at high resolution, then downscale with Pillow:
    ```
    dot -Tpng -Gdpi=340 "$TMPDIR/<name>.dot" -o "$TMPDIR/<name>-hi.png"
    UV_CACHE_DIR="$TMPDIR/uv-cache" uv run --quiet --no-project --with pillow python -I -c "
    import math, sys
    from PIL import Image
    Image.MAX_IMAGE_PIXELS = None
    src, out = sys.argv[1], sys.argv[2]
    im = Image.open(src).convert('RGB')
    ratio = im.height / im.width
    w = math.floor(math.sqrt(24_900_000 / ratio))
    h = round(w * ratio)
    im = im.resize((w, h), Image.LANCZOS)
    im.save(out + '.jpg', quality=92, optimize=True)
    im.save(out + '.png', optimize=True)
    " "$TMPDIR/<name>-hi.png" "$TMPDIR/<name>"
    ```
  - In the sandbox, `sips` cannot write its temporary files and uv's default cache is not writable: that is why the command above uses Pillow and `UV_CACHE_DIR="$TMPDIR/uv-cache"`
- Copy the PDF, JPEG and PNG to the current directory, named `<kebab-case-title>.<ext>`, unless I asked for another place. Recommend the JPEG for Google Slides. Leave the sources and previews in `$TMPDIR`, unless I explicitly asked to keep the source
- When I want the diagram in Google Slides and no Google connector is available, deliver the files and tell me to insert the JPEG through Insert → Image → Upload from computer
- Give me the paths, and list any assumption you made about components or flows I did not confirm
