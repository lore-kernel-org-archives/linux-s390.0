From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 04/17] Extend HMP command info cpus to display accelerator id and model name
Date: Mon, 13 Apr 2015 15:56:23 +0200
Message-ID: <1428933396-37887-5-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The HMP command info cpus now displays the CPU model name and the
backing accelerator if part of the CPUState.

(qemu) info cpus
* CPU #0: (halted) model=2827-ga2 accel=kvm thread_id=1679

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 hmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hmp.c b/hmp.c
index f31ae27..70238332 100644
--- a/hmp.c
+++ b/hmp.c
@@ -290,6 +290,13 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, " (halted)");
         }
 
+        if (cpu->value->has_model) {
+            monitor_printf(mon, " model=%s", cpu->value->model);
+        }
+        if (cpu->value->has_accel) {
+            monitor_printf(mon, " accel=%s", AccelId_lookup[cpu->value->accel]);
+        }
+
         monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
     }
 
-- 
1.8.3.1
