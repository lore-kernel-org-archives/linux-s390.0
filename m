Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [RESEND PATCH v5 6/6] perf tools: Use ioctl function to send sink
 information to kernel
Date: Mon, 17 Dec 2018 10:21:46 -0700
Message-Id: <1545067306-31687-7-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
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
To: acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, alexander.shishkin@linux.intel.com, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
an ioctl command.  The information sent to the kernel is the component's HW
address, which is guaranteed to be unique on the CoreSight bus and known to
the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 66 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c           |  6 ++++
 tools/perf/util/evsel.h           |  1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..41e394806707 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,11 +22,13 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
 #define ENABLE_SINK_MAX	128
 #define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
+#define AMBA_BUS_DEVICE_PATH "/bus/amba/devices/"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
@@ -619,6 +621,41 @@ static FILE *cs_device__open_file(const char *name)
 
 }
 
+static int cs_etm_check_drv_config_term(const char *name, u64 *addr)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	int err;
+	FILE *file;
+	u64 start;
+
+	/* CS devices are all found under sysFS */
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return -EINVAL;
+
+	/* The resource file contains the HW start address of this component */
+	snprintf(path, PATH_MAX,
+		 "%s" AMBA_BUS_DEVICE_PATH "%s" "/resource", sysfs, name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("Unable to open file: %s\n", path);
+		return -EINVAL;
+	}
+
+	/* We just need the first value */
+	err = fscanf(file, "%016lx", &start);
+	if (err != 1) {
+		pr_debug("Unable to get resource start value for: %s\n", path);
+		return -EINVAL;
+	}
+
+	*addr = start;
+
+	return 0;
+}
+
 static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
 {
 	va_list args;
@@ -635,7 +672,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term_sysfs(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -650,6 +687,21 @@ static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 	return 0;
 }
 
+static int cs_etm_set_drv_config_term_ioctl(struct perf_evsel *evsel,
+					    struct perf_evsel_config_term *term)
+{
+	u64 addr;
+	int ret;
+
+	/* First check the input */
+	ret = cs_etm_check_drv_config_term(term->val.drv_cfg, &addr);
+	if (ret)
+		return ret;
+
+	/* All good, apply configuration */
+	return perf_evsel__apply_drv_config(evsel, addr);
+}
+
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
 			  struct perf_evsel_config_term **err_term)
 {
@@ -660,7 +712,17 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		/* First try the new interface, i.e ioctl() */
+		err = cs_etm_set_drv_config_term_ioctl(evsel, term);
+		if (!err)
+			continue;
+
+		/*
+		 * Something went wrong, we are probably working with an older
+		 * kernel.  As such use the sysFS interface, which will only
+		 * work for per-thread scenarios.
+		 */
+		err = cs_etm_set_drv_config_term_sysfs(term);
 		if (err) {
 			*err_term = term;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..8aa2b79c3314 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1195,6 +1195,12 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG, &addr);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..6be7560bc986 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -276,6 +276,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
