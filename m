From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 01/11] s390: Lowcore mapping helper.
Date: Thu, 24 Jan 2013 13:28:01 +0100
Message-ID: <1359030491-46725-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Create a lowcore mapping helper that includes a check for sufficient
length.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

v5 -> v6:

 - Check returned len of cpu_physical_memory_map
 - Don't pass lowcore len
---
 target-s390x/helper.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index 9a132e6..023c074 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -471,13 +471,31 @@ static uint64_t get_psw_mask(CPUS390XState *env)
     return r;
 }
 
+static LowCore *cpu_map_lowcore(CPUS390XState *env)
+{
+    LowCore *lowcore;
+    hwaddr len = sizeof(LowCore);
+
+    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+
+    if (len < sizeof(LowCore)) {
+        cpu_abort(env, "Could not map lowcore\n");
+    }
+
+    return lowcore;
+}
+
+static void cpu_unmap_lowcore(LowCore *lowcore)
+{
+    cpu_physical_memory_unmap(lowcore, sizeof(LowCore), 1, sizeof(LowCore));
+}
+
 static void do_svc_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
     LowCore *lowcore;
-    hwaddr len = TARGET_PAGE_SIZE;
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env);
 
     lowcore->svc_code = cpu_to_be16(env->int_svc_code);
     lowcore->svc_ilen = cpu_to_be16(env->int_svc_ilen);
@@ -486,7 +504,7 @@ static void do_svc_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->svc_new_psw.mask);
     addr = be64_to_cpu(lowcore->svc_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore);
 
     load_psw(env, mask, addr);
 }
@@ -495,7 +513,6 @@ static void do_program_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
     LowCore *lowcore;
-    hwaddr len = TARGET_PAGE_SIZE;
     int ilen = env->int_pgm_ilen;
 
     switch (ilen) {
@@ -513,7 +530,7 @@ static void do_program_interrupt(CPUS390XState *env)
     qemu_log_mask(CPU_LOG_INT, "%s: code=0x%x ilen=%d\n",
                   __func__, env->int_pgm_code, ilen);
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env);
 
     lowcore->pgm_ilen = cpu_to_be16(ilen);
     lowcore->pgm_code = cpu_to_be16(env->int_pgm_code);
@@ -522,7 +539,7 @@ static void do_program_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->program_new_psw.mask);
     addr = be64_to_cpu(lowcore->program_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore);
 
     DPRINTF("%s: %x %x %" PRIx64 " %" PRIx64 "\n", __func__,
             env->int_pgm_code, ilen, env->psw.mask,
@@ -537,7 +554,6 @@ static void do_ext_interrupt(CPUS390XState *env)
 {
     uint64_t mask, addr;
     LowCore *lowcore;
-    hwaddr len = TARGET_PAGE_SIZE;
     ExtQueue *q;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
@@ -549,7 +565,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     }
 
     q = &env->ext_queue[env->ext_index];
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_map_lowcore(env);
 
     lowcore->ext_int_code = cpu_to_be16(q->code);
     lowcore->ext_params = cpu_to_be32(q->param);
@@ -560,7 +576,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->external_new_psw.mask);
     addr = be64_to_cpu(lowcore->external_new_psw.addr);
 
-    cpu_physical_memory_unmap(lowcore, len, 1, len);
+    cpu_unmap_lowcore(lowcore);
 
     env->ext_index--;
     if (env->ext_index == -1) {
-- 
1.7.12.4
