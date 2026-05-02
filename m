Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E030C37C
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705227; cv=none; b=cjuYtrwWZSTbHS+5x0nG9OGOGp9eWUv5Cw2ptuAa5g6FTG+0jNm76u8AFZGxCBZDA4+UwMLjO2yiy3LXAEi6hDkUgP3SGFrZzZdkIepTf8ZY7eU5OIKiBSqdlbRhMO6hU7U1TTC0+29MZsMETHC3tUUnKcJ4WLn3bxUM0FBSxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705227; c=relaxed/simple;
	bh=e50vFh5CtVG9SREdkTT0BsWzZhta1RpinQipbQGGIFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZCgfYh7qGciXOWLrCyZDJHRpZTrcFaiO+sVg/6JLkf3998EsMcC7eSMdQB/ot+CX5t4RerqXV+Ihw35Fn5azERY7/MV+AFfNJc4s2tCsNsGzSJa2vxEOKuOF/j86X0wx3cr5eCvi1LoeNnMYvbShiYBL5MLNa/z1IJs2mUBI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STDZlq8Y; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STDZlq8Y"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfe12d285so848551c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705226; x=1778310026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RF7v439oBV6NmA50N3VhlP4B8A7joANfIGq/pVDUv7U=;
        b=STDZlq8YR1PyqbKhKYB7XIn0Ib9QaOeHSRv2+7PJfnez2low4QQl25Pq6HIF6oLTNI
         m6ehYo2vclf0AUDg9cJzS4YiT20ZqJkPklB4pcq6mwldFyOtiVAqVO2anOTN2PvGVu3Z
         yfPB3EUWek58KfSPdehXfN9yCdQ7ecFWeydSTqMwGAwNiTdp7cm3L98yKEptzv3hCXE9
         O3Pvt8jl6HQngnaKVTdksLPvE0sNVpbDQQAhKAOc809rofzQJNFz64a2lV6htv0e9Itz
         O6SKZpixSo7W93qLrv0KVKTcwWJsHDinQu9V0QsbyzZR9L1SctyqKT9zPw83d9YQWzo2
         pZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705226; x=1778310026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF7v439oBV6NmA50N3VhlP4B8A7joANfIGq/pVDUv7U=;
        b=BvCoWBbOrGHK826G+9x/FoT1jC8KVlhH/vJqxo08ILKYEtPML61Fi4WbKfIDMj6elI
         xWpwP3Lrl/xC/RqGdVI7oHugcm9rB6MS416R/G1DfTqx44zQMRyxkrYbpyQ83+L2CrNv
         mFcMzerSFvylL91DdsENhwuJ6iptw6mHRzT0N8wJKLGartDSL++NgzYWyDxAptt6eWUG
         QPsNKQ5LaRTL8L5gUwr3beyMgTqH376dK6T2nxl7tYXr89iO2Orcb6O146+gpGUSrQse
         fVxI3RmipyMsdfXeYcP2g7qBob1zo2Sbkx3xeBYd3ESDhGdFHPnR3kRzk7yNgvlZ/LxT
         g1fg==
X-Forwarded-Encrypted: i=1; AFNElJ9WmpnklEqQxAKIbX6m/Vs+Utalm9JPVFVXb78LidxwkwM83HhDKcfFdEleiNIKXXvNxzgBosHd2vKa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2o6E0LzkCVTX9QxN0pqv/LZbFhu0P4ZaZE7Ey1+TRqcpQvry
	8InwiGRsL/xPlMNE6DtmOYJcXzMLKZdFG9s2FIZb+8Eqw1WGwKwyCaU6xy41NcaJDtVTpnqr+pp
	nEBX3eS91xQ==
