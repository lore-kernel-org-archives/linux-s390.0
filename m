From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 03/16] Introduce stub routine cpu_desc_avail
Date: Mon,  2 Mar 2015 13:43:55 +0100
Message-ID: <1425300248-40277-4-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch introduces the function cpu_desc_avail() which returns by
default true if not architecture specific implemented. Its intention
is to indicate if the cpu model description is available for display
by list_cpus(). This change allows cpu model descriptions to become
dynamically created by evaluating the runtime context instead of
putting static cpu model information at display.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 include/qemu-common.h  | 2 ++
 stubs/Makefile.objs    | 1 +
 stubs/cpu-desc-avail.c | 6 ++++++
 vl.c                   | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 stubs/cpu-desc-avail.c

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 644b46d..45040f9 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -481,4 +481,6 @@ int parse_debug_env(const char *name, int max, int initial);
 
 const char *qemu_ether_ntoa(const MACAddr *mac);
 
+bool cpu_desc_avail(void);
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 5e347d0..fd7a489 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,3 +40,4 @@ stub-obj-$(CONFIG_WIN32) += fd-register.o
 stub-obj-y += cpus.o
 stub-obj-y += kvm.o
 stub-obj-y += qmp_pc_dimm_device_list.o
+stub-obj-y += cpu-desc-avail.o
diff --git a/stubs/cpu-desc-avail.c b/stubs/cpu-desc-avail.c
new file mode 100644
index 0000000..0cd594e
--- /dev/null
+++ b/stubs/cpu-desc-avail.c
@@ -0,0 +1,6 @@
+#include "qemu-common.h"
+
+bool cpu_desc_avail(void)
+{
+    return true;
+}
diff --git a/vl.c b/vl.c
index ba1730c..d337a74 100644
--- a/vl.c
+++ b/vl.c
@@ -3815,7 +3815,7 @@ int main(int argc, char **argv, char **envp)
      */
     cpudef_init();
 
-    if (cpu_model && is_help_option(cpu_model)) {
+    if (cpu_model && cpu_desc_avail() && is_help_option(cpu_model)) {
         list_cpus(stdout, &fprintf, cpu_model);
         exit(0);
     }
-- 
1.8.3.1
