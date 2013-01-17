From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 03/12] s390: Add mapping helper functions.
Date: Thu, 17 Jan 2013 15:23:48 +0100
Message-ID: <1358432637-42512-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
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
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add s390_cpu_physical_memory_{map,unmap} with special handling
for the lowcore.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu.h    |  4 ++++
 target-s390x/helper.c | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index 6700fe9..cd729d3 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -299,6 +299,10 @@ int cpu_s390x_handle_mmu_fault (CPUS390XState *env, target_ulong address, int rw
 
 
 #ifndef CONFIG_USER_ONLY
+void *s390_cpu_physical_memory_map(CPUS390XState *env, hwaddr addr, hwaddr len,
+                                   int is_write);
+void s390_cpu_physical_memory_unmap(CPUS390XState *env, void *addr, hwaddr len,
+                                    int is_write);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 
diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index bf2b4d3..d350f28 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -490,6 +490,32 @@ static void cpu_unmap_lowcore(LowCore *lowcore, hwaddr len)
     cpu_physical_memory_unmap(lowcore, len, 1, len);
 }
 
+void *s390_cpu_physical_memory_map(CPUS390XState *env, hwaddr addr, hwaddr len,
+                                   int is_write)
+{
+    hwaddr start = addr;
+
+    /* Mind the prefix area. */
+    if (addr < 8192) {
+        start += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        start -= env->psa;
+    }
+
+    if ((addr + len <= env->psa) || (addr >= env->psa + 8192)) {
+        return cpu_physical_memory_map(start, &len, is_write);
+    }
+
+    DPRINTF("mapping across lowcore boundaries not yet supported\n");
+    return NULL;
+}
+
+void s390_cpu_physical_memory_unmap(CPUS390XState *env, void *addr, hwaddr len,
+                                    int is_write)
+{
+    cpu_physical_memory_unmap(addr, len, is_write, len);
+}
+
 static void do_svc_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
-- 
1.7.12.4
