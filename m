Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Date: Tue, 14 Jul 2015 20:01:54 -0700
Message-Id: <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Define a new PERF_PMU_TXN_READ interface to read a group of counters
at once. Note that we use this interface with all PMUs.

PMUs that implement this interface use the ->read() operation to _queue_
the counters to be read and use ->commit_txn() to actually read all the
queued counters at once.

PMUs that don't implement PERF_PMU_TXN_READ ignore ->start_txn() and
->commit_txn() and continue to read counters one at a time.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   35 +++++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 44bf05f..da307ad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -169,6 +169,7 @@ struct perf_event;
 #define PERF_EVENT_TXN 0x1
 
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
 
 /**
  * pmu::capabilities flags
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a83d45c..2ea06c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3763,6 +3763,33 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
+/*
+ * Use the transaction interface to read the group of events in @leader.
+ * PMUs like the 24x7 counters in Power, can use this to queue the events
+ * in the ->read() operation and perform the actual read in ->commit_txn.
+ *
+ * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
+ * PMU directly in the ->read() operation.
+ */
+static int perf_event_read_group(struct perf_event *leader)
+{
+	int ret;
+	struct perf_event *sub;
+	struct pmu *pmu;
+
+	pmu = leader->pmu;
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	perf_event_read(leader);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry)
+		perf_event_read(sub);
+
+	ret = pmu->commit_txn(pmu);
+
+	return ret;
+}
+
 u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 {
 	u64 total = 0;
@@ -3792,7 +3819,11 @@ static int perf_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	ret = perf_event_read_group(leader);
+	if (ret)
+		return ret;
+
+	count = perf_event_compute(leader, &enabled, &running);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3813,7 +3844,7 @@ static int perf_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		values[n++] = perf_event_compute(sub, &enabled, &running);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
-- 
1.7.9.5
