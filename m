Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BF39B979
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547132; cv=none; b=nQlR2iceYwUnXdUJDeitlBDHW/nt7nWQunloU+QJmnBKzUBjBaaNnPs4HMEuG9788Yo/LrVZZk9078+nXK21WRzimi9HIFSGtMfdgQbrabZzgnjI80cUDLVw1Gks99HvqjaDv5f5awGgrBH+GR6peoeVEYb0hXSSGQvJPBuYXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547132; c=relaxed/simple;
	bh=bqRgx5Rzlc/W3YsT8D5UcYBWGN+L7iAfdFcrs8Pd5mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=McISPYly6okGcrzTBCHkp6uZkj7P1f5vDAlRumXToL/Dm5i2atul/Sy2Hbl8YfjbfJCl+3MrAvJopMg4asOOzBoAkZS3HHgJzhHruq/Kpx7crgYGHQ3FLMMy34xXN+2/3LNvydGJ3zkUBYN+QvZAxcN6up21T+lW9v5D5LwYPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWzm7u53; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWzm7u53"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0bddb9196so808778eec.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547129; x=1775151929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3q6omvrQJ3lloWqzdf8ZnTA5HGIAkIdMH0mfiYyoG0=;
        b=TWzm7u53SluscaiVvsyXI4kg3lOGGnn05b439LfLRyPdIVuqhf13ahUNZt8z0kTMyX
         ntWlikEmm4I+SZi0sTD3LsTjz+NPUujITty2XHEK4GNBoz7M8W2RCP9E76K7xO95UWEl
         591bYoWhF5iSD7UhWCzaUA/qFNwt1ObGwqjSuDwDVdktk0F2i3DUe0VP0Z2Hc7g9uQ4V
         ZyOr8XV2IjLmaD/vt0QAyCsGzfwSXx5elB5mXwm6/hmASYkJTTnJysBJmxfRf/xr+Ygx
         tfvBA+Ep4WqeDzSsHVjVjOMBqpedcN5E/wQcn9o7XF1PSCgZ0tu1YX+rFr91PnP/Rkb1
         c6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547129; x=1775151929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3q6omvrQJ3lloWqzdf8ZnTA5HGIAkIdMH0mfiYyoG0=;
        b=jAnw3TWmXqF2qNNYUcIjpCzimlNJ4fq2b1hFkkerErkBZRx/8Mtoa6G8h9OzvZJNI8
         1Y2h2LvuAyvaq4ZHEyVuYp4Rmxuito2tnAnNeY6JSQ2OB+eP32h4My75hITAVb47Re2w
         STXHmA/DmJC+u9pDshOaFgT3EidiunDHxPCvyXtSldBiAPeqQqGyT32u5ny9/T59DCa+
         8/AChS9rOfpbeNskCjo6EnYfIgCJLNK3GIf9sJnZyS+AU26KSqulchxz2sOzdsOOL4Ly
         AAzuPuBxjbySgBZEq/dapnI6xia/i7fFqJR3cVb1rQCGYak2FZna7gmYtFyQtZFzFvFY
         vc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/qkla4JJG+35q0eYe5B5m2AQKpXpm1ZZSdH165v1gtK/qpHSEre6YzdRsRJqZJ8BNSefBbbIBtLh/@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXRTxeqoyIbNjQhvH7gcieA45vn6HS3rrdta8CdFa6OvygK1y
	ZS14tCAE2LTwCgmbiu8MHIHZM2h9q7SXoBWz4yPorUR/qqZfQ/T6H6suhBknxwYGPCjzCkY72OI
	bEOdAdSymow==
