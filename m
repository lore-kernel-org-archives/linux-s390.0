Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE03B19B4
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381550; cv=none; b=EcDxbHh1JU1+SW9ue7/RTGCU6CRbiGaf25eoxbTgt2DNLwcJPK3HkgwD1gzKlpbnpCI7bZyPqFoLuQliw100W/ef61YZn92diRzLv1cf4u7aXwS7uU8GfOYsgCjc/wUisSw3aJl23D0ZrvVJuxAnVqdrYsOjHlOcLoaHC/3KuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381550; c=relaxed/simple;
	bh=gthxRtD5VEATbV+0nsoc/5x3IeZxemKQBzZozOhGM4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jo3BQTuEzCuHRlb2cHtTSLEsY9kc4pC294BRkaRsHGv0liYglUsk9RE/UA/h0lvAwTuRNM/tbSHke+8+w5FOI/q33CBdqnVbHaxAvV++cGQZw/iyuIMxI4l5o11WfZGwJUpToED5IFc6mQxSO8pzcsT55mwnuRWknwCgV3o1/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAknzgqW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAknzgqW"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3041ab826ddso18573165eec.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381548; x=1780986348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyqcFhrF9yKP3hkIxQRO9vNVLIIWlwktE1+hfye7zWw=;
        b=DAknzgqWSc93/tz/eYHFOh8QL7OWqQCTh4LOagDl14HBGEzojVg2xhGhZl2KzoZY+8
         9002L6FXMYL0dA+/0T5DdMM/uy3GoVGAhFSxiQ+gkqo0xb37ibjQrhW5mdOhVufGs79i
         n3rwjrQeTPFyT3BHZZ853UWT+0FreUmU3yEZ8WpyYcUeT2UBrFLiyAMgO4QL9CHQG7dV
         +3Aza3s1opK/O4iCA215AWSVNnn75aCNdHqS2ulQ3VZLjCS7wN6jjYDpfJ/4FsQSFaKR
         VN+uWyIOk9qxm3Q1zYpIQsYF5EFLG5irGOInwtWXxJun14RE/OOpoMHe7fbVrC3yz6MP
         49BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381548; x=1780986348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyqcFhrF9yKP3hkIxQRO9vNVLIIWlwktE1+hfye7zWw=;
        b=lVqvUlu5mqlEwclXeu3l0DHZVynsUKOjLsLZahzdW7lG2U1mhB1mH+Q5zRscnM2KDS
         +la0O8p1nDviBFW14soH9u1DtuVl9wp9L2zIUnuIldwdyHpe2gh+vIA/j0LyiDKL5pjs
         FQIjjwQRE/JWzJunBxzRZImNMwyQa6kKJnT4wAhjszlwTD/qQC0+qelce/Ib3ezPpNEI
         zOotNsdqMhuF0nt/BCL6iQsYee2pPzzo7c/9TBbtkUcs4z04WshyPUIFRm5uwZnBHLkL
         fwn5Iqkxp3+71zDRypsah3CxMxjN3O/KBGdhhuiWpkAXGKfvQ1u5T9XDrve3u3BnnTMT
         P2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EycoOvI1PJ8B46DYDlooUfyOc3NsDFPIyU9MOlbjcYMpCX5AMuOm8jKiQrtQUkpuDXnIktuJG9x76@vger.kernel.org
X-Gm-Message-State: AOJu0YxTneSkuzZurBGUuX0YXI/XHPLwezkzuGOBYw0nEK70W/hdAEkz
	PjUpSvAAe/wg0s+OgKpeFVYDsm2OZNlpRIdLA9QB0wseAB8axYbC+RUUj0Uho4ihd/Tbwsrd+Ux
	yd/Q4XqQfiQ==
