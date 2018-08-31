From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 31 Aug 2018 16:51:19 +0000
Subject: [PATCH 3/3] s390/kvm: set host program identifier
Message-Id: <1535734279-10204-4-git-send-email-walling@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A host program identifier (HPID) provides information regarding the underlying
host environment. A level-2 (VM) guest will have an HPID denoting Linux/KVM,
which is set during VCPU setup. A level-3 (VM on a VM) and beyond guest will
have an HPID denoting VSIE, which is set (and is overwritten) during shadowing
of the SCB.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 6 +++++-
 arch/s390/kvm/kvm-s390.c         | 2 ++
 arch/s390/kvm/vsie.c             | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index fabeb32..8c877f5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -238,7 +238,11 @@ struct kvm_s390_sie_block {
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
index 678c9cb..aac8a22 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2773,6 +2773,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 
+	vcpu->arch.sie_block->hpid = HPID_KVM;
+
 	kvm_s390_vcpu_crypto_setup(vcpu);
 
 	return rc;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 63844b9..2b701b4 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -382,6 +382,8 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (test_kvm_facility(vcpu->kvm, 156))
 		scb_s->ecd |= scb_o->ecd & ECD_ETOKENF;
 
+	scb_s->hpid = HPID_VSIE;
+
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
 out:
-- 
2.7.4
