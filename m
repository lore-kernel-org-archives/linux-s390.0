Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFC3AF65A
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381549; cv=none; b=mZ/NsLO0Az2Hb9JIi+oXpiYPmgKo+D3NW71TaXBPuwg/86N08U/f46cGrUDSLKPcI3nQBFixri+8eAeGuG7dR/bjtb7ylrSpb54wTivUpQR3Mrs/VNiQrx8Thf4HIvc05KYF7AXgXxzd6t5a/pI6+HYK0kyIcqs7jQslaOiRQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381549; c=relaxed/simple;
	bh=LePQNqGvJ2A+ROpIEFl18sb1h+CnJ+2PiWF+y9+Y388=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6lzZPCkfOAqY/pt5RB8TtL/yzgDR+2yyO+mMoDyLwyqMmmShiaiW+nHV40uJkHY4oj4CfjsQ9JkqSzrzuHxd0DgTlsCxgTJeF2sd1QWofBE9ffriXdYpgJf6fgHB8w0SEdrxGnX257lkfDaLAekciPPEI9P8RFxYKHAHosTclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwbpy6qE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwbpy6qE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so8931634eec.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381546; x=1780986346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7R5sAqdverw0RxtQJ1e+c3ZDc+RMlk7YTjzX/tVENw=;
        b=Qwbpy6qENtngsfM0/4HnOni2WuBoikeWJHJ4IBEPJTBzN4qOOwOxFM8/jJ/JTuLojt
         S9K+jbGUB+tlqXexFCvpj4tUcOZVrNTH9FYLNvjvm9HG7zxqFFVeBxVXJKiY3i1fABIk
         3kb5Y4uG6x520SVAMiehI8ujeEGJh7/8Nf7Y0i4WPlD4/xw61faozjSobdkQTFTkD+DU
         Y1MLuTFUjM4cAQTmVPKOS6M/5c0Ny+b6XIFJM966Hin1RzL6XQjGHdEJgxnMjxdCRf7Z
         3ka1T5icOrziQHn/O+uAeJEqgU4SjPWUDrEsXptqvr6wqvDAjNaEecmj3FtxMHU1SHO5
         r4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381546; x=1780986346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7R5sAqdverw0RxtQJ1e+c3ZDc+RMlk7YTjzX/tVENw=;
        b=L6EkqsCmorT6YZXwpK6xKjPprVLT2bn0/aAKaN43ScrmaatWHg8kbxTluVRueVPodx
         3iVYAYCxVeaPO9T4aQ/QFBBjQsuEh+VstF3caLYAge3qplx/OcyI+FpUUGtI86ovLtyj
         Ft2v5Bcgamz/Uw9qyvC2au8oq2L5hujVJxbhi893Bqk8J79hSVrxjB2o+sH6XAyU7zQ6
         cZdSbJKEH3b0cOc4Ti7sAm5NWZ0iPH4WIJQTr6W9dl7TQ34Qw9iI/RC5Q6ynDX2Jf+/u
         LM6lH4I4RS5uEiQTxJ9bto4I0yhEaZJeNus4JUTt0dN3iTeM0+YZAn96V/xYagPCEGx7
         ZETg==
X-Forwarded-Encrypted: i=1; AFNElJ85uLm7SGsyf6k3aRNIivfRbVogHpLs/+S1ySS+iOATvKJtZgK2ky5Xek2aJai9fEPmQwlZAfjdCiqu@vger.kernel.org
X-Gm-Message-State: AOJu0YyEO8ezMi+26U7BP+pn9+POQpW/2mYnNjGCXDg/2ddlqgRxXHjs
	LkW8QaFYga0Drt86c944t7t9O/pwNsDm85mFB8wVKTAvA3DQpSkobZ2jBn4R6+eT1wwQz7ORY1L
	ZfItpzO25Fg==