X-Received: from dyclw21.prod.google.com ([2002:a05:693c:2115:b0:304:3262:502a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da3:b0:304:997c:d47a
 with SMTP id 5a478bee46e88-304fa4eded0mr6081789eec.10.1780381547885; Mon, 01
 Jun 2026 23:25:47 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:51 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-20-irogers@google.com>
Subject: [PATCH v11 19/19] perf symbol: Lazily compute idle
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from an idle boolean to a helper symbol__is_idle function. In
the function lazily compute whether a symbol is an idle function
taking into consideration the kernel version and architecture of the
machine. As symbols__insert no longer needs to know if a symbol is for
the kernel, remove the argument.

To protect against drop-filtering of legitimate setup, online, or hotplug
management functions (such as intel_idle_init), x86 matches are strictly
constrained to exact known run-loops (intel_idle, intel_idle_irq,
mwait_idle, mwait_idle_with_hints).

If the target environment OS release is unresolvable (such as on guest
traces), default to treating psw_idle as idle to prevent false
negatives and match legacy trace behavior safely.

This change is inspired by mailing list discussion, particularly from
Thomas Richter <tmricht@linux.ibm.com> and Heiko Carstens
<hca@linux.ibm.com>:
https://lore.kernel.org/lkml/20260219113850.354271-1-tmricht@linux.ibm.com/

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 146 +++++++++++++++++++++++------------
 tools/perf/util/symbol.h     |   4 +-
 3 files changed, 100 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c5ed5e051976..186e6d92ac3d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1734,7 +1734,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 		arch__sym_update(f, &sym);
 
-		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
+		__symbols__insert(dso__symbols(curr_dso), f);
 		nr++;
 	}
 	dso__put(curr_dso);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ddd3106b03b1..0c46b24ee098 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -50,7 +50,6 @@
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
-static bool symbol__compute_is_idle(const char *name);
 
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
@@ -379,7 +378,7 @@ void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias)
 
 static void symbol__set_idle(struct symbol *sym, bool idle)
 {
-	uint16_t old_flags = atomic_load(&sym->flags);
+	uint16_t old_flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
 	uint16_t new_flags;
 	uint16_t idle_val = idle ? SYMBOL_IDLE__IDLE : SYMBOL_IDLE__NOT_IDLE;
 
@@ -401,8 +400,7 @@ void symbols__delete(struct rb_root_cached *symbols)
 	}
 }
 
-void __symbols__insert(struct rb_root_cached *symbols,
-		       struct symbol *sym, bool kernel)
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
 	struct rb_node **p = &symbols->rb_root.rb_node;
 	struct rb_node *parent = NULL;
