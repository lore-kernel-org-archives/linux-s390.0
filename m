Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v5 8/8] powerpc/perf/hv-24x7: Use PERF_PMU_TXN_READ interface
Date: Thu, 13 Aug 2015 23:49:41 -0700
Message-Id: <1439534981-7937-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

The 24x7 counters in Powerpc allow monitoring a large number of counters
simultaneously. They also allow reading several counters in a single
HCALL so we can get a more consistent snapshot of the system.

Use the PMU's transaction interface to monitor and read several event
counters at once. The idea is that users can group several 24x7 events
into a single group of events. We use the following logic to submit
the group of events to the PMU and read the values:

	pmu->start_txn()		// Initialize before first event

	for each event in group
		pmu->read(event);	// Queue each event to be read

	pmu->commit_txn()		// Read/update all queuedcounters

The ->commit_txn() also updates the event counts in the respective
perf_event objects.  The perf subsystem can then directly get the
event counts from the perf_event and can avoid submitting a new
->read() request to the PMU.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v3]
	- [Peter Zijlstra] Save the transaction state in ->start_txn() and
	  remove the flags parameter from ->commit_txn() and ->cancel_txn().
---
 arch/powerpc/perf/hv-24x7.c |  166 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 4d1a8d1..c4eee39 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -142,6 +142,15 @@ static struct attribute_group event_long_desc_group = {
 
 static struct kmem_cache *hv_page_cache;
 
+DEFINE_PER_CPU(int, hv_24x7_txn_flags);
+DEFINE_PER_CPU(int, hv_24x7_txn_err);
+
+struct hv_24x7_hw {
+	struct perf_event *events[255];
+};
+
+DEFINE_PER_CPU(struct hv_24x7_hw, hv_24x7_hw);
+
 /*
  * request_buffer and result_buffer are not required to be 4k aligned,
  * but are not allowed to cross any 4k boundary. Aligning them to 4k is
@@ -1233,9 +1242,48 @@ static void update_event_count(struct perf_event *event, u64 now)
 static void h_24x7_event_read(struct perf_event *event)
 {
 	u64 now;
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_hw *h24x7hw;
+	int txn_flags;
+
+	txn_flags = __this_cpu_read(hv_24x7_txn_flags);
+
+	/*
+	 * If in a READ transaction, add this counter to the list of
+	 * counters to read during the next HCALL (i.e commit_txn()).
+	 * If not in a READ transaction, go ahead and make the HCALL
+	 * to read this counter by itself.
+	 */
+
+	if (txn_flags & PERF_PMU_TXN_READ) {
+		int i;
+		int ret;
 
-	now = h_24x7_get_value(event);
-	update_event_count(event, now);
+		if (__this_cpu_read(hv_24x7_txn_err))
+			return;
+
+		request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+
+		ret = add_event_to_24x7_request(event, request_buffer);
+		if (ret) {
+			__this_cpu_write(hv_24x7_txn_err, ret);
+		} else {
+			/*
+			 * Assoicate the event with the HCALL request index,
+			 * so ->commit_txn() can quickly find/update count.
+			 */
+			i = request_buffer->num_requests - 1;
+
+			h24x7hw = &get_cpu_var(hv_24x7_hw);
+			h24x7hw->events[i] = event;
+			put_cpu_var(h24x7hw);
+		}
+
+		put_cpu_var(hv_24x7_reqb);
+	} else {
+		now = h_24x7_get_value(event);
+		update_event_count(event, now);
+	}
 }
 
 static void h_24x7_event_start(struct perf_event *event, int flags)
