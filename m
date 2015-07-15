Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 6/8] perf: Rename perf_event_read_{one, group}, perf_read_hw
Date: Tue, 14 Jul 2015 20:01:53 -0700
Message-Id: <1436929315-28520-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

In order to free up the perf_event_read_group() name:

 s/perf_event_read_\(one\|group\)/perf_read_\1/g
 s/perf_read_hw/__perf_read/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b1e9a42..a83d45c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3675,7 +3675,7 @@ static void put_event(struct perf_event *event)
 	 *     see the comment there.
 	 *
 	 *  2) there is a lock-inversion with mmap_sem through
-	 *     perf_event_read_group(), which takes faults while
+	 *     perf_read_group(), which takes faults while
 	 *     holding ctx->mutex, however this is called after
 	 *     the last filedesc died, so there is no possibility
 	 *     to trigger the AB-BA case.
@@ -3781,7 +3781,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_event_read_group(struct perf_event *event,
+static int perf_read_group(struct perf_event *event,
 				   u64 read_format, char __user *buf)
 {
 	struct perf_event *leader = event->group_leader, *sub;
@@ -3829,7 +3829,7 @@ static int perf_event_read_group(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_read_one(struct perf_event *event,
+static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
@@ -3867,7 +3867,7 @@ static bool is_event_hup(struct perf_event *event)
  * Read the performance event - simple non blocking version for now
  */
 static ssize_t
-perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
+__perf_read(struct perf_event *event, char __user *buf, size_t count)
 {
 	u64 read_format = event->attr.read_format;
 	int ret;
@@ -3885,9 +3885,9 @@ perf_read_hw(struct perf_event *event, char __user *buf, size_t count)
 
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 	if (read_format & PERF_FORMAT_GROUP)
-		ret = perf_event_read_group(event, read_format, buf);
+		ret = perf_read_group(event, read_format, buf);
 	else
-		ret = perf_event_read_one(event, read_format, buf);
+		ret = perf_read_one(event, read_format, buf);
 
 	return ret;
 }
@@ -3900,7 +3900,7 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 
 	ctx = perf_event_ctx_lock(event);
-	ret = perf_read_hw(event, buf, count);
+	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
 
 	return ret;
-- 
1.7.9.5
