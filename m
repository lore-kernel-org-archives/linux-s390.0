From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is STOPPED when checking "has_work"
Date: Thu, 10 Jul 2014 15:10:38 +0200
Message-ID: <1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If a cpu is stopped, it must never be allowed to run and no interrupt may wake it
up. A cpu also has to be unhalted if it is halted and has work to do - this
scenario wasn't hit in kvm case yet, as only "disabled wait" is processed within
QEMU.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target-s390x/cpu.c | 6 ++++++
 target-s390x/kvm.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index c5ab98f..1d32f5a 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -72,6 +72,12 @@ static bool s390_cpu_has_work(CPUState *cs)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
+    /* stopped cpus can never run */
+    if (env->cpu_state == CPU_STATE_STOPPED ||
+        env->cpu_state == CPU_STATE_CHECK_STOP) {
+        return false;
+    }
+
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
            (env->psw.mask & PSW_MASK_EXT);
 }
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index db2e42c..00125f1 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -553,6 +553,11 @@ void kvm_arch_post_run(CPUState *cpu, struct kvm_run *run)
 
 int kvm_arch_process_async_events(CPUState *cs)
 {
+    if (cs->halted && CPU_GET_CLASS(cs)->has_work(cs)) {
+        /* has_work will take care of stopped cpus */
+        s390_cpu_unhalt(S390_CPU(cs));
+    }
+
     return cs->halted;
 }
 
-- 
1.8.4.2
