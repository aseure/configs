---
name: make-diagram
description: Produce a compact, horizontal, light-themed, high-contrast architecture diagram and/or sequence diagram as a PDF, rendered with D2 using rectangles only and a fixed colour code for each kind of component
---

## 1. Check prerequisites first

- Run `command -v d2 && d2 --version` before anything else
- If `d2` is missing, warn me straight away, before you start designing the diagram:
  - say it is missing and give the install command: `brew install d2`
  - mention that the first PDF export downloads a headless Chromium through Playwright, which needs network access
  - do not continue until I confirm it is installed
- If `d2` is older than `0.7`, warn me that the legend (`vars.d2-legend`) needs `0.7` or newer and suggest `brew upgrade d2`

## 2. Understand what to draw

- Start from the subject I give you; if I gave none, ask me for it
- Explore the codebase, infrastructure files or docs whenever they can answer better than I can. For database tables, read the migrations and schemas to get the columns, their types, and which ones the change adds or modifies
- Decide which diagrams are needed:
  - **architecture**: components, the zones they live in, and the flows between them
  - **sequence**: the ordered messages exchanged between participants for one scenario
  - both, when I ask for both or when one alone would not explain the subject
- Ask me only about what you cannot find: missing components, protocols, ports, ownership of zones

## 3. Write the D2 source

- Write the `.d2` source in `$TMPDIR`, never in the current directory or the repository. It is an intermediate file: do not persist it anywhere else unless I explicitly ask for it
- Make one `.d2` file per diagram. Start each one by copying `template.d2` from this skill's directory verbatim, then add the content below it
- Give every shape and every connection a class from the tables below. Never set `shape` or `style` inline, so the same kind of component always looks the same everywhere
- If a component fits none of the kinds, tell me and suggest a new class to add to `template.d2` rather than improvising a style

### Shapes: rectangles only, colour carries the meaning

Every component is a rectangle. Never use any other D2 shape (no cylinder, diamond, hexagon, person, queue, page…), nor `sql_table`.

- **Rounded corners** mean something active, that runs or decides
- **Square corners** mean something passive, that holds or carries data
- **The colour** tells the kind

| Class      | Corners | Use for                                            | Colour (fill / border) |
|------------|---------|----------------------------------------------------|------------------------|
| `service`  | Rounded | Our application, API, container, server, UI, step  | White / blue           |
| `external` | Rounded | Third-party or customer-owned system               | White / slate          |
| `actor`    | Rounded | Human user, role                                   | Grey / dark slate      |
| `gateway`  | Rounded | Load balancer, firewall, VPN gateway, API gateway  | Green                  |
| `job`      | Rounded | Batch job, cron, worker, serverless function       | Indigo                 |
| `decision` | Rounded | Branch in a flow                                   | Yellow                 |
| `terminal` | Rounded | Start or end of a flow                             | Dark, white text       |
| `database` | Square  | Database, table (monospace font)                   | Blue                   |
| `bucket`   | Square  | Object storage bucket, file share                  | Red                    |
| `queue`    | Square  | Queue, topic, stream, event bus                    | Purple                 |
| `cache`    | Square  | Cache, in-memory store                             | Teal                   |
| `document` | Square  | File, report, message payload (monospace font)     | White / slate          |
| `note`     | Square  | Annotation, caveat                                 | Pale yellow, dashed    |

### Zones (containers)

| Class               | Use for                                        | Look                                |
|---------------------|------------------------------------------------|-------------------------------------|
| `zone-internal`     | Customer or on-premises network                | Light grey fill, grey border        |
| `zone-owned`        | Our cloud, our platform, our VPC               | Light blue fill, blue border        |
| `zone-third-party`  | Vendor or partner cloud, SaaS                  | Light amber fill, amber border      |
| `zone-public`       | The internet, any untrusted network            | White fill, dashed grey border      |
| `zone-isolated`     | Sub-network, tenant isolation, group of tables | Near-white fill, dashed blue border |
| `stack`             | Invisible wrapper used only for grid layout    | Transparent, no label               |

### Connections

| Class      | Use for                                                       | Look                 |
|------------|---------------------------------------------------------------|----------------------|
| `flow-1`…`flow-5` | One class per protocol or channel family, assigned in that order (e.g. DICOM → `flow-1`, HL7 → `flow-2`, web → `flow-3`) | Solid, blue, gold, dark slate, purple, orange |
| `internal` | Sync write or call inside one trusted zone                    | Thin slate           |
| `async`    | Asynchronous message, event, job enqueue, callback            | Dashed purple        |
| `tunnel`   | VPN or encrypted tunnel                                       | Dashed green         |
| `optional` | Safety net, foreign key, read only, optional or rare path     | Thin dashed grey     |

Keep a protocol on the same `flow-N` class across every diagram of the same subject.

### Monospace for literal strings

Write every hardcoded string in monospace: enum values, table and column names, file names, bucket and queue names, module and function names, SQL, commands, paths.

