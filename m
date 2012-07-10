From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V2 1/2] kvm vcpu: Note down pause loop exit
Date: Wed, 11 Jul 2012 01:01:18 +0530
Message-ID: <20120710193117.16440.42745.sendpatchset@codeblue>
References: <20120710193056.16440.40112.sendpatchset@codeblue>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120710193056.16440.40112.sendpatchset@codeblue>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>
Cc: S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Noting pause loop exited vcpu helps in filtering right candidate to yield.
Yielding to same vcpu may result in more wastage of cpu.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---

 arch/x86/include/asm/kvm_host.h |   11 +++++++++++
 arch/x86/kvm/svm.c              |    1 +
 arch/x86/kvm/vmx.c              |    1 +
 arch/x86/kvm/x86.c              |    4 +++-
 4 files changed, 16 insertions(+), 1 deletions(-)


diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index db7c1f2..386f3e6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -484,6 +484,17 @@ struct kvm_vcpu_arch {
 		u64 length;
 		u64 status;
 	} osvw;
+
+	/*
+	 * Pause loop exit optimization
+	 * pause_loop_exited: set when a vcpu does a pause loop exit.
+	 * dy_eligible: indicates whether vcpu is eligible for directed yield.
+	 */
+	struct {
+		bool pause_loop_exited;
+		bool dy_eligible;
+	} ple;
+
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f75af40..2b4b4ee 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3264,6 +3264,7 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
 
 static int pause_interception(struct vcpu_svm *svm)
 {
+	svm->vcpu.arch.ple.pause_loop_exited = true;
 	kvm_vcpu_on_spin(&(svm->vcpu));
 	return 1;
 }
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 32eb588..14aa67a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4945,6 +4945,7 @@ out:
 static int handle_pause(struct kvm_vcpu *vcpu)
 {
 	skip_emulated_instruction(vcpu);
+	vcpu->arch.ple.pause_loop_exited = true;
 	kvm_vcpu_on_spin(vcpu);
 
 	return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be6d549..b30c310 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5331,7 +5331,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (req_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
-
+	vcpu->arch.ple.pause_loop_exited = false;
 	kvm_guest_enter();
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
@@ -6168,6 +6168,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	BUG_ON(vcpu->kvm == NULL);
 	kvm = vcpu->kvm;
 
+	vcpu->arch.ple.pause_loop_exited = false;
+	vcpu->arch.ple.dy_eligible = false;
 	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
 	if (!irqchip_in_kernel(kvm) || kvm_vcpu_is_bsp(vcpu))
 		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
