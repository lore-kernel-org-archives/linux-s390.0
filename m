From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:14 +0000
Subject: [GIT PULL 03/18] KVM: s390: make bitmap declaration consistent
Message-Id: <1550835749-26436-4-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Use a consistent bitmap declaration throughout the code.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-3-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 2 +-
 arch/s390/kvm/interrupt.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d5d2488..3cba08f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -591,7 +591,7 @@ struct kvm_s390_float_interrupt {
 	struct kvm_s390_mchk_info mchk;
 	struct kvm_s390_ext_info srv_signal;
 	int next_rr_cpu;
-	unsigned long idle_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct mutex ais_lock;
 	u8 simm;
 	u8 nimm;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 19d5565..167a306 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2831,7 +2831,7 @@ static void store_local_irq(struct kvm_s390_local_interrupt *li,
 int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 {
 	int scn;
-	unsigned long sigp_emerg_pending[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	unsigned long pending_irqs;
 	struct kvm_s390_irq irq;
-- 
2.7.4