@@ -1257,6 +1305,117 @@ static int h_24x7_event_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+/*
+ * 24x7 counters only support READ transactions. They are
+ * always counting and dont need/support ADD transactions.
+ * Cache the flags, but otherwise ignore transactions that
+ * are not PERF_PMU_TXN_READ.
+ */
+static void h_24x7_event_start_txn(struct pmu *pmu, int flags)
+{
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_data_result_buffer *result_buffer;
+
+	/* We should not be called if we are already in a txn */
+	WARN_ON_ONCE(__this_cpu_read(hv_24x7_txn_flags));
+
+	__this_cpu_write(hv_24x7_txn_flags, flags);
+	if (flags & ~PERF_PMU_TXN_READ)
+		return;
+
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
+
+	init_24x7_request(request_buffer, result_buffer);
+
+	put_cpu_var(hv_24x7_resb);
+	put_cpu_var(hv_24x7_reqb);
+}
+
+/*
+ * Clean up transaction state.
+ *
+ * NOTE: Ignore state of request and result buffers for now.
+ *	 We will initialize them during the next read/txn.
+ */
+static void reset_txn(void)
+{
+	__this_cpu_write(hv_24x7_txn_flags, 0);
+	__this_cpu_write(hv_24x7_txn_err, 0);
+}
+
+/*
+ * 24x7 counters only support READ transactions. They are always counting
+ * and dont need/support ADD transactions. Clear ->txn_flags but otherwise
+ * ignore transactions that are not of type PERF_PMU_TXN_READ.
+ *
+ * For READ transactions, submit all pending 24x7 requests (i.e requests
+ * that were queued by h_24x7_event_read()), to the hypervisor and update
+ * the event counts.
+ */
+static int h_24x7_event_commit_txn(struct pmu *pmu)
+{
+	struct hv_24x7_request_buffer *request_buffer;
+	struct hv_24x7_data_result_buffer *result_buffer;
+	struct hv_24x7_result *resb;
+	struct perf_event *event;
+	u64 count;
+	int i, ret, txn_flags;
+	struct hv_24x7_hw *h24x7hw;
+
+	txn_flags = __this_cpu_read(hv_24x7_txn_flags);
+	WARN_ON_ONCE(!txn_flags);
+
+	ret = 0;
+	if (txn_flags & ~PERF_PMU_TXN_READ)
+		goto out;
+
+	ret = __this_cpu_read(hv_24x7_txn_err);
+	if (ret)
+		goto out;
+
+	request_buffer = (void *)get_cpu_var(hv_24x7_reqb);
+	result_buffer = (void *)get_cpu_var(hv_24x7_resb);
+
+	ret = make_24x7_request(request_buffer, result_buffer);
+	if (ret) {
+		log_24x7_hcall(request_buffer, result_buffer, ret);
+		goto put_reqb;
+	}
+
+	h24x7hw = &get_cpu_var(hv_24x7_hw);
+
+	/* Update event counts from hcall */
+	for (i = 0; i < request_buffer->num_requests; i++) {
+		resb = &result_buffer->results[i];
+		count = be64_to_cpu(resb->elements[0].element_data[0]);
+		event = h24x7hw->events[i];
+		h24x7hw->events[i] = NULL;
+		update_event_count(event, count);
+	}
+
+	put_cpu_var(hv_24x7_hw);
+
+put_reqb:
+	put_cpu_var(hv_24x7_resb);
+	put_cpu_var(hv_24x7_reqb);
+out:
+	reset_txn();
+	return ret;
+}
+
+/*
+ * 24x7 counters only support READ transactions. They are always counting
+ * and dont need/support ADD transactions. However, regardless of type
+ * of transaction, all we need to do is cleanup, so we don't have to check
+ * the type of transaction.
+ */
+static void h_24x7_event_cancel_txn(struct pmu *pmu)
+{
+	WARN_ON_ONCE(!__this_cpu_read(hv_24x7_txn_flags));
+	reset_txn();
+}
+
 static struct pmu h_24x7_pmu = {
 	.task_ctx_nr = perf_invalid_context,
 
@@ -1268,6 +1427,9 @@ static struct pmu h_24x7_pmu = {
 	.start       = h_24x7_event_start,
 	.stop        = h_24x7_event_stop,
 	.read        = h_24x7_event_read,
+	.start_txn   = h_24x7_event_start_txn,
+	.commit_txn  = h_24x7_event_commit_txn,
+	.cancel_txn  = h_24x7_event_cancel_txn,
 };
 
 static int hv_24x7_init(void)
-- 
1.7.9.5