X-Received: from dlea11-n1.prod.google.com ([2002:a05:701b:420b:10b0:12d:b26a:1571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a7:b0:12c:8e70:c33b
 with SMTP id a92af1059eb24-12dfd7b7eddmr1133051c88.8.1777705225422; Sat, 02
 May 2026 00:00:25 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:34 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-17-irogers@google.com>
Subject: [PATCH v8 16/17] perf symbol: Add setters for bitfields sharing a
 byte to avoid concurrent update issues
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

A problem with putting bitfields into struct symbol is that other bits in
the symbol could be updated concurrently and only one update to the
underlying storage unit happen, leading to lost updates.

To avoid this, introduce a global lock `symbol_bits_lock` in `symbol.c`
and helper functions to update the bits sharing a byte:
`symbol__set_ignore` and `symbol__set_annotate2`.

`inlined` is not given a setter as it is only initialized in
`new_inline_sym` when the symbol is under construction and not shared.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c |  2 +-
 tools/perf/builtin-sched.c |  2 +-
 tools/perf/util/annotate.c |  2 +-
 tools/perf/util/symbol.c   | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h   |  3 +++
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 9d3a4c779a41..7337ee956dc9 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -725,7 +725,7 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 		if (sym) {
 			if (!strcmp(sym->name, "__softirqentry_text_start") ||
 			    !strcmp(sym->name, "__do_softirq"))
-				sym->ignore = 1;
+				symbol__set_ignore(sym, true);
 		}
 
 		callchain_cursor_advance(cursor);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..655e95f660c2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2371,7 +2371,7 @@ static void save_task_callchain(struct perf_sched *sched,
 			if (!strcmp(sym->name, "schedule") ||
 			    !strcmp(sym->name, "__schedule") ||
 			    !strcmp(sym->name, "preempt_schedule"))
-				sym->ignore = 1;
+				symbol__set_ignore(sym, true);
 		}
 
 		callchain_cursor_advance(cursor);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e745f3034a0e..d550a0061159 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2224,7 +2224,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 
 	annotation__init_column_widths(notes, sym);
 	annotation__update_column_widths(notes);
-	sym->annotate2 = 1;
+	symbol__set_annotate2(sym, true);
 
 	return 0;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a70066d17729..1238a0d6ce6e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -31,6 +31,7 @@
 #include "map.h"
 #include "symbol.h"
 #include "map_symbol.h"
+#include "mutex.h"
 #include "mem-events.h"
 #include "mem-info.h"
 #include "symsrc.h"
@@ -52,6 +53,8 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
+static struct mutex symbol_bits_lock;
+
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
@@ -345,6 +348,20 @@ void symbol__delete(struct symbol *sym)
 	free(((void *)sym) - symbol_conf.priv_size);
 }
 
+void symbol__set_ignore(struct symbol *sym, bool ignore)
+{
+	mutex_lock(&symbol_bits_lock);
+	sym->ignore = ignore;
+	mutex_unlock(&symbol_bits_lock);
+}
+
+void symbol__set_annotate2(struct symbol *sym, bool annotate2)
+{
+	mutex_lock(&symbol_bits_lock);
+	sym->annotate2 = annotate2;
+	mutex_unlock(&symbol_bits_lock);
+}
+
 void symbols__delete(struct rb_root_cached *symbols)
 {
 	struct symbol *pos;
@@ -2415,6 +2432,8 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
+	mutex_init(&symbol_bits_lock);
+
 	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
 
 	symbol__elf_init();
@@ -2493,6 +2512,9 @@ void symbol__exit(void)
 {
 	if (!symbol_conf.initialized)
 		return;
+
+	mutex_destroy(&symbol_bits_lock);
+
 	strlist__delete(symbol_conf.bt_stop_list);
 	strlist__delete(symbol_conf.sym_list);
 	strlist__delete(symbol_conf.dso_list);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bd6eb90c8668..5d98d7e84d57 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -77,6 +77,9 @@ struct symbol {
 void symbol__delete(struct symbol *sym);
 void symbols__delete(struct rb_root_cached *symbols);
 
+void symbol__set_ignore(struct symbol *sym, bool ignore);
+void symbol__set_annotate2(struct symbol *sym, bool annotate2);
+
 /* symbols__for_each_entry - iterate over symbols (rb_root)
  *
  * @symbols: the rb_root of symbols
-- 
2.54.0.545.g6539524ca2-goog

