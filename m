Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] kernel/perf: correct return code of rb_alloc_aux() if !has_aux(ev)
Date: Tue, 20 Jun 2017 12:26:39 +0200
Message-Id: <1497954399-6355-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pu Hou <bjhoupu@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If the event for which an AUX area is about to be allocated, does
not support setting up an AUX area, rb_alloc_aux() return -ENOTSUPP.

This error condition is being returned unfiltered to the user space,
and, for example, the perf tools fails with:

  failed to mmap with 524 (INTERNAL ERROR: strerror_r(524, 0x3fff497a1c8, 512)=22)

This error can be easily seen with "perf record -m 128,256 -e cpu-clock".

The 524 error code maps to -ENOTSUPP (in rb_alloc_aux()). The -ENOTSUPP
error code shall be only used within the kernel.  So the correct error
code would then be -EOPNOTSUPP.

With this commit, the perf tool then reports:

  failed to mmap with 95 (Operation not supported)

which is more clear.

Cc: Pu Hou <bjhoupu@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 2831480..ee97196 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -580,7 +580,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 	int ret = -ENOMEM, max_order = 0;
 
 	if (!has_aux(event))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) {
 		/*
-- 
1.8.3.1
