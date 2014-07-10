From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 3/5] KVM: s390: remove __cpu_is_stopped and expose is_vcpu_stopped
Date: Thu, 10 Jul 2014 15:09:33 +0200
Message-ID: <1404997775-28929-4-git-send-email-borntraeger@de.ibm.com>
References: <1404997775-28929-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997775-28929-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The function "__cpu_is_stopped" is not used any more. Let's remove it and
expose the function "is_vcpu_stopped" instead, which is actually what we want.

This patch also converts an open coded check for CPUSTAT_STOPPED to
is_vcpu_stopped().

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 7 +------
 arch/s390/kvm/kvm-s390.h | 4 ++--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c507789..3428953 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -926,7 +926,7 @@ static int kvm_arch_vcpu_ioctl_set_initial_psw(struct kvm_vcpu *vcpu, psw_t psw)
 {
 	int rc = 0;
 
-	if (!(atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED))
+	if (!is_vcpu_stopped(vcpu))
 		rc = -EBUSY;
 	else {
 		vcpu->run->psw_mask = psw.mask;
@@ -1413,11 +1413,6 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return kvm_s390_store_status_unloaded(vcpu, addr);
 }
 
-static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
-{
-	return atomic_read(&(vcpu)->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
-}
-
 static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
 	kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index a8655ed..77ed846 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -45,9 +45,9 @@ do { \
 	  d_args); \
 } while (0)
 
-static inline int __cpu_is_stopped(struct kvm_vcpu *vcpu)
+static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 {
-	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOP_INT;
+	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
 }
 
 static inline int kvm_is_ucontrol(struct kvm *kvm)
-- 
1.8.4.2
