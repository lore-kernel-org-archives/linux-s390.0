Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37240F8E3
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659635; cv=none; b=XtnVmpczc3d26SnoF1/dB4SoFJ5utThfTVqlt/8LnDT9YrV9aiTKBxM4dZ3z2Gp3jaBRwko1yx2yqv77emqOj50V8vqytnFpR2Cjy8Up7kf4oZw7WuliooNjy6ogsZ/wEvIlvb8+AOGUfjIqBlL+91/uZwLy/HUSXSQqlSFVKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659635; c=relaxed/simple;
	bh=jSVLm/hnBbimnPznGWy7hEl7PRSNrGRNHmI3giDWJ48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i616f4m19WNswtGsFTJEATcgWlnh8pRkdOdH3lBzI0aB860xTuPYYHETNhbzjgp3Yv7K3OMROlRW1KAkGBBLd8U8vvczUiJx72/R88R6sikCRYgoGXsTSulhPuffUxLd+sYQoq+H6D5bLuCRdHu2HPIIx99aZUVNORGyk8qWM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYjhck1Q; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYjhck1Q"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4055so3646982c88.1
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659633; x=1778264433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsujg9g6KcaFNFnJNN1/Y10jrPhP9zpCu+VlfQAKK4Y=;
        b=pYjhck1QovBlAPHXlzfzMGrtum7XOj3HBOQsjF5+/3e/yXbnRoUf8M0Xxfv6i6xJr2
         tWX6Msux1/Kka40v0hO3KRou2V2LcGqPfvZAAxN7TjHytQoXcZ05mDowM1vPlBbXeSmm
         j8zXmAkKgubsL8l4XSd/B4OqIlxKWlNhM4eQjyawhgkZRD7TxfNjOmqNgtrTU3aKeeJ3
         d7INZQ49lWw7nigp7M33mAiP8vRVCL5hDHu0wG4DjOmq3311EM3yQZUs2TQkYTF9T3y8
         08eRVJHNyPDNuYE4AcQ68/HStdYDO/neA8ZQ3tzEU3tPf1F7ps1tA6qAR2IxY1db3EdL
         aasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659633; x=1778264433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsujg9g6KcaFNFnJNN1/Y10jrPhP9zpCu+VlfQAKK4Y=;
        b=FzPCSZLD9RH0Y0SN5hsx/EsA7u2imHpy2W3oeNAkgDj2a9RtxyS+ZlsSsCRFN+0Hho
         9vq+GjujdP6j/NtiIcr/Ovf4GCspacrfKBIGamr5tscDWo0k2NPvTwLnOZwqy4rvmCt2
         2+rbvZ5ZZFejvE8AXv5a+rDp7GfxCiqUHkJFVeo4MW6HD2dc1NDF92dlhr942zYCMoMN
         yxKfZDW+Qoo2LOP1WEPIeBCKH9MryXZuovsh6HI7HWFPhUTTCXZWscEeH9VA8bfbVyM4
         9VG9eoVcDyivMhjo1cvpioJKDpssU7He37sTHXI+oIXQfOdFswypAkSgacWKjYRmBfTx
         ocxg==
X-Forwarded-Encrypted: i=1; AFNElJ9zFWxtn3RX/CvFKGFkQOevmVJw42DcIpZh67qA0sJ0wwSTRAktmHPxRQgyW0pKGzu3g2aHvcdefC+I@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr6uUo4KhyYO2GYxsHm2LJ5CM3J9oPHvSmRi5jLUiX7Qj5ufQ
	CwYSRH/cfBNs9Y1Sf/3Br8IYa+88cLsrXk9PquXxWP4VRDuB/BfZXIU0HHMJ0XLiEKX0RM8d2aa
	lc25Vbjm24w==
X-Received: from dleb6-n1.prod.google.com ([2002:a05:701b:4246:10b0:12a:9ef0:93ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:427:b0:12b:ec15:69d2
 with SMTP id a92af1059eb24-12dfd8622dcmr180034c88.33.1777659632579; Fri, 01
 May 2026 11:20:32 -0700 (PDT)
Date: Fri,  1 May 2026 11:20:20 -0700
In-Reply-To: <20260501182021.3651851-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260501182021.3651851-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501182021.3651851-4-irogers@google.com>
Subject: [PATCH v7 3/4] perf symbol: Add setters for bitfields sharing a byte
 to avoid concurrent update issues
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
index fd332db56157..e6a1f23634ec 100644
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
@@ -2398,6 +2415,8 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
+	mutex_init(&symbol_bits_lock);
+
 	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
 
 	symbol__elf_init();
@@ -2476,6 +2495,9 @@ void symbol__exit(void)
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

