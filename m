Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v3 3/7] coresight: Use event attributes for sink selection
Date: Thu, 31 Jan 2019 11:47:10 -0700
Message-Id: <20190131184714.20388-4-mathieu.poirier@linaro.org>
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

This patch uses the information conveyed by perf_event::attr::config2
to select a sink to use for the session.  That way a sink can easily be
selected to be used by more than one source, something that isn't currently
possible with the sysfs implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 24 +++++------
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 42 +++++++++++++++++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index cdbdb28dc175..8c88bf0a1e5f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -31,11 +31,14 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
+/* Sink ID - same for all ETMs */
+PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
+	&format_attr_sinkid.attr,
 	NULL,
 };
 
@@ -191,6 +194,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
+	u32 id;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
@@ -201,18 +205,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
+	/* First get the selected sink from user space. */
+	if (event->attr.config2) {
+		id = (u32)event->attr.config2;
+		sink = coresight_get_sink_by_id(id);
+	} else {
+		sink = coresight_get_enabled_sink(true);
+	}
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..b936c6d7e13f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d7fa90be6f42..29cef898afba 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
@@ -541,6 +542,47 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+static int coresight_sink_by_id(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	unsigned long hash;
+
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+
+		if (!csdev->ea)
+			return 0;
+		/*
+		 * See function etm_perf_add_symlink_sink() to know where
+		 * this comes from.
+		 */
+		hash = (unsigned long)csdev->ea->var;
+
+		if ((u32)hash == *(u32 *)data)
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_get_sink_by_id - returns the sink that matches the id
+ * @id: Id of the sink to match
+ *
+ * The name of a sink is unique, whether it is found on the AMBA bus or
+ * otherwise.  As such the hash of that name can easily be used to identify
+ * a sink.
+ */
+struct coresight_device *coresight_get_sink_by_id(u32 id)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &id,
+			      coresight_sink_by_id);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
