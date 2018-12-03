Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v5 4/6] coresight: Use PMU driver configuration for sink
 selection
Date: Mon,  3 Dec 2018 15:54:54 -0700
Message-Id: <1543877696-17174-5-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
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

This patch uses the PMU driver configuration held in event::hw::drv_config
to select a sink for each event that is created (the old sysFS way of
working is kept around for backward compatibility).

By proceeding in this way a sink can be used by multiple sessions
without having to play games with entries in sysFS.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..a7e1fdef07f2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/amba/bus.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -11,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
@@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
+{
+	struct coresight_device *sink = NULL;
+	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/*
+	 * Make sure we don't race with perf_drv_config_replace() in
+	 * kernel/events/core.c.
+	 */
+	raw_spin_lock(&drv_config->lock);
+
+	/* Copy what we got from user space if applicable. */
+	if (drv_config->config)
+		sink = drv_config->config;
+
+	raw_spin_unlock(&drv_config->lock);
+
+	return sink;
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the sink config from user space. */
+	sink = etm_drv_config_sync(event);
+	if (!sink)
+		sink = coresight_get_enabled_sink(true);
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
@@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static int etm_drv_config_find_sink(struct device *dev, void *data)
+{
+	struct amba_device *adev = to_amba_device(dev->parent);
+	struct resource *res = &adev->res;
+	u64 value = *((u64 *)data);
+
+	/*
+	 * The HW mapping of a component is unique.  If the value we've been
+	 * given matches the component's start address, then we must have found
+	 * the device we are looking for.
+	 */
+	if (res->start == value)
+		return 1;
+
+	return 0;
+}
+
+static void *etm_drv_config_validate(struct perf_event *event, u64 value)
+{
+	struct device *dev;
+	struct coresight_device *sink;
+
+	/* Look for the device with a res->start equal to @value. */
+	dev = bus_find_device(&coresight_bustype, NULL,
+			      &value, etm_drv_config_find_sink);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	sink = to_coresight_device(dev);
+	put_device(dev);
+
+	return sink;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -498,6 +547,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
