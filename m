Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 05/10] perf: Unroll perf_event_read_value() in
 perf_read_group()
Date: Sun, 26 Jul 2015 22:40:33 -0700
Message-Id: <1437975638-789-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Unroll the calls to perf_event_read_value() in perf_read_group()
so we can later optimize out parts we don't need for group events.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6bd09d..0ce3012 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3794,7 +3794,14 @@ static int perf_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	enabled = running = 0;
+
+	mutex_lock(&leader->child_mutex);
+
+	perf_event_read(leader);
+	count = perf_event_aggregate(leader, &enabled, &running);
+
+	mutex_unlock(&leader->child_mutex);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3815,7 +3822,13 @@ static int perf_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		mutex_lock(&leader->child_mutex);
+
+		perf_event_read(sub);
+		values[n++] = perf_event_aggregate(sub, &enabled, &running);
+
+		mutex_unlock(&leader->child_mutex);
+
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
-- 
1.7.9.5
