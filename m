Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 13/13] s390/irq: make return of 0 explicit
Date: Mon, 19 May 2014 06:31:15 +0200
Message-Id: <1400473875-22228-14-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1400473875-22228-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1400473875-22228-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <rric@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Delete unnecessary local variable whose value is always 0 and that hides
the fact that the result is always 0.

A simplified version of the semantic patch that fixes this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression ret;
expression e;
position p;
@@

-ret = 0;
... when != ret = e
return 
- ret
+ 0
  ;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/s390/oprofile/hwsampler.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/oprofile/hwsampler.c b/arch/s390/oprofile/hwsampler.c
index 276f2e2..28b2760 100644
--- a/arch/s390/oprofile/hwsampler.c
+++ b/arch/s390/oprofile/hwsampler.c
@@ -212,10 +212,8 @@ static void init_all_cpu_buffers(void)
 static int prepare_cpu_buffers(void)
 {
 	int cpu;
-	int rc;
 	struct hws_cpu_buffer *cb;
 
-	rc = 0;
 	for_each_online_cpu(cpu) {
 		cb = &per_cpu(sampler_cpu_buffer, cpu);
 		atomic_set(&cb->ext_params, 0);
@@ -231,7 +229,7 @@ static int prepare_cpu_buffers(void)
 		cb->stop_mode = 0;
 	}
 
-	return rc;
+	return 0;
 }
 
 /*
@@ -1156,7 +1154,7 @@ int hwsampler_stop_all(void)
 	rc = 0;
 	if (hws_state == HWS_INIT) {
 		mutex_unlock(&hws_sem);
-		return rc;
+		return 0;
 	}
 	hws_state = HWS_STOPPING;
 	mutex_unlock(&hws_sem);