X-Received: from dycal9.prod.google.com ([2002:a05:7301:1c89:b0:2c1:718d:bd7f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cac8:b0:2c1:23d:c728
 with SMTP id 5a478bee46e88-2c15d452a21mr4856434eec.31.1774547129223; Thu, 26
 Mar 2026 10:45:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:45:21 -0700
In-Reply-To: <20260326174521.1829203-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVJVc8uvPssSnUyTdO9PSbKy9qb0PrrE7VLUurwTa6MpQ@mail.gmail.com>
 <20260326174521.1829203-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174521.1829203-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf symbol: Lazily compute idle and use the perf_env
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Move the idle boolean to a helper symbol__is_idle function. In the
function lazily compute whether a symbol is an idle function taking
into consideration the kernel version and architecture of the
machine. As symbols__insert no longer needs to know if a symbol is for
the kernel, remove the argument.

This change is inspired by mailing list discussion, particularly from
Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
<hca@linux.ibm.com>:
https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.com/

The change switches x86 matches to use strstarts which means
intel_idle_irq is matched as part of strstarts(name, "intel_idle"), a
change suggested by Honglei Wang <jameshongleiwang@126.com> in:
https://lore.kernel.org/lkml/20260323085255.98173-1-jameshongleiwang@126.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c     |   6 +-
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 105 ++++++++++++++++++++++-------------
 tools/perf/util/symbol.h     |  15 +++--
 4 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 37950efb28ac..bdc1c761cd61 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -751,6 +751,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 {
 	struct perf_top *top = container_of(tool, struct perf_top, tool);
 	struct addr_location al;
+	struct dso *dso = NULL;
 
 	if (!machine && perf_guest) {
 		static struct intlist *seen;
@@ -830,7 +831,10 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		}
 	}
 
-	if (al.sym == NULL || !al.sym->idle) {
+	if (al.map)
+		dso = map__dso(al.map);
+
+	if (al.sym == NULL || !symbol__is_idle(al.sym, dso, machine->env)) {
 		struct hists *hists = evsel__hists(evsel);
 		struct hist_entry_iter iter = {
 			.evsel		= evsel,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3cd4e5a03cc5..9fabf5146d89 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1723,7 +1723,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ce9195717f44..92bc28934f36 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -25,6 +25,8 @@
 #include "demangle-ocaml.h"
 #include "demangle-rust-v0.h"
 #include "dso.h"
+#include "dwarf-regs.h"
+#include "env.h"
 #include "util.h" // lsdir()
 #include "event.h"
 #include "machine.h"
@@ -50,7 +52,6 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
@@ -357,8 +358,7 @@ void symbols__delete(struct rb_root_cached *symbols)
 	}
 }
 
-void __symbols__insert(struct rb_root_cached *symbols,
-		       struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -366,17 +366,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
 	struct symbol *s;
 	bool leftmost = true;
 
-	if (kernel) {
-		const char *name = sym->name;
-		/*
-		 * ppc64 uses function descriptors and appends a '.' to the
-		 * start of every instruction address. Remove it.
-		 */
-		if (name[0] == '.')
-			name++;
-		sym->idle = symbol__is_idle(name);
-	}
-
 	while (*p != NULL) {
 		parent = *p;
 		s = rb_entry(parent, struct symbol, rb_node);
@@ -393,7 +382,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym, false);
+	__symbols__insert(symbols, sym);
 }
 
 static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
@@ -554,7 +543,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
+	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
 	if (dso__last_find_result_addr(dso) >= sym->start &&
@@ -716,47 +705,87 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
+static int sym_name_cmp(const void *a, const void *b)
+{
+	const char *name = a;
+	const char *const *sym = b;
+
+	return strcmp(name, *sym);
+}
+
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__is_idle(const char *name)
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env)
 {
-	const char * const idle_symbols[] = {
+	static const char * const idle_symbols[] = {
 		"acpi_idle_do_entry",
 		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
-		"idle_cpu",
-		"intel_idle",
-		"intel_idle_ibrs",
 		"default_idle",
-		"native_safe_halt",
 		"enter_idle",
 		"exit_idle",
-		"mwait_idle",
-		"mwait_idle_with_hints",
-		"mwait_idle_with_hints.constprop.0",
+		"idle_cpu",
+		"native_safe_halt",
 		"poll_idle",
-		"ppc64_runlatch_off",
 		"pseries_dedicated_idle_sleep",
-		"psw_idle",
-		"psw_idle_exit",
-		NULL
 	};
-	int i;
-	static struct strlist *idle_symbols_list;
+	const char *name = sym->name;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	if (sym->idle)
+		return sym->idle == SYMBOL_IDLE__IDLE;
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		sym->idle = SYMBOL_IDLE__NOT_IDLE;
+		return false;
+	}
 
-	for (i = 0; idle_symbols[i]; i++)
-		strlist__add(idle_symbols_list, idle_symbols[i]);
+	/*
+	 * ppc64 uses function descriptors and appends a '.' to the
+	 * start of every instruction address. Remove it.
+	 */
+	if (name[0] == '.')
+		name++;
 
-	return strlist__has_entry(idle_symbols_list, name);
+	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
+		    sizeof(idle_symbols[0]), sym_name_cmp)) {
+		sym->idle = SYMBOL_IDLE__IDLE;
+		return true;
+	}
+
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		if (strstarts(name, "mwait_idle") ||
+		    strstarts(name, "intel_idle")) {
+			sym->idle = SYMBOL_IDLE__IDLE;
+			return true;
+		}
+	}
+
+	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
+		sym->idle = SYMBOL_IDLE__IDLE;
+		return true;
+	}
+
+	if (e_machine == EM_S390) {
+		int major = 0, minor = 0;
+		const char *release = env && env->os_release
+			? env->os_release : perf_version_string;
+
+		sscanf(release, "%d.%d", &major, &minor);
+
+		/* Before v6.10, s390 used psw_idle. */
+		if ((major < 6 || (major == 6 && minor < 10)) && strstarts(name, "psw_idle")) {
+			sym->idle = SYMBOL_IDLE__IDLE;
+			return true;
+		}
+	}
+
+	sym->idle = SYMBOL_IDLE__NOT_IDLE;
+	return false;
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
@@ -785,7 +814,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c67814d6d6d6..65422c1c8fdb 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -25,6 +25,7 @@ struct dso;
 struct map;
 struct maps;
 struct option;
+struct perf_env;
 struct build_id;
 
 /*
@@ -42,6 +43,12 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 			     GElf_Shdr *shp, const char *name, size_t *idx);
 #endif
 
+enum symbol_idle_kind {
+	SYMBOL_IDLE__UNKNOWN = 0,
+	SYMBOL_IDLE__NOT_IDLE = 1,
+	SYMBOL_IDLE__IDLE = 2,
+};
+
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
@@ -57,8 +64,8 @@ struct symbol {
 	u8		type:4;
 	/** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
 	u8		binding:4;
-	/** Set true for kernel symbols of idle routines. */
-	u8		idle:1;
+	/** Cache for symbol__is_idle. */
+	enum symbol_idle_kind idle:2;
 	/** Resolvable but tools ignore it (e.g. idle routines). */
 	u8		ignore:1;
 	/** Symbol for an inlined function. */
@@ -202,8 +209,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
@@ -286,5 +292,6 @@ enum {
 };
 
 int symbol__validate_sym_arguments(void);
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
 
 #endif /* __PERF_SYMBOL */
-- 
2.53.0.1018.g2bb0e51243-goog

