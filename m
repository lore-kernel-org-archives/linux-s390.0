From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC 1/2] kvm vcpu: Note down pause loop exit
Date: Mon, 09 Jul 2012 11:50:33 +0530
Message-ID: <20120709062032.24030.10454.sendpatchset@codeblue>
References: <20120709062012.24030.37154.sendpatchset@codeblue>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20120709062012.24030.37154.sendpatchset@codeblue>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rik van Riel <riel@redhat.com>
Cc: S390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, chegu vinod <chegu_vinod@hp.com>, "Andrew M. Theurer" <habanero@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, X86 <x86@kernel.org>, Gleb Natapov <gleb@redhat.com>, linux390@de.ibm.com, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, Joerg Roedel <joerg.roedel@amd.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Noting pause loop exited vcpu helps in filtering right candidate to yield.
Yielding to same vcpu may result in more wastage of cpu.

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/include/asm/kvm_host.h |    7 +++++++
 arch/x86/kvm/svm.c              |    1 +
 arch/x86/kvm/vmx.c              |    1 +
 arch/x86/kvm/x86.c              |    4 +++-
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index db7c1f2..857ca68 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -484,6 +484,13 @@ struct kvm_vcpu_arch {
 		u64 length;
 		u64 status;
 	} osvw;
+
+	/* Pause loop exit optimization */
+	struct {
+		bool pause_loop_exited;
+		bool dy_eligible;
+	} plo;
+
 };
 
 struct kvm_lpage_info {
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f75af40..a492f5d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3264,6 +3264,7 @@ static int interrupt_window_interception(struct vcpu_svm *svm)
 
 static int pause_interception(struct vcpu_svm *svm)
 {
+	svm->vcpu.arch.plo.pause_loop_exited = true;
 	kvm_vcpu_on_spin(&(svm->vcpu));
 	return 1;
 }
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 32eb588..600fb3c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4945,6 +4945,7 @@ out:
 static int handle_pause(struct kvm_vcpu *vcpu)
 {
 	skip_emulated_instruction(vcpu);
+	vcpu->arch.plo.pause_loop_exited = true;
 	kvm_vcpu_on_spin(vcpu);
 
 	return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be6d549..07dbd14 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5331,7 +5331,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (req_immediate_exit)
 		smp_send_reschedule(vcpu->cpu);
-
+	vcpu->arch.plo.pause_loop_exited = false;
 	kvm_guest_enter();
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
@@ -6168,6 +6168,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	BUG_ON(vcpu->kvm == NULL);
 	kvm = vcpu->kvm;
 
+	vcpu->arch.plo.pause_loop_exited = false;
+	vcpu->arch.plo.dy_eligible = true;
 	vcpu->arch.emulate_ctxt.ops = &emulate_ops;
 	if (!irqchip_in_kernel(kvm) || kvm_vcpu_is_bsp(vcpu))
 		vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