X-Received: from dybbs37.prod.google.com ([2002:a05:7300:a225:b0:2f9:af7:504f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4312:b0:2ce:25be:c8e8
 with SMTP id 5a478bee46e88-304fa5a8b1amr7822170eec.17.1780381545916; Mon, 01
 Jun 2026 23:25:45 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:50 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-19-irogers@google.com>
Subject: [PATCH v11 18/19] perf symbol: Add setters for bitfields sharing a
 byte to avoid concurrent update issues
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

A problem with putting bitfields into struct symbol is that other bits in
the symbol could be updated concurrently and only one update to the
underlying storage unit happen, leading to lost updates.

To avoid this, use atomics to atomically read or set part of 16-bits
of flags in the symbol. Add accessors to simplify this.

The idle value has 3 values in preparation for a later change that
will lazily update it.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c                   | 10 +--
 tools/perf/builtin-kwork.c                    |  2 +-
 tools/perf/builtin-report.c                   |  2 +-
 tools/perf/builtin-sched.c                    |  4 +-
 tools/perf/builtin-top.c                      |  7 +-
 tools/perf/tests/symbols.c                    |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  2 +-
 tools/perf/ui/browsers/annotate.c             |  2 +-
 tools/perf/ui/browsers/map.c                  |  4 +-
 tools/perf/util/annotate.c                    |  5 +-
 tools/perf/util/auxtrace.c                    |  6 +-
 tools/perf/util/callchain.c                   |  4 +-
 tools/perf/util/dlfilter.c                    |  2 +-
 tools/perf/util/evsel_fprintf.c               |  6 +-
 tools/perf/util/intel-pt.c                    |  2 +-
 tools/perf/util/libdw.c                       |  2 +-
 tools/perf/util/machine.c                     |  2 +-
 tools/perf/util/probe-event.c                 |  4 +-
 .../util/scripting-engines/trace-event-perl.c |  2 +-
 .../scripting-engines/trace-event-python.c    |  4 +-
 tools/perf/util/sort.c                        |  8 +-
 tools/perf/util/srcline.c                     | 10 +--
 tools/perf/util/symbol-elf.c                  |  3 +-
 tools/perf/util/symbol.c                      | 86 +++++++++++++++----
 tools/perf/util/symbol.h                      | 78 +++++++++++++----
 tools/perf/util/symbol_fprintf.c              |  4 +-
 26 files changed, 183 insertions(+), 80 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d8cb1f562f69..75ffe31d03fe 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -549,13 +549,11 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 
 	node = cursor->first;
 	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
-		if (machine->single_address_space &&
-		    machine__kernel_ip(machine, node->ip))
-			/* kernel IPs were added already */;
-		else if (node->ms.sym && node->ms.sym->inlined)
-			/* we can't handle inlined callchains */;
-		else
+		if (!(machine->single_address_space &&
+		      machine__kernel_ip(machine, node->ip)) &&
+		    !(node->ms.sym && symbol__inlined(node->ms.sym))) {
 			inject->raw_callchain->ips[i++] = node->ip;
+		}
 
 		node = node->next;
 	}
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 99dc293a0744..77e87e75613d 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -769,7 +769,7 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 		if (sym) {
 			if (!strcmp(sym->name, "__softirqentry_text_start") ||
 			    !strcmp(sym->name, "__do_softirq"))
-				sym->ignore = 1;
+				symbol__set_ignore(sym, true);
 		}
 
 		callchain_cursor_advance(cursor);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 973d97af8501..b79001529d01 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -749,7 +749,7 @@ static int hists__resort_cb(struct hist_entry *he, void *arg)
 	struct report *rep = arg;
 	struct symbol *sym = he->ms.sym;
 
-	if (rep->symbol_ipc && sym && !sym->annotate2) {
+	if (rep->symbol_ipc && sym && !symbol__is_annotate2(sym)) {
 		struct evsel *evsel = hists_to_evsel(he->hists);
 
 		symbol__annotate2(&he->ms, evsel, NULL);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 812a1b0d56d6..b6da74c5befa 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2367,7 +2367,7 @@ static void save_task_callchain(struct perf_sched *sched,
 			if (!strcmp(sym->name, "schedule") ||
 			    !strcmp(sym->name, "__schedule") ||
 			    !strcmp(sym->name, "preempt_schedule"))
-				sym->ignore = 1;
+				symbol__set_ignore(sym, true);
 		}
 
 		callchain_cursor_advance(cursor);
@@ -3025,7 +3025,7 @@ static size_t callchain__fprintf_folded(FILE *fp, struct callchain_node *node)
 	list_for_each_entry(chain, &node->val, list) {
 		if (chain->ip >= PERF_CONTEXT_MAX)
 			continue;
-		if (chain->ms.sym && chain->ms.sym->ignore)
+		if (chain->ms.sym && symbol__ignore(chain->ms.sym))
 			continue;
 		ret += fprintf(fp, "%s%s", first ? "" : sep,
 			       callchain_list__sym_name(chain, bf, sizeof(bf),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c8474f7ac658..1211401616ee 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -186,8 +186,8 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 		    "Please report to linux-kernel@vger.kernel.org\n",
 		    ip, dso__long_name(dso), dso__symtab_origin(dso),
 		    map__start(map), map__end(map), sym->start, sym->end,
-		    sym->binding == STB_GLOBAL ? 'g' :
-		    sym->binding == STB_LOCAL  ? 'l' : 'w', sym->name,
+		    symbol__binding(sym) == STB_GLOBAL ? 'g' :
+		    symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w', sym->name,
 		    err ? "[unknown]" : uts.machine,
 		    err ? "[unknown]" : uts.release, perf_version_string);
 	if (use_browser <= 0)
@@ -828,7 +828,8 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		}
 	}
 
-	if (al.sym == NULL || !al.sym->idle) {
+	if (al.sym == NULL ||
+	    !symbol__is_idle(al.sym, al.map ? map__dso(al.map) : NULL, machine->env)) {
 		struct hists *hists = evsel__hists(sample->evsel);
 		struct hist_entry_iter iter = {
 			.sample 	= sample,
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index f4ffe5804f40..c09e04f36035 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -125,7 +125,7 @@ static int test_dso(struct dso *dso)
 	for (nd = rb_first_cached(dso__symbols(dso)); nd; nd = rb_next(nd)) {
 		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
 
-		if (sym->type != STT_FUNC && sym->type != STT_GNU_IFUNC)
+		if (symbol__type(sym) != STT_FUNC && symbol__type(sym) != STT_GNU_IFUNC)
 			continue;
 
 		/* Check for overlapping function symbols */
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 524d46478364..7409abe4aa36 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -346,7 +346,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 			 * such as __indirect_thunk_end.
 			 */
 			continue;
-		} else if (is_ignored_symbol(sym->name, sym->type)) {
+		} else if (is_ignored_symbol(sym->name, symbol__type(sym))) {
 			/*
 			 * Ignore hidden symbols, see scripts/kallsyms.c for the details
 			 */
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ea17e6d29a7e..e220c4dfc881 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1185,7 +1185,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 	if (dso__annotate_warned(dso))
 		return -1;
 
-	if (not_annotated || !sym->annotate2) {
+	if (not_annotated || !symbol__is_annotate2(sym)) {
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			annotate_browser__symbol_annotate_error(&browser, err);
diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index c61ba3174a24..075a575cdc5d 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -32,8 +32,8 @@ static void map_browser__write(struct ui_browser *browser, void *nd, int row)
 	ui_browser__set_percent_color(browser, 0, current_entry);
 	ui_browser__printf(browser, "%*" PRIx64 " %*" PRIx64 " %c ",
 			   mb->addrlen, sym->start, mb->addrlen, sym->end,
-			   sym->binding == STB_GLOBAL ? 'g' :
-				sym->binding == STB_LOCAL  ? 'l' : 'w');
+			   symbol__binding(sym) == STB_GLOBAL ? 'g' :
+				symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w');
 	width = browser->width - ((mb->addrlen * 2) + 4);
 	if (width > 0)
 		ui_browser__write_nstring(browser, sym->name, width);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 470569745abe..02505222d8c2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -236,7 +236,8 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
 	h = annotated_source__histogram(src, evsel);
 	if (h == NULL) {
 		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
-			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
+			 __func__, __LINE__, sym->name, sym->start, addr, sym->end,
+			 symbol__type(sym) == STT_FUNC);
 		return -ENOMEM;
 	}
 
@@ -2223,7 +2224,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 
 	annotation__init_column_widths(notes, sym);
 	annotation__update_column_widths(notes);
-	sym->annotate2 = 1;
+	symbol__set_annotate2(sym, true);
 
 	return 0;
 }
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index fcf564e0d777..5f4aa1701aef 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2694,7 +2694,7 @@ static bool dso_sym_match(struct symbol *sym, const char *name, int *cnt,
 {
 	/* Same name, and global or the n'th found or any */
 	return !arch__compare_symbol_names(name, sym->name) &&
-	       ((!idx && sym->binding == STB_GLOBAL) ||
+	       ((!idx && symbol__binding(sym) == STB_GLOBAL) ||
 		(idx > 0 && ++*cnt == idx) ||
 		idx < 0);
 }
@@ -2712,8 +2712,8 @@ static void print_duplicate_syms(struct dso *dso, const char *sym_name)
 		if (dso_sym_match(sym, sym_name, &cnt, -1)) {
 			pr_err("#%d\t0x%"PRIx64"\t%c\t%s\n",
 			       ++cnt, sym->start,
-			       sym->binding == STB_GLOBAL ? 'g' :
-			       sym->binding == STB_LOCAL  ? 'l' : 'w',
+			       symbol__binding(sym) == STB_GLOBAL ? 'g' :
+			       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
 			       sym->name);
 			near = true;
 		} else if (near) {
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5c2282051e39..8981ae879ebb 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -801,7 +801,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			 * symbol start. Otherwise do a faster comparison based
 			 * on the symbol start address.
 			 */
-			if (cnode->ms.sym->inlined || node->ms.sym->inlined) {
+			if (symbol__inlined(cnode->ms.sym) || symbol__inlined(node->ms.sym)) {
 				match = match_chain_strings(cnode->ms.sym->name,
 							    node->ms.sym->name);
 				if (match != MATCH_ERROR)
@@ -1245,7 +1245,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	int printed;
 
 	if (cl->ms.sym) {
-		const char *inlined = cl->ms.sym->inlined ? " (inlined)" : "";
+		const char *inlined = symbol__inlined(cl->ms.sym) ? " (inlined)" : "";
 
 		if (show_srcline && cl->srcline)
 			printed = scnprintf(bf, bfsize, "%s %s%s",
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index dc31b5e7149e..e11e144af62b 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -56,7 +56,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 			d_al->symoff = al->addr - map__start(al->map) - sym->start;
 		else
 			d_al->symoff = 0;
-		d_al->sym_binding = sym->binding;
+		d_al->sym_binding = symbol__binding(sym);
 	} else {
 		d_al->sym = NULL;
 		d_al->sym_start = 0;
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 5521d00bff2c..0f7a25500a44 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -146,7 +146,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			sym = node->ms.sym;
 			map = node->ms.map;
 
-			if (sym && sym->ignore && print_skip_ignored)
+			if (sym && symbol__ignore(sym) && print_skip_ignored)
 				goto next;
 
 			printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
@@ -182,7 +182,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				addr_location__exit(&node_al);
 			}
 
-			if (print_dso && (!sym || !sym->inlined))
+			if (print_dso && (!sym || !symbol__inlined(sym)))
 				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
 
 			if (print_srcline) {
@@ -192,7 +192,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 					printed += map__fprintf_srcline(map, addr, "\n  ", fp);
 			}
 
-			if (sym && sym->inlined)
+			if (sym && symbol__inlined(sym))
 				printed += fprintf(fp, " (inlined)");
 
 			if (!print_oneline)
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index b8add2b20033..56a9e439f5f8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3000,7 +3000,7 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	start = dso__first_symbol(map__dso(map));
 
 	for (sym = start; sym; sym = dso__next_symbol(sym)) {
-		if (sym->binding == STB_GLOBAL &&
+		if (symbol__binding(sym) == STB_GLOBAL &&
 		    !strcmp(sym->name, "__switch_to")) {
 			ip = map__unmap_ip(map, sym->start);
 			if (ip >= map__start(map) && ip < map__end(map)) {
diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
index 84713b2a7ad5..d5d2958902c0 100644
--- a/tools/perf/util/libdw.c
+++ b/tools/perf/util/libdw.c
@@ -130,7 +130,7 @@ static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
 	return 0;
 
 abort_delete_sym:
-	if (inline_sym->inlined)
+	if (symbol__inlined(inline_sym))
 		symbol__delete(inline_sym);
 abort_enomem:
 	args->err = -ENOMEM;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 47be7a44a5f7..da1ad58758af 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1095,7 +1095,7 @@ static u64 find_entry_trampoline(struct dso *dso)
 	unsigned int i;
 
 	for (; sym; sym = dso__next_symbol(sym)) {
-		if (sym->binding != STB_GLOBAL)
+		if (symbol__binding(sym) != STB_GLOBAL)
 			continue;
 		for (i = 0; i < ARRAY_SIZE(syms); i++) {
 			if (!strcmp(sym->name, syms[i]))
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 34b4badd2c14..11ae4a09412c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -416,7 +416,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 	map__for_each_symbol_by_name(map, pp->function, sym, idx) {
 		if (uprobes) {
 			address = sym->start;
-			if (sym->type == STT_GNU_IFUNC)
+			if (symbol__type(sym) == STT_GNU_IFUNC)
 				pr_warning("Warning: The probe function (%s) is a GNU indirect function.\n"
 					   "Consider identifying the final function used at run time and set the probe directly on that.\n",
 					   pp->function);
@@ -3189,7 +3189,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	for (j = 0; j < num_matched_functions; j++) {
 		sym = syms[j];
 
-		if (sym->type != STT_FUNC)
+		if (symbol__type(sym) != STT_FUNC)
 			continue;
 
 		/* There can be duplicated symbols in the map */
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 7a18ea4b7d50..410dc4cd0600 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -303,7 +303,7 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 			}
 			if (!hv_stores(sym, "start",   newSVuv(node->ms.sym->start)) ||
 			    !hv_stores(sym, "end",     newSVuv(node->ms.sym->end)) ||
-			    !hv_stores(sym, "binding", newSVuv(node->ms.sym->binding)) ||
+			    !hv_stores(sym, "binding", newSVuv(symbol__binding(node->ms.sym))) ||
 			    !hv_stores(sym, "name",    newSVpvn(node->ms.sym->name,
 								node->ms.sym->namelen)) ||
 			    !hv_stores(elem, "sym",    newRV_noinc((SV*)sym))) {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index cee1f32d7022..8f832ae316ca 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -436,7 +436,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 			pydict_set_item_string_decref(pysym, "end",
 					PyLong_FromUnsignedLongLong(node->ms.sym->end));
 			pydict_set_item_string_decref(pysym, "binding",
-					_PyLong_FromLong(node->ms.sym->binding));
+					_PyLong_FromLong(symbol__binding(node->ms.sym)));
 			pydict_set_item_string_decref(pysym, "name",
 					_PyUnicode_FromStringAndSize(node->ms.sym->name,
 							node->ms.sym->namelen));
@@ -1270,7 +1270,7 @@ static int python_export_symbol(struct db_export *dbe, struct symbol *sym,
 	tuple_set_d64(t, 1, dso__db_id(dso));
 	tuple_set_d64(t, 2, sym->start);
 	tuple_set_d64(t, 3, sym->end);
-	tuple_set_s32(t, 4, sym->binding);
+	tuple_set_s32(t, 4, symbol__binding(sym));
 	tuple_set_string(t, 5, sym->name);
 
 	call_object(tables->symbol_handler, t, "symbol_table");
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 90bc4a31bb55..005e7d85dc4a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -469,7 +469,7 @@ int64_t _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r)
 	if (sym_l == sym_r)
 		return 0;
 
-	if (sym_l->inlined || sym_r->inlined) {
+	if (symbol__inlined(sym_l) || symbol__inlined(sym_r)) {
 		int ret = strcmp(sym_l->name, sym_r->name);
 
 		if (ret)
@@ -536,7 +536,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
 	if (sym && map) {
-		if (sym->type == STT_OBJECT) {
+		if (symbol__type(sym) == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
 					ip - map__unmap_ip(map, sym->start));
@@ -544,7 +544,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
 					       width - ret,
 					       sym->name);
-			if (sym->inlined)
+			if (symbol__inlined(sym))
 				ret += repsep_snprintf(bf + ret, size - ret,
 						       " (inlined)");
 		}
@@ -1483,7 +1483,7 @@ static int _hist_entry__addr_snprintf(struct map_symbol *ms,
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
 	if (sym && map) {
-		if (sym->type == STT_OBJECT) {
+		if (symbol__type(sym) == STT_OBJECT) {
 			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
 			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
 					ip - map__unmap_ip(map, sym->start));
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 62884428fb5a..b082178c279b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -113,16 +113,16 @@ struct symbol *new_inline_sym(struct dso *dso,
 		/* ensure that we don't alias an inlined symbol, which could
 		 * lead to double frees in inline_node__delete
 		 */
-		assert(!base_sym->inlined);
+		assert(!symbol__inlined(base_sym));
 	} else {
 		/* create a fake symbol for the inline frame */
 		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
 					 base_sym ? (base_sym->end - base_sym->start) : 0,
-					 base_sym ? base_sym->binding : 0,
-					 base_sym ? base_sym->type : 0,
+					 base_sym ? symbol__binding(base_sym) : 0,
+					 base_sym ? symbol__type(base_sym) : 0,
 					 funcname);
 		if (inline_sym)
-			inline_sym->inlined = 1;
+			symbol__set_inlined(inline_sym, true);
 	}
 
 	free(demangled);
@@ -440,7 +440,7 @@ void inline_node__clear_frames(struct inline_node *node)
 		list_del_init(&ilist->list);
 		zfree_srcline(&ilist->srcline);
 		/* only the inlined symbols are owned by the list */
-		if (ilist->symbol && ilist->symbol->inlined)
+		if (ilist->symbol && symbol__inlined(ilist->symbol))
 			symbol__delete(ilist->symbol);
 		free(ilist);
 	}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 77e6dcba8fda..c5ed5e051976 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -350,7 +350,8 @@ static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
 	sym = dso__find_symbol_nocache(dso, addr);
 
 	/* Expecting the address to be an IFUNC or IFUNC alias */
-	if (!sym || sym->start != addr || (sym->type != STT_GNU_IFUNC && !sym->ifunc_alias))
+	if (!sym || sym->start != addr ||
+	    (symbol__type(sym) != STT_GNU_IFUNC && !symbol__ifunc_alias(sym)))
 		return false;
 
 	snprintf(buf, buf_sz, "%s@plt", sym->name);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 077d19af5240..ddd3106b03b1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -50,7 +50,7 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__is_idle(const char *name);
+static bool symbol__compute_is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
@@ -163,24 +163,24 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	else if ((a == 0) && (b > 0))
 		return SYMBOL_B;
 
-	if (syma->type != symb->type) {
-		if (syma->type == STT_NOTYPE)
+	if (symbol__type(syma) != symbol__type(symb)) {
+		if (symbol__type(syma) == STT_NOTYPE)
 			return SYMBOL_B;
-		if (symb->type == STT_NOTYPE)
+		if (symbol__type(symb) == STT_NOTYPE)
 			return SYMBOL_A;
 	}
 
 	/* Prefer a non weak symbol over a weak one */
-	a = syma->binding == STB_WEAK;
-	b = symb->binding == STB_WEAK;
+	a = symbol__binding(syma) == STB_WEAK;
+	b = symbol__binding(symb) == STB_WEAK;
 	if (b && !a)
 		return SYMBOL_A;
 	if (a && !b)
 		return SYMBOL_B;
 
 	/* Prefer a global symbol over a non global one */
-	a = syma->binding == STB_GLOBAL;
-	b = symb->binding == STB_GLOBAL;
+	a = symbol__binding(syma) == STB_GLOBAL;
+	b = symbol__binding(symb) == STB_GLOBAL;
 	if (a && !b)
 		return SYMBOL_A;
 	if (b && !a)
@@ -227,14 +227,14 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 			continue;
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
-			if (next->type == STT_GNU_IFUNC)
-				curr->ifunc_alias = true;
+			if (symbol__type(next) == STT_GNU_IFUNC)
+				symbol__set_ifunc_alias(curr, true);
 			rb_erase_cached(&next->rb_node, symbols);
 			symbol__delete(next);
 			goto again;
 		} else {
-			if (curr->type == STT_GNU_IFUNC)
-				next->ifunc_alias = true;
+			if (symbol__type(curr) == STT_GNU_IFUNC)
+				symbol__set_ifunc_alias(next, true);
 			nd = rb_next(&curr->rb_node);
 			rb_erase_cached(&curr->rb_node, symbols);
 			symbol__delete(curr);
@@ -322,8 +322,8 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 	sym->start   = start;
 	sym->end     = len ? start + len : start;
-	sym->type    = type;
-	sym->binding = binding;
+	atomic_init(&sym->flags, (type << SYMBOL_FLAG_TYPE_SHIFT) |
+				 (binding << SYMBOL_FLAG_BINDING_SHIFT));
 	sym->namelen = namelen - 1;
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
@@ -345,6 +345,49 @@ void symbol__delete(struct symbol *sym)
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
+void symbol__set_ignore(struct symbol *sym, bool ignore)
+{
+	if (ignore)
+		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_IGNORE);
+	else
+		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_IGNORE);
+}
+
+void symbol__set_annotate2(struct symbol *sym, bool annotate2)
+{
+	if (annotate2)
+		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_ANNOTATE2);
+	else
+		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_ANNOTATE2);
+}
+
+void symbol__set_inlined(struct symbol *sym, bool inlined)
+{
+	if (inlined)
+		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_INLINED);
+	else
+		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_INLINED);
+}
+
+void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias)
+{
+	if (ifunc_alias)
+		atomic_fetch_or(&sym->flags, SYMBOL_FLAG_IFUNC_ALIAS);
+	else
+		atomic_fetch_and(&sym->flags, ~SYMBOL_FLAG_IFUNC_ALIAS);
+}
+
+static void symbol__set_idle(struct symbol *sym, bool idle)
+{
+	uint16_t old_flags = atomic_load(&sym->flags);
+	uint16_t new_flags;
+	uint16_t idle_val = idle ? SYMBOL_IDLE__IDLE : SYMBOL_IDLE__NOT_IDLE;
+
+	do {
+		new_flags = old_flags & ~SYMBOL_FLAG_IDLE_MASK;
+		new_flags |= (idle_val << SYMBOL_FLAG_IDLE_SHIFT);
+	} while (!atomic_compare_exchange_weak(&sym->flags, &old_flags, new_flags));
+}
 void symbols__delete(struct rb_root_cached *symbols)
 {
 	struct symbol *pos;
@@ -375,7 +418,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 		 */
 		if (name[0] == '.')
 			name++;
-		sym->idle = symbol__is_idle(name);
+		symbol__set_idle(sym, symbol__compute_is_idle(name));
 	}
 
 	while (*p != NULL) {
@@ -717,11 +760,21 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
+bool symbol__is_idle(struct symbol *sym,
+		     const struct dso *dso __maybe_unused,
+		     struct perf_env *env __maybe_unused)
+{
+	uint16_t flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
+	uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
+
+	return idle_val == SYMBOL_IDLE__IDLE;
+}
+
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__is_idle(const char *name)
+static bool symbol__compute_is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
 		"acpi_idle_do_entry",
@@ -2492,6 +2545,7 @@ void symbol__exit(void)
 {
 	if (!symbol_conf.initialized)
 		return;
+
 	strlist__delete(symbol_conf.bt_stop_list);
 	strlist__delete(symbol_conf.sym_list);
 	strlist__delete(symbol_conf.dso_list);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 95592779eb77..16a27074a474 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdatomic.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
@@ -27,6 +28,7 @@ struct map;
 struct maps;
 struct option;
 struct build_id;
+struct perf_env;
 
 /*
  * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() logic.
@@ -58,6 +60,23 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
+enum symbol_idle_kind {
+	SYMBOL_IDLE__UNKNOWN = 0,
+	SYMBOL_IDLE__NOT_IDLE = 1,
+	SYMBOL_IDLE__IDLE = 2,
+};
+
+#define SYMBOL_FLAG_TYPE_SHIFT      0
+#define SYMBOL_FLAG_TYPE_MASK       (0xF << SYMBOL_FLAG_TYPE_SHIFT)
+#define SYMBOL_FLAG_BINDING_SHIFT   4
+#define SYMBOL_FLAG_BINDING_MASK    (0xF << SYMBOL_FLAG_BINDING_SHIFT)
+#define SYMBOL_FLAG_IDLE_SHIFT      8
+#define SYMBOL_FLAG_IDLE_MASK       (0x3 << SYMBOL_FLAG_IDLE_SHIFT)
+#define SYMBOL_FLAG_IGNORE          (1 << 10)
+#define SYMBOL_FLAG_INLINED         (1 << 11)
+#define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
+#define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
+
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
@@ -69,20 +88,7 @@ struct symbol {
 	u64		end;
 	/** Length of the string name. */
 	u16		namelen;
-	/** ELF symbol type as defined for st_info. E.g STT_OBJECT or STT_FUNC. */
-	u8		type:4;
-	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
-	u8		binding:4;
-	/** Set true for kernel symbols of idle routines. */
-	u8		idle:1;
-	/** Resolvable but tools ignore it (e.g. idle routines). */
-	u8		ignore:1;
-	/** Symbol for an inlined function. */
-	u8		inlined:1;
-	/** Has symbol__annotate2 been performed. */
-	u8		annotate2:1;
-	/** Symbol is an alias of an STT_GNU_IFUNC */
-	u8		ifunc_alias:1;
+	_Atomic uint16_t flags;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
@@ -92,6 +98,49 @@ struct symbol {
 void symbol__delete(struct symbol *sym);
 void symbols__delete(struct rb_root_cached *symbols);
 
+static inline u8 symbol__type(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_TYPE_MASK) >> SYMBOL_FLAG_TYPE_SHIFT;
+}
+
+static inline u8 symbol__binding(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_BINDING_MASK) >> SYMBOL_FLAG_BINDING_SHIFT;
+}
+
+static inline bool symbol__ignore(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_IGNORE) != 0;
+}
+
+static inline bool symbol__inlined(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_INLINED) != 0;
+}
+
+static inline bool symbol__is_annotate2(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_ANNOTATE2) != 0;
+}
+
+static inline bool symbol__ifunc_alias(const struct symbol *sym)
+{
+	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
+		SYMBOL_FLAG_IFUNC_ALIAS) != 0;
+}
+
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
+
+void symbol__set_ignore(struct symbol *sym, bool ignore);
+void symbol__set_annotate2(struct symbol *sym, bool annotate2);
+void symbol__set_inlined(struct symbol *sym, bool inlined);
+void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
+
 /* symbols__for_each_entry - iterate over symbols (rb_root)
  *
  * @symbols: the rb_root of symbols
@@ -169,7 +218,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size);
 bool filename__has_section(const char *filename, const char *sec);
 
-struct perf_env;
 int symbol__init(struct perf_env *env);
 void symbol__exit(void);
 void symbol__elf_init(void);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index 53e1af4ed9ac..4dc8d5761f52 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -11,8 +11,8 @@ size_t symbol__fprintf(struct symbol *sym, FILE *fp)
 {
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %c %s\n",
 		       sym->start, sym->end,
-		       sym->binding == STB_GLOBAL ? 'g' :
-		       sym->binding == STB_LOCAL  ? 'l' : 'w',
+		       symbol__binding(sym) == STB_GLOBAL ? 'g' :
+		       symbol__binding(sym) == STB_LOCAL  ? 'l' : 'w',
 		       sym->name);
 }
 
-- 
2.54.0.929.g9b7fa37559-goog

