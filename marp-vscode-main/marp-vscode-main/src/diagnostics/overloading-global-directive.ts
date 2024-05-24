import { Diagnostic, DiagnosticSeverity, Range, TextDocument } from 'vscode'
import type { Pair } from 'yaml'
import { DirectiveParser, DirectiveType } from '../directives/parser'

interface ParsedGlobalDirective {
  item: Pair
  range: Range
}

export const code = 'overloading-global-directive'

export function register(
  doc: TextDocument,
  directiveParser: DirectiveParser,
  diagnostics: Diagnostic[],
) {
  const parsedGlobalDirectives = new Map<string, ParsedGlobalDirective[]>()

  directiveParser.on('startParse', () => {
    parsedGlobalDirectives.clear()
  })

  directiveParser.on('directive', ({ item, offset, info }) => {
    if (info?.type === DirectiveType.Global && item.key.range) {
      const [start] = item.key.range
      const [, end] = item.value?.range ?? item.key.range

      parsedGlobalDirectives.set(info.name, [
        ...(parsedGlobalDirectives.get(info.name) ?? []),
        {
          item,
          range: new Range(
            doc.positionAt(start + offset),
            doc.positionAt(end + offset),
          ),
        },
      ])
    }
  })

  directiveParser.on('endParse', () => {
    for (const key of parsedGlobalDirectives.keys()) {
      const parsed = parsedGlobalDirectives.get(key) ?? []

      if (parsed.length >= 2) {
        const lastIdx = parsed.length - 1

        for (let i = 0; i < lastIdx; i += 1) {
          const diagnostic = new Diagnostic(
            parsed[i].range,
            `The ${key} global directive may be overloaded the subsequent definition.`,
            DiagnosticSeverity.Warning,
          )

          diagnostic.source = 'marp-vscode'
          diagnostic.code = code

          diagnostics.push(diagnostic)
        }
      }
    }
  })
}