- Use a markdown label, `|md ...|`, and wrap each literal in backticks: ``persist: |md **Persist**<br/>sets `auto_resolved`| {class: service}``. Backticks in a plain quoted label are not rendered
- Use `<br/>` for line breaks inside a markdown label
- Separate a code span from the following words with ` · `, otherwise D2 swallows the space between them
- When a markdown label ends with a code span, add `&nbsp;&nbsp;&nbsp;&nbsp;` after it, otherwise D2 clips its last characters
- Always give a markdown label a class: without one, D2 renders it as bare text with no box

### Database tables

Draw each table as a `database` node holding a markdown table of its columns with their types. Delimit the block with `|||md` and `|||`, since a single `|` clashes with the table pipes.

- Which columns to list:
  - a table with fewer than 10 columns: all of them
  - a larger table: its primary key, then every column the change adds or modifies, then a last row `… N more columns`
  - in every case, every added or modified column, whatever the table size
- One row per column, in schema order. The type cell carries constraints: `PK`, `FK <table>`, `UNIQUE`, `NULL`, `NOT NULL`
- Rows can group `inserted_at, updated_at` into one, and list composite unique indexes as a last `UNIQUE` row
- Put **in bold** every column, constraint or type the change being drawn adds or modifies, and nothing else. Suffix the name of a new table with ` · new`, and bold all its rows
- When some columns are bold, add "**bold** = new or modified column" to the footnote
- Note any type you inferred rather than read from a migration, and tell me in step 5

```
receipt: |||md
  **dicom_receipt** · new

  | column | type |
  |:--|:--|
  | **id** | **uuid PK** |
  | **status** | **dicom_receipt_status_t** |
||| {class: database}
```

- Group related tables in a `zone-isolated` container with `grid-columns: N` and `grid-gap: 12`, rather than leaving them for ELK to place. Wrap each grid cell in a `stack` container so a short table is not stretched to the height of the tallest one, and give a `stack` `grid-rows: 2` to pile two short tables in one column
- Never name a container `left`, `right`, `top`, `bottom` or another D2 reserved word: use `col1`, `col2`…

### Layout: horizontal and compact

- Always lay diagrams out horizontally: `direction: right`, zones from left to right in the order traffic flows (users → public → ours). Never switch to `direction: down` to save width
- ELK ignores `direction` set on containers; set it only at the root
- Keep labels short: a bold name, then at most two short lines of detail
- Edge labels: when there is a ports table, prefix them with its reference letter, e.g. `"A · DICOM C-STORE · TCP 4001"`
- Merge components that always appear together and add nothing on their own, e.g. seven similar queues into one `queue` node listing their names
- Never nest zones more than two levels deep, not counting `stack` wrappers
- Fold rules and invariants into one short footnote markdown block with `near: bottom-center`, rather than separate notes
- Add a title with `title: |md # <Title>| {near: top-center}`
- Add a legend through `vars.d2-legend` that lists only the classes the diagram actually uses. Give the endpoints of each legend connection the `legend-anchor` class, with an empty label, so they stay invisible:
    ```
    a: "" {class: legend-anchor}
    b: "" {class: legend-anchor}
    a -> b: DICOM {class: flow-1}
    ```
- For architecture diagrams with several protocols, add a ports and protocols table as a markdown block placed with `near: bottom-center`, with columns `Ref`, `Flow`, `Protocol`, `Port`, `Opened by`, `Path`

### Sequence diagrams

- Set `shape: sequence_diagram` on the root or on a container, and give each participant the class of its kind from the table above
- Order participants left to right as they first appear in the scenario
- Use the connection classes for messages, `async` for anything not awaited
- Use groups for `alt`, `opt` and `loop` blocks, and `note` for short annotations

## 4. Render and check

- Render with these flags, which tighten ELK's default spacing:
    ```
    d2 --elk-nodeNodeBetweenLayers 30 --elk-edgeNodeBetweenLayers 12 \
      --elk-padding "[top=36,left=12,bottom=12,right=12]" \
      "$TMPDIR/<name>.d2" "$TMPDIR/<name>.pdf"
    ```
- PDF is the default output. Produce SVG or PNG only when I ask, by changing the output extension
- Check the result critically. A wide diagram is too small to judge from the PDF alone: also render a PNG with `--scale 1.5` in `$TMPDIR` and read it in vertical slices (for instance cropped with Pillow through `uv run --with pillow`):
  - no overlapping labels or shapes, no edge label hidden behind a box, no clipped text
  - no needless edge crossings or long detours
  - no large empty areas; the diagram must be compact
  - every element has a class and the legend matches what is drawn
- Fix and re-render until all checks pass, trying `layout-engine: dagre` in `vars.d2-config` if ELK keeps producing a poor layout

## 5. Deliver

- Copy only the PDF to the current directory, named `<kebab-case-title>.pdf`, unless I asked for another place. Leave the `.d2` source and previews in `$TMPDIR`, unless I explicitly asked to keep the source
- Give me the path, and list any assumption you made about components, flows or column types I did not confirm
