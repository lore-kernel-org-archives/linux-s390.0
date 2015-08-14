Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v5 5/8] perf: Invert perf_read_group() loops
Date: Thu, 13 Aug 2015 23:49:38 -0700
Message-Id: <1439534981-7937-6-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: Peter Zijlstra <peterz@infradead.org>

In order to enable the use of perf_event_read(.group = true), we need
to invert the sibling-child loop nesting of perf_read_group().

Currently we iterate the child list for each sibling, this precludes
using group reads. Flip things around so we iterate each group for
each child.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changes to Peter's patch:
	- Add GFP_KERNEL to kzalloc().
	- Pass in address of counter to atomic_read().
	- Return event->size rather than leader->size (perf_read_group())
	- Keep chkpatch happy.
---
 kernel/events/core.c |   85 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 31ec842..2221ebe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3795,50 +3795,75 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_read_group(struct perf_event *event,
-				   u64 read_format, char __user *buf)
+static void __perf_read_group_add(struct perf_event *leader,
+					u64 read_format, u64 *values)
 {
-	struct perf_event *leader = event->group_leader, *sub;
-	struct perf_event_context *ctx = leader->ctx;
-	int n = 0, size = 0, ret;
-	u64 count, enabled, running;
-	u64 values[5];
+	struct perf_event *sub;
+	int n = 1; /* skip @nr */
 
-	lockdep_assert_held(&ctx->mutex);
+	perf_event_read(leader, true);
+
+	/*
+	 * Since we co-schedule groups, {enabled,running} times of siblings
+	 * will be identical to those of the leader, so we only publish one
+	 * set.
+	 */
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+		values[n++] += leader->total_time_enabled +
+			atomic64_read(&leader->child_total_time_enabled);
+	}
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+		values[n++] += leader->total_time_running +
+			atomic64_read(&leader->child_total_time_running);
+	}
 
-	values[n++] = 1 + leader->nr_siblings;
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		values[n++] = enabled;
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		values[n++] = running;
-	values[n++] = count;
+	/*
+	 * Write {count,id} tuples for every sibling.
+	 */
+	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 
-	size = n * sizeof(u64);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
+		values[n++] += perf_event_count(sub);
+		if (read_format & PERF_FORMAT_ID)
+			values[n++] = primary_event_id(sub);
+	}
+}
 
-	if (copy_to_user(buf, values, size))
-		return -EFAULT;
+static int perf_read_group(struct perf_event *event,
+				   u64 read_format, char __user *buf)
+{
+	struct perf_event *leader = event->group_leader, *child;
+	struct perf_event_context *ctx = leader->ctx;
+	int ret = event->read_size;
+	u64 *values;
 
-	ret = size;
+	lockdep_assert_held(&ctx->mutex);
 
-	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
-		n = 0;
+	values = kzalloc(event->read_size, GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
-		if (read_format & PERF_FORMAT_ID)
-			values[n++] = primary_event_id(sub);
+	values[0] = 1 + leader->nr_siblings;
+
+	/*
+	 * By locking the child_mutex of the leader we effectively
+	 * lock the child list of all siblings.. XXX explain how.
+	 */
+	mutex_lock(&leader->child_mutex);
 
-		size = n * sizeof(u64);
+	__perf_read_group_add(leader, read_format, values);
+	list_for_each_entry(child, &leader->child_list, child_list)
+		__perf_read_group_add(child, read_format, values);
 
-		if (copy_to_user(buf + ret, values, size)) {
-			return -EFAULT;
-		}
+	mutex_unlock(&leader->child_mutex);
 
-		ret += size;
-	}
+	if (copy_to_user(buf, values, event->read_size))
+		ret = -EFAULT;
+
+	kfree(values);
 
 	return ret;
 }
-- 
1.7.9.5
