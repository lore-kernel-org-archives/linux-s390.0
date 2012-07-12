From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V3 3/3] kvm: Choose better candidate for directed yield
Date: Fri, 13 Jul 2012 00:48:24 +0530
Message-ID: <20120712191822.30440.56318.sendpatchset@codeblue>
References: <20120712191712.30440.68944.sendpatchset@codeblue>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120712191712.30440.68944.sendpatchset@codeblue>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>
Cc: S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Currently, on a large vcpu guests, there is a high probability of
yielding to the same vcpu who had recently done a pause-loop exit or
cpu relax intercepted. Such a yield can lead to the vcpu spinning
again and hence degrade the performance.

The patchset keeps track of the pause loop exit/cpu relax interception
and gives chance to a vcpu which:
 (a) Has not done pause loop exit or cpu relax intercepted at all
     (probably he is preempted lock-holder)
 (b) Was skipped in last iteration because it did pause loop exit or
     cpu relax intercepted, and probably has become eligible now
     (next eligible lock holder)

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
v2 patches were:
Reviewed-by: Rik van Riel <riel@redhat.com>

 virt/kvm/kvm_main.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)


diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4ec0120..50f6e60 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1570,6 +1570,38 @@ bool kvm_vcpu_yield_to(struct kvm_vcpu *target)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_yield_to);
 
+/*
+ * Helper that checks whether a VCPU is eligible for directed yield.
+ * Most eligible candidate to yield is decided by following heuristics:
+ *
+ *  (a) VCPU which has not done pl-exit or cpu relax intercepted recently
+ *  (preempted lock holder), indicated by @cpu_relax_intercepted.
+ *  Set at the beiginning and cleared at the end of interception/PLE handler.
+ *
+ *  (b) VCPU which has done pl-exit/ cpu relax intercepted but did not get
+ *  chance last time (mostly it has become eligible now since we have probably
+ *  yielded to lockholder in last iteration. This is done by toggling
+ *  @dy_eligible each time a VCPU checked for eligibility.)
+ *
+ *  Yielding to a recently pl-exited/cpu relax intercepted VCPU before yielding
+ *  to preempted lock-holder could result in wrong VCPU selection and CPU
+ *  burning. Giving priority for a potential lock-holder increases lock
+ *  progress.
+ */
+bool kvm_vcpu_check_and_update_eligible(struct kvm_vcpu *vcpu)
+{
+	bool eligible;
+
+	eligible = !vcpu->ple.cpu_relax_intercepted ||
+			(vcpu->ple.cpu_relax_intercepted &&
+			 vcpu->ple.dy_eligible);
+
+	if (vcpu->ple.cpu_relax_intercepted)
+		vcpu->ple.dy_eligible = !vcpu->ple.dy_eligible;
+
+	return eligible;
+}
+
 void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 {
 	struct kvm *kvm = me->kvm;
@@ -1598,6 +1630,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (waitqueue_active(&vcpu->wq))
 				continue;
+			if (!kvm_vcpu_check_and_update_eligible(vcpu))
+				continue;
 			if (kvm_vcpu_yield_to(vcpu)) {
 				kvm->last_boosted_vcpu = i;
 				yielded = 1;
