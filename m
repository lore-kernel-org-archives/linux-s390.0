From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 03/17] Extend QMP command query-cpus to return accelerator id and model name
Date: Mon, 13 Apr 2015 15:56:22 +0200
Message-ID: <1428933396-37887-4-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The QMP command query-cpus now additionally displays a model name and
the backing accelerator. Both are omitted if the model name is not
initialized.

  request:
    { "execute" : "query-cpus" }

  answer:
    { { "current": true,
        "CPU": 0,
        "model": "2827-ga2",
        "halted": false,
        "accel": "kvm",
        "thread_id": 31917
      }, ... }

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 cpus.c           | 4 ++++
 qapi-schema.json | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index e6dcae3..00f33b9 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1436,6 +1436,10 @@ CpuInfoList *qmp_query_cpus(Error **errp)
         info->value->current = (cpu == first_cpu);
         info->value->halted = cpu->halted;
         info->value->thread_id = cpu->thread_id;
+        info->value->model = g_strdup(cpu->model_name);
+        info->value->accel = cpu->accel_id;
+        info->value->has_model = info->value->has_accel =
+            info->value->model != NULL;
 #if defined(TARGET_I386)
         info->value->has_pc = true;
         info->value->pc = env->eip + env->segs[R_CS].base;
diff --git a/qapi-schema.json b/qapi-schema.json
index 540e520..215a7bc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -616,6 +616,10 @@
 #
 # @thread_id: ID of the underlying host thread
 #
+# @accel: #optional accelerator id (since 2.4)
+#
+# @model: #optional cpu model name (since 2.4)
+#
 # Since: 0.14.0
 #
 # Notes: @halted is a transient state that changes frequently.  By the time the
@@ -623,7 +627,8 @@
 ##
 { 'type': 'CpuInfo',
   'data': {'CPU': 'int', 'current': 'bool', 'halted': 'bool', '*pc': 'int',
-           '*nip': 'int', '*npc': 'int', '*PC': 'int', 'thread_id': 'int'} }
+           '*nip': 'int', '*npc': 'int', '*PC': 'int', 'thread_id': 'int',
+           '*accel': 'AccelId', '*model': 'str'} }
 
 ##
 # @query-cpus:
-- 
1.8.3.1
