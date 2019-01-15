Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 5/7] perf tools: Use event attributes to send sink information
 to kernel
Date: Tue, 15 Jan 2019 16:07:40 -0700
Message-Id: <20190115230742.13730-6-mathieu.poirier@linaro.org>
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The communication of sink information for a trace session doesn't work when
more than on CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
perf_event::attr:config2 attribute.  The information sent to the kernel is
an hash of the sink's name, which is unique in a system.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..4aa6193dcb50 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,6 +22,7 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <errno.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
@@ -60,10 +61,45 @@ static int cs_etm_parse_snapshot_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
+				struct perf_evsel *evsel)
+{
+	char msg[BUFSIZ], path[PATH_MAX], *sink;
+	struct perf_evsel_config_term *term;
+	int ret = -EINVAL;
+	u32 hash;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		sink = term->val.drv_cfg;
+		snprintf(path, PATH_MAX, "sinks/%s", sink);
+
+		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
+		if (ret != 1) {
+			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
+			       sink, perf_evsel__name(evsel), errno,
+			       str_error_r(errno, msg, sizeof(msg)));
+			return ret;
+		}
+
+		evsel->attr.config2 = (u64)hash;
+		return 0;
+	}
+
+	/*
+	 * No sink was provided on the command line - for _now_ treat
+	 * this as an error.
+	 */
+	return ret;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct perf_evlist *evlist,
 				    struct record_opts *opts)
 {
+	int ret;
 	struct cs_etm_recording *ptr =
 				container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
@@ -92,6 +128,10 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cs_etm_evsel)
 		return 0;
 
+	ret = cs_etm_set_sink_attr(cs_etm_pmu, cs_etm_evsel);
+	if (ret)
+		return ret;
+
 	if (opts->use_clockid) {
 		pr_err("Cannot use clockid (-k option) with %s\n",
 		       CORESIGHT_ETM_PMU_NAME);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
