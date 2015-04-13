From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v5 02/17] Add accelerator id and model name to
	CPUState
Date: Mon, 13 Apr 2015 15:56:21 +0200
Message-ID: <1428933396-37887-3-git-send-email-mimu@linux.vnet.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The patch defines ids per accelerator and adds the accel_id and
the model_name to the CPUState. The accel_id is initialized by
common code, the model name needs to be initialized by target
specific code.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 include/qom/cpu.h |  5 +++++
 qapi-schema.json  |  9 +++++++++
 qom/cpu.c         | 14 ++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 9dafb48..4ffc050 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -236,6 +236,8 @@ struct kvm_run;
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @mem_io_vaddr: Target virtual address at which the memory was accessed.
  * @kvm_fd: vCPU file descriptor for KVM.
+ * @accel_id: accelerator id of this CPU.
+ * @model_name: model name of this CPU
  *
  * State of one CPU core or thread.
  */
@@ -313,6 +315,9 @@ struct CPUState {
        (absolute value) offset as small as possible.  This reduces code
        size, especially for hosts without large memory offsets.  */
     volatile sig_atomic_t tcg_exit_req;
+
+    AccelId accel_id;
+    char *model_name;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/qapi-schema.json b/qapi-schema.json
index ac9594d..540e520 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2515,6 +2515,15 @@
 ##
 { 'command': 'query-machines', 'returns': ['MachineInfo'] }
 
+# @AccelId
+#
+# Defines accelerator ids
+#
+# Since: 2.4
+##
+{ 'enum': 'AccelId',
+  'data': ['qtest', 'tcg', 'kvm', 'xen'] }
+
 ##
 # @CpuDefinitionInfo:
 #
diff --git a/qom/cpu.c b/qom/cpu.c
index 108bfa2..457afc7 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -67,6 +67,20 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
         goto out;
     }
 
+    if (tcg_enabled()) {
+        cpu->accel_id = ACCEL_ID_TCG;
+    } else if (kvm_enabled()) {
+        cpu->accel_id = ACCEL_ID_KVM;
+    }
+#ifdef CONFIG_XEN
+    else if (xen_enabled()) {
+        cpu->accel_id = ACCEL_ID_XEN;
+    }
+#endif
+    else {
+        cpu->accel_id = ACCEL_ID_QTEST;
+    }
+
     object_property_set_bool(OBJECT(cpu), true, "realized", &err);
 
 out:
-- 
1.8.3.1