@@ -410,17 +408,6 @@ void __symbols__insert(struct rb_root_cached *symbols,
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
-		symbol__set_idle(sym, symbol__compute_is_idle(name));
-	}
-
 	while (*p != NULL) {
 		parent = *p;
 		s = rb_entry(parent, struct symbol, rb_node);
@@ -437,7 +424,7 @@ void __symbols__insert(struct rb_root_cached *symbols,
 
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym)
 {
-	__symbols__insert(symbols, sym, false);
+	__symbols__insert(symbols, sym);
 }
 
 static struct symbol *symbols__find(struct rb_root_cached *symbols, u64 ip)
@@ -598,7 +585,7 @@ void dso__reset_find_symbol_cache(struct dso *dso)
 
 void dso__insert_symbol(struct dso *dso, struct symbol *sym)
 {
-	__symbols__insert(dso__symbols(dso), sym, dso__kernel(dso));
+	__symbols__insert(dso__symbols(dso), sym);
 
 	/* update the symbol cache if necessary */
 	if (dso__last_find_result_addr(dso) >= sym->start &&
@@ -760,57 +747,120 @@ int modules__parse(const char *filename, void *arg,
 	return err;
 }
 
-bool symbol__is_idle(struct symbol *sym,
-		     const struct dso *dso __maybe_unused,
-		     struct perf_env *env __maybe_unused)
-{
-	uint16_t flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
-	uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
-
-	return idle_val == SYMBOL_IDLE__IDLE;
-}
 
 /*
  * These are symbols in the kernel image, so make sure that
  * sym is from a kernel DSO.
  */
-static bool symbol__compute_is_idle(const char *name)
+static int sym_name_cmp(const void *a, const void *b)
+{
+	const char *name = a;
+	const char *const *sym = b;
+
+	return strcmp(name, *sym);
+}
+
+static bool match_x86_idle_routine(const char *name, const char *base)
 {
-	const char * const idle_symbols[] = {
+	if (strstarts(name, base)) {
+		size_t len = strlen(base);
+
+		if (name[len] == '\0' || name[len] == '.')
+			return true;
+	}
+	return false;
+}
+
+bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env)
+{
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
+	uint16_t e_machine;
 
-	if (idle_symbols_list)
-		return strlist__has_entry(idle_symbols_list, name);
+	{
+		uint16_t flags = atomic_load_explicit(&sym->flags, memory_order_relaxed);
+		uint16_t idle_val = (flags & SYMBOL_FLAG_IDLE_MASK) >> SYMBOL_FLAG_IDLE_SHIFT;
 
-	idle_symbols_list = strlist__new(NULL, NULL);
+		if (idle_val != SYMBOL_IDLE__UNKNOWN)
+			return idle_val == SYMBOL_IDLE__IDLE;
+	}
 
-	for (i = 0; idle_symbols[i]; i++)
-		strlist__add(idle_symbols_list, idle_symbols[i]);
+	if (!dso || dso__kernel(dso) == DSO_SPACE__USER) {
+		symbol__set_idle(sym, /*idle=*/false);
+		return false;
+	}
+
+	/*
+	 * ppc64 uses function descriptors and appends a '.' to the
+	 * start of every instruction address. Remove it.
+	 */
+	if (name[0] == '.')
+		name++;
+
+	if (bsearch(name, idle_symbols, ARRAY_SIZE(idle_symbols),
+		    sizeof(idle_symbols[0]), sym_name_cmp)) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
+
+	e_machine = (env && env->arch) ? perf_env__e_machine(env, NULL) : EM_NONE;
+	if (e_machine == EM_NONE && dso)
+		e_machine = dso__e_machine((struct dso *)dso, NULL, NULL);
+	if (e_machine == EM_NONE && env)
+		e_machine = perf_env__e_machine(env, NULL);
+
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		if (match_x86_idle_routine(name, "intel_idle") ||
+		    match_x86_idle_routine(name, "intel_idle_irq") ||
+		    match_x86_idle_routine(name, "intel_idle_ibrs") ||
+		    match_x86_idle_routine(name, "mwait_idle") ||
+		    match_x86_idle_routine(name, "mwait_idle_with_hints")) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+	}
+
+	if (e_machine == EM_PPC64 && !strcmp(name, "ppc64_runlatch_off")) {
+		symbol__set_idle(sym, /*idle=*/true);
+		return true;
+	}
+
+	if (e_machine == EM_S390 && strstarts(name, "psw_idle")) {
+		int major = 0, minor = 0;
+		const char *release = env ? perf_env__os_release(env) : NULL;
 
-	return strlist__has_entry(idle_symbols_list, name);
+		/*
+		 * If we can't determine the release (e.g. unpopulated guest traces),
+		 * default to idle.
+		 */
+		if (!release) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+
+		/* Before v6.10, s390 used psw_idle. */
+		if (sscanf(release, "%d.%d", &major, &minor) == 2 &&
+		    (major < 6 || (major == 6 && minor < 10))) {
+			symbol__set_idle(sym, /*idle=*/true);
+			return true;
+		}
+	}
+
+	symbol__set_idle(sym, /*idle=*/false);
+	return false;
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
@@ -839,7 +889,7 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
 	 * We will pass the symbols to the filter later, in
 	 * map__split_kallsyms, when we have split the maps per module
 	 */
-	__symbols__insert(root, sym, !strchr(name, '['));
+	__symbols__insert(root, sym);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 16a27074a474..a71525335703 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -76,7 +76,6 @@ enum symbol_idle_kind {
 #define SYMBOL_FLAG_INLINED         (1 << 11)
 #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
 #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
-
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
  * symbol__annotation) and/or a browser_index (see symbol__browser_index).
@@ -257,8 +256,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
 
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
-void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym,
-		       bool kernel);
+void __symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
 void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
-- 
2.54.0.929.g9b7fa37559-goog

