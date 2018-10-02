From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:54 +0000
Subject: [GIT PULL 27/28] KVM: s390: set host program identifier
Message-Id: <20181002070655.224110-28-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Collin Walling <walling@linux.ibm.com>

A host program identifier (HPID) provides information regarding the
underlying host environment. A level-2 (VM) guest will have an HPID
denoting Linux/KVM, which is set during VCPU setup. A level-3 (VM on a
VM) and beyond guest will have an HPID denoting KVM vSIE, which is set
for all shadow control blocks, overriding the original value of the
HPID.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <1535734279-10204-4-git-send-email-walling@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 6 +++++-
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 29c940bf8506..47a5a2562aa4 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -237,7 +237,11 @@ struct kvm_s390_sie_block {
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
-	__u8	reservedb0[20];		/* 0x00b0 */
+	__u8	reservedb0[8];		/* 0x00b0 */
+#define HPID_KVM	0x4
+#define HPID_VSIE	0x5
+	__u8	hpid;			/* 0x00b8 */
+	__u8	reservedb9[11];		/* 0x00b9 */
 	__u16	extcpuaddr;		/* 0x00c4 */
 	__u16	eic;			/* 0x00c6 */
 	__u32	reservedc8;		/* 0x00c8 */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f69333fd2fa3..a1e8205d4b6b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2685,6 +2685,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 
+	vcpu->arch.sie_block->hpid = HPID_KVM;
+
 	kvm_s390_vcpu_crypto_setup(vcpu);
 
 	return rc;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a2b28cd1e3fe..41eab96c5f87 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -383,6 +383,8 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (test_kvm_facility(vcpu->kvm, 156))
 		scb_s->ecd |= scb_o->ecd & ECD_ETOKENF;
 
+	scb_s->hpid = HPID_VSIE;
+
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
 out:
-- 
2.17.0
