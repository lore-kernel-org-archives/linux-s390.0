Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/53] perf coresight: Remove set_drv_config() API
Date: Wed,  6 Feb 2019 15:48:35 -0300
Message-Id: <20190206184903.24054-26-acme@kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Clark Williams <williams@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>, linux-s390@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Suzuki K Poulouse <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Now that the event's config2 attribute is used to communicate sink
selection to the kernel, remove the old set_drv_config() implementation
since it is no longer needed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 54 -------------------------------
 tools/perf/arch/arm/util/cs-etm.h |  3 --
 tools/perf/arch/arm/util/pmu.c    |  2 --
 3 files changed, 59 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4f31cf0d1e6d..911426721170 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -27,9 +27,6 @@
 #include <stdlib.h>
 #include <sys/stat.h>
 
-#define ENABLE_SINK_MAX	128
-#define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
-
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
@@ -642,54 +639,3 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 out:
 	return NULL;
 }
-
-static FILE *cs_device__open_file(const char *name)
-{
-	struct stat st;
-	char path[PATH_MAX];
-	const char *sysfs;
-
-	sysfs = sysfs__mountpoint();
-	if (!sysfs)
-		return NULL;
-
-	snprintf(path, PATH_MAX,
-		 "%s" CS_BUS_DEVICE_PATH "%s", sysfs, name);
-
-	if (stat(path, &st) < 0)
-		return NULL;
-
-	return fopen(path, "w");
-
-}
-
-static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
-{
-	va_list args;
-	FILE *file;
-	int ret = -EINVAL;
-
-	va_start(args, fmt);
-	file = cs_device__open_file(name);
-	if (file) {
-		ret = vfprintf(file, fmt, args);
-		fclose(file);
-	}
-	va_end(args);
-	return ret;
-}
-
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
-{
-	int ret;
-	char enable_sink[ENABLE_SINK_MAX];
-
-	snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
-		 term->val.drv_cfg, "enable_sink");
-
-	ret = cs_device__print_file(enable_sink, "%d", 1);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3354bda4fe8 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -7,9 +7,6 @@
 #ifndef INCLUDE__PERF_CS_ETM_H__
 #define INCLUDE__PERF_CS_ETM_H__
 
-#include "../../util/evsel.h"
-
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
 
 #endif
diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 64a677b518d0..bbc297a7e2e3 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -9,7 +9,6 @@
 #include <linux/perf_event.h>
 #include <linux/string.h>
 
-#include "cs-etm.h"
 #include "arm-spe.h"
 #include "../../util/pmu.h"
 
@@ -20,7 +19,6 @@ struct perf_event_attr
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		pmu->set_drv_config = cs_etm_set_drv_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		return arm_spe_pmu_default_config(pmu);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
