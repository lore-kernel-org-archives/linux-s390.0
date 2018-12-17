Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [RESEND PATCH v5 5/6] perf tools: Make perf_evsel accessible to PMU
 driver configuration code
Date: Mon, 17 Dec 2018 10:21:45 -0700
Message-Id: <1545067306-31687-6-git-send-email-mathieu.poirier@linaro.org>
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

Make the perf_evsel available to the PMU driver configuration code.  That
way function perf_evsel__run_ioctl() can be used from there and
information pertaining to the perf_evsel_config_term is still available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 22 +++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h |  3 ++-
 tools/perf/util/drv_configs.c     | 30 +++++++-----------------------
 tools/perf/util/pmu.h             |  3 ++-
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..d8081c2e6d44 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -635,7 +635,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -649,3 +649,23 @@ int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
 
 	return 0;
 }
+
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term)
+{
+	int err = 0;
+	struct perf_evsel_config_term *term;
+
+	list_for_each_entry(term, &evsel->config_terms, list) {
+		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
+			continue;
+
+		err = cs_etm_set_drv_config_term(term);
+		if (err) {
+			*err_term = term;
+			break;
+		}
+	}
+
+	return err;
+}
diff --git a/tools/perf/arch/arm/util/cs-etm.h b/tools/perf/arch/arm/util/cs-etm.h
index 1a12e64f5127..a3f8dde6ccef 100644
--- a/tools/perf/arch/arm/util/cs-etm.h
+++ b/tools/perf/arch/arm/util/cs-etm.h
@@ -10,6 +10,7 @@
 #include "../../util/evsel.h"
 
 struct auxtrace_record *cs_etm_record_init(int *err);
-int cs_etm_set_drv_config(struct perf_evsel_config_term *term);
+int cs_etm_set_drv_config(struct perf_evsel *evsel,
+			  struct perf_evsel_config_term **err_term);
 
 #endif
diff --git a/tools/perf/util/drv_configs.c b/tools/perf/util/drv_configs.c
index eec754243f4d..f7c1bcf08549 100644
--- a/tools/perf/util/drv_configs.c
+++ b/tools/perf/util/drv_configs.c
@@ -25,7 +25,6 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 {
 	bool found = false;
 	int err = 0;
-	struct perf_evsel_config_term *term;
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmu__scan(pmu)) != NULL)
@@ -34,29 +33,14 @@ perf_evsel__apply_drv_configs(struct perf_evsel *evsel,
 			break;
 		}
 
-	list_for_each_entry(term, &evsel->config_terms, list) {
-		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
-			continue;
+	/*
+	 * No need to continue if we didn't get a match or if there is no
+	 * driver configuration function for this PMU.
+	 */
+	if (!found || !pmu->set_drv_config)
+		return err;
 
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
+	return pmu->set_drv_config(evsel, err_term);
 }
 
 int perf_evlist__apply_drv_configs(struct perf_evlist *evlist,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..47f44394042b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -29,7 +29,8 @@ struct perf_pmu {
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
-	int (*set_drv_config)	(struct perf_evsel_config_term *term);
+	int (*set_drv_config)	(struct perf_evsel *evsel,
+				 struct perf_evsel_config_term **err_term);
 };
 
 struct perf_pmu_info {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
