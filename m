From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v1 RFC 01/10] QEMU: introduce function cpudesc_avail
Date: Tue, 13 May 2014 17:00:13 +0200
Message-ID: <1399993222-16339-2-git-send-email-mimu@linux.vnet.ibm.com>
References: <1399993222-16339-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399993222-16339-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, mimu@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch introduces the function cpudesc_avail() which returns by
default true if not architecture specific implemented. Its intention
is to indicate if the cpu model description is available for display
by list_cpus(). This change allows cpu model descriptions to become
dynamically created by evaluating the runtime context.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch_init.c                | 8 ++++++++
 include/sysemu/arch_init.h | 1 +
 vl.c                       | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch_init.c b/arch_init.c
index 995f56d..207d720 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -1346,6 +1346,14 @@ int xen_available(void)
 #endif
 }
 
+bool cpudesc_avail(void)
+{
+    bool is_avail = true;
+#if defined(cpudesc_ready)
+    is_avail = cpudesc_ready();
+#endif
+    return is_avail;
+}
 
 TargetInfo *qmp_query_target(Error **errp)
 {
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 182d48d..cadcedc 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -35,6 +35,7 @@ void audio_init(void);
 int tcg_available(void);
 int kvm_available(void);
 int xen_available(void);
+bool cpudesc_avail(void);
 
 CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
 
diff --git a/vl.c b/vl.c
index 73e0661..ddd98f7 100644
--- a/vl.c
+++ b/vl.c
@@ -4009,7 +4009,7 @@ int main(int argc, char **argv, char **envp)
      */
     cpudef_init();
 
-    if (cpu_model && is_help_option(cpu_model)) {
+    if (cpudesc_avail() && cpu_model && is_help_option(cpu_model)) {
         list_cpus(stdout, &fprintf, cpu_model);
         exit(0);
     }
-- 
1.8.3.1
