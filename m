From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 01/15] Introduce stub routine cpu_desc_avail
Date: Mon, 30 Mar 2015 16:28:14 +0200
Message-ID: <1427725708-52100-2-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
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
index 1b5cffb..386750f 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -484,4 +484,6 @@ int parse_debug_env(const char *name, int max, int initial);
 
 const char *qemu_ether_ntoa(const MACAddr *mac);
 
+bool cpu_desc_avail(void);
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 8beff4c..dce9cd2 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-$(CONFIG_WIN32) += fd-register.o
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
index 74c2681..c552561 100644
--- a/vl.c
+++ b/vl.c
@@ -3820,7 +3820,7 @@ int main(int argc, char **argv, char **envp)
      */
     cpudef_init();
 
-    if (cpu_model && is_help_option(cpu_model)) {
+    if (cpu_model && cpu_desc_avail() && is_help_option(cpu_model)) {
         list_cpus(stdout, &fprintf, cpu_model);
         exit(0);
     }
-- 
1.8.3.1
