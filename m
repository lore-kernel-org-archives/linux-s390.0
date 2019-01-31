Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v3 7/7] perf tools: Remove PMU::set_drv_config API
Date: Thu, 31 Jan 2019 11:47:14 -0700
Message-Id: <20190131184714.20388-8-mathieu.poirier@linaro.org>
In-Reply-To: <20190131184714.20388-1-mathieu.poirier@linaro.org>
References: <20190131184714.20388-1-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: acme@kernel.org, peterz@infradead.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, will.deacon@arm.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

CoreSight was the only client of the PMU's set_drv_config() API.  Now
that it is no longer needed by CoreSight remove it from the code base.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/builtin-record.c   | 10 -----
 tools/perf/builtin-stat.c     |  9 ----
 tools/perf/builtin-top.c      | 13 ------
 tools/perf/util/Build         |  1 -
 tools/perf/util/drv_configs.c | 78 -----------------------------------
 tools/perf/util/drv_configs.h | 26 ------------
 tools/perf/util/pmu.h         |  1 -
 7 files changed, 138 deletions(-)
 delete mode 100644 tools/perf/util/drv_configs.c
 delete mode 100644 tools/perf/util/drv_configs.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..b637c37b8479 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -23,7 +23,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/symbol.h"
@@ -566,7 +565,6 @@ static int record__open(struct record *rec)
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
-	struct perf_evsel_config_term *err_term;
 	int rc = 0;
 
 	/*
@@ -619,14 +617,6 @@ static int record__open(struct record *rec)
 		goto out;
 	}
 
-	if (perf_evlist__apply_drv_configs(evlist, &pos, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		rc = -1;
-		goto out;
-	}
-
 	rc = record__mmap(rec);
 	if (rc)
 		goto out;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..9c5b3b94bb38 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -52,7 +52,6 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/debug.h"
-#include "util/drv_configs.h"
 #include "util/color.h"
 #include "util/stat.h"
 #include "util/header.h"
@@ -418,7 +417,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int status = 0;
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
-	struct perf_evsel_config_term *err_term;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -515,13 +513,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		return -1;
 	}
 
-	if (perf_evlist__apply_drv_configs(evsel_list, &counter, &err_term)) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-		      err_term->val.drv_cfg, perf_evsel__name(counter), errno,
-		      str_error_r(errno, msg, sizeof(msg)));
-		return -1;
-	}
-
 	if (STAT_RECORD) {
 		int err, fd = perf_data__fd(&perf_stat.data);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f64e312db787..33e448f702b6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -24,7 +24,6 @@
 #include "util/annotate.h"
 #include "util/config.h"
 #include "util/color.h"
-#include "util/drv_configs.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/event.h"
@@ -1184,10 +1183,6 @@ static void init_process_thread(struct perf_top *top)
 
 static int __cmd_top(struct perf_top *top)
 {
-	char msg[512];
-	struct perf_evsel *pos;
-	struct perf_evsel_config_term *err_term;
-	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 	pthread_t thread, thread_process;
 	int ret;
@@ -1232,14 +1227,6 @@ static int __cmd_top(struct perf_top *top)
 	if (ret)
 		goto out_delete;
 
-	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
-	if (ret) {
-		pr_err("failed to set config \"%s\" on event %s with %d (%s)\n",
-			err_term->val.drv_cfg, perf_evsel__name(pos), errno,
-			str_error_r(errno, msg, sizeof(msg)));
-		goto out_delete;
-	}
-
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index af72be7f5b3b..71e697e7df2d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,6 @@ libperf-y += term.o
 libperf-y += help-unknown-cmd.o
 libperf-y += mem-events.o
 libperf-y += vsprintf.o
-libperf-y += drv_configs.o
 libperf-y += units.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
deleted file mode 100644
index eec754243f4d..000000000000
--- a/tools/perf/util/drv_configs.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-#include "pmu.h"
-#include <errno.h>
-
-static int
-perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
-			      struct perf_evsel_config_term **err_term)
-{
-	bool found = false;
-	int err = 0;
-	struct perf_evsel_config_term *term;
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL)
-		if (pmu->type == evsel->attr.type) {
-			found = true;
-			break;
-		}
-
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
-
-		/*
-		 * We have a configuration term, report an error if we
-		 * can't find the PMU or if the PMU driver doesn't support
-		 * cmd line driver configuration.
-		 */
-		if (!found || !pmu->set_drv_config) {
-			err = -EINVAL;
-			*err_term = term;
-			break;
-		}
-
-		err = pmu->set_drv_config(term);
-		if (err) {
-			*err_term = term;
-			break;
-		}
-	}
-
-	return err;
-}
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **err_term)
-{
-	struct perf_evsel *evsel;
-	int err = 0;
-
-	evlist__for_each_entry(evlist, evsel) {
-		err = perf_evsel__apply_drv_configs(evsel, err_term);
-		if (err) {
-			*err_evsel = evsel;
-			break;
-		}
-	}
-
-	return err;
-}
diff --git a/tools/perf/util/drv_configs.h b/tools/perf/util/drv_configs.h
deleted file mode 100644
index 32bc9babc2e0..000000000000
--- a/tools/perf/util/drv_configs.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * drv_configs.h: Interface to apply PMU specific configuration
- * Copyright (c) 2016-2018, Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#ifndef __PERF_DRV_CONFIGS_H
-#define __PERF_DRV_CONFIGS_H
-
-#include "drv_configs.h"
-#include "evlist.h"
-#include "evsel.h"
-
-int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
-				   struct perf_evsel **err_evsel,
-				   struct perf_evsel_config_term **term);
-#endif
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 350c54e0bd3d..569a6cbffd5a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,7 +30,6 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
 };
 
 struct perf_pmu_info {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
