From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 02/12] s390: Lowcore mapping helper.
Date: Thu, 17 Jan 2013 15:23:47 +0100
Message-ID: <1358432637-42512-3-git-send-email-cornelia.huck@de.ibm.com>
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

Create a lowcore mapping helper that includes a check for sufficient
length.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/helper.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index 9a132e6..bf2b4d3 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -471,13 +471,32 @@ static uint64_t get_psw_mask(CPUS390XState *env)
     return r;
 }
 
+static LowCore *cpu_map_lowcore(CPUS390XState *env, hwaddr *len)
+{
+    LowCore *lowcore;
+
+    if (*len < sizeof(LowCore)) {
+        cpu_abort(env, "Insufficient length %d for mapping lowcore\n",
+                  (int) *len);
+    }
+
+    lowcore = cpu_physical_memory_map(env->psa, len, 1);
+
+    return lowcore;
+}
+
+static void cpu_unmap_lowcore(LowCore *lowcore, hwaddr len)
+{
+    cpu_physical_memory_unmap(lowcore, len, 1, len);
+}
+
 static void do_svc_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
     LowCore *lowcore;
     hwaddr len = TARGET_PAGE_SIZE;
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env, &len);
 
     lowcore->svc_code = cpu_to_be16(env->int_svc_code);
     lowcore->svc_ilen = cpu_to_be16(env->int_svc_ilen);
@@ -486,7 +505,7 @@ static void do_svc_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->svc_new_psw.mask);
     addr = be64_to_cpu(lowcore->svc_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore, len);
 
     load_psw(env, mask, addr);
 }
@@ -513,7 +532,7 @@ static void do_program_interrupt(CPUS390XState *env)
     qemu_log_mask(CPU_LOG_INT, "%s: code=0x%x ilen=%d\n",
                   __func__, env->int_pgm_code, ilen);
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env, &len);
 
     lowcore->pgm_ilen = cpu_to_be16(ilen);
     lowcore->pgm_code = cpu_to_be16(env->int_pgm_code);
@@ -522,7 +541,7 @@ static void do_program_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->program_new_psw.mask);
     addr = be64_to_cpu(lowcore->program_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore, len);
 
     DPRINTF("%s: %x %x %" PRIx64 " %" PRIx64 "\n", __func__,
             env->int_pgm_code, ilen, env->psw.mask,
@@ -549,7 +568,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     }
 
     q = &env->ext_queue[env->ext_index];
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env, &len);
 
     lowcore->ext_int_code = cpu_to_be16(q->code);
     lowcore->ext_params = cpu_to_be32(q->param);
@@ -560,7 +579,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->external_new_psw.mask);
     addr = be64_to_cpu(lowcore->external_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore, len);
 
     env->ext_index--;
     if (env->ext_index == -1) {
-- 
1.7.12.4
