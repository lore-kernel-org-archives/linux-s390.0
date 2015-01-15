From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 01/21] KVM: remove unneeded return value of vcpu_postcreate
Date: Thu, 15 Jan 2015 14:43:14 +0100
Message-ID: <1421329414-76826-2-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Only x86 and s390 provides such vcpu_postcreate implementation.
On s390 it can't fail and on x86 a fail is also impossible.
Additionally common code didn't care about return value.

So we just get rid of it.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/arm/kvm/arm.c         |  3 +--
 arch/mips/kvm/mips.c       |  3 +--
 arch/powerpc/kvm/powerpc.c |  3 +--
 arch/s390/kvm/kvm-s390.c   |  3 +--
 arch/x86/kvm/x86.c         | 10 +++-------
 include/linux/kvm_host.h   |  2 +-
 6 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 2d6d910..1a10e0c 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -241,9 +241,8 @@ out:
 	return ERR_PTR(err);
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	return 0;
 }
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e3b21e5..7082481 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -832,9 +832,8 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	return -ENOIOCTLCMD;
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index c45eaab..27c0fac 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -623,9 +623,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 	return vcpu;
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	return 0;
 }
 
 void kvm_arch_vcpu_free(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3e09801..ec004f8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -615,9 +615,8 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	kvm_s390_clear_local_irqs(vcpu);
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	return 0;
 }
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 49ecda7..274fbcb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7056,15 +7056,13 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	return r;
 }
 
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	int r;
 	struct msr_data msr;
 	struct kvm *kvm = vcpu->kvm;
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (vcpu_load(vcpu))
+		return;
 	msr.data = 0x0;
 	msr.index = MSR_IA32_TSC;
 	msr.host_initiated = true;
@@ -7073,8 +7071,6 @@ int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
 					KVMCLOCK_SYNC_PERIOD);
-
-	return r;
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 26f1060..a82432c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -652,7 +652,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu);
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id);
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu);
-int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
 
 int kvm_arch_hardware_enable(void);
-- 
1.9.3
