From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Fri, 17 Feb 2017 16:12:28 +0100
Message-ID: <20170217151227.GA27770@potion>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

2017-02-17 14:10+0100, Christian Borntraeger:
> needed by KVM common code.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 4c9ebb3..a4d7124 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -513,6 +513,7 @@ void smp_send_reschedule(int cpu)
>  {
>  	pcpu_ec_call(pcpu_devices + cpu, ec_schedule);
>  }
> +EXPORT_SYMBOL_GPL(smp_send_reschedule);

s390 doesn't want to use smp_send_reschedule() so I think the patch at
the bottom is going in a better direction.

Btw. I think that we shouldn't be using smp_send_reschedule() for
forcing VCPUs out of guest mode anyway -- the task we want to run is
already scheduled and we don't want the schduler to do anything.

We could use smp_call_function() with an empty function instead, but
that also has high overhead ... allocating a new IPI seems best.

But optimizing the current code is premature. :)

---8<---
s390 has a different mechanism from bringing the VCPU out of guest mode.
Make the kick arch-specific.

Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/arm/kvm/arm.c         | 5 +++++
 arch/mips/kvm/mips.c       | 5 +++++
 arch/powerpc/kvm/powerpc.c | 5 +++++
 arch/s390/kvm/kvm-s390.c   | 6 ++++++
 arch/x86/kvm/x86.c         | 5 +++++
 include/linux/kvm_host.h   | 1 +
 virt/kvm/kvm_main.c        | 2 +-
 7 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 21c493a9e5c9..a52b0399fa43 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -97,6 +97,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
+void kvm_arch_cpu_kick(int cpu)
+{
+	smp_send_reschedule(cpu);
+}
+
 int kvm_arch_hardware_setup(void)
 {
 	return 0;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 31ee5ee0010b..8ed510d7f8c5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -78,6 +78,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+void kvm_arch_cpu_kick(int cpu)
+{
+	smp_send_reschedule(cpu);
+}
+
 int kvm_arch_hardware_enable(void)
 {
 	return 0;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b094d9c1e1ef..b31149e63817 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -60,6 +60,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+void kvm_arch_cpu_kick(int cpu)
+{
+	smp_send_reschedule(cpu);
+}
+
 /*
  * Common checks before entering the guest world.  Call with interrupts
  * disabled.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8e36734fa5b6..f67ec9796f5e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2131,6 +2131,12 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+void kvm_arch_cpu_kick(int cpu)
+{
+	/* TODO: implement kicking with SIE */
+	BUG();
+}
+
 static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
 					   struct kvm_one_reg *reg)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19c853f87dd4..d6f40f20c0b5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8405,6 +8405,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
+void kvm_arch_cpu_kick(int cpu)
+{
+	smp_send_reschedule(cpu);
+}
+
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
 {
 	return kvm_x86_ops->interrupt_allowed(vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5438548fec10..9872bd7713f1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -766,6 +766,7 @@ void kvm_arch_hardware_unsetup(void);
 void kvm_arch_check_processor_compat(void *rtn);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
+void kvm_arch_cpu_kick(int cpu);
 
 void *kvm_kvzalloc(unsigned long size);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8d2ef0661ea8..4f4d250e1f53 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2240,7 +2240,7 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 	me = get_cpu();
 	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
 		if (kvm_arch_vcpu_should_kick(vcpu))
-			smp_send_reschedule(cpu);
+			kvm_arch_cpu_kick(cpu);
 	put_cpu();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
-- 
2.11.1
