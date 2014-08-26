From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/15] KVM: s390: synchronize more registers with kvm_run
Date: Tue, 26 Aug 2014 10:28:18 +0200
Message-ID: <1409041707-39938-7-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

In order to reduce the number of syscalls when dropping to user space, this
patch enables the synchronization of the following "registers" with kvm_run:
- ARCH0: CPU timer, clock comparator, TOD programmable register,
         guest breaking-event register, program parameter
- PFAULT: pfault parameters (token, select, compare)

The registers are grouped to reduce the overhead when syncing.

As this grows the number of sync registers quite a bit, let's move the code
synchronizing registers with kvm_run from kvm_arch_vcpu_ioctl_run() into
separate helper routines.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 10 +++++++
 arch/s390/kvm/kvm-s390.c         | 60 ++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 0fc2643..48eda3a 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -111,12 +111,22 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_GPRS   (1UL << 1)
 #define KVM_SYNC_ACRS   (1UL << 2)
 #define KVM_SYNC_CRS    (1UL << 3)
+#define KVM_SYNC_ARCH0  (1UL << 4)
+#define KVM_SYNC_PFAULT (1UL << 5)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
 	__u64 gprs[16];	/* general purpose registers */
 	__u32 acrs[16];	/* access registers */
 	__u64 crs[16];	/* control registers */
+	__u64 todpr;	/* tod programmable register [ARCH0] */
+	__u64 cputm;	/* cpu timer [ARCH0] */
+	__u64 ckc;	/* clock comparator [ARCH0] */
+	__u64 pp;	/* program parameter [ARCH0] */
+	__u64 gbea;	/* guest breaking-event address [ARCH0] */
+	__u64 pft;	/* pfault token [PFAULT] */
+	__u64 pfs;	/* pfault select [PFAULT] */
+	__u64 pfc;	/* pfault compare [PFAULT] */
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f00d0b0..ab7cd64 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -546,7 +546,9 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	vcpu->run->kvm_valid_regs = KVM_SYNC_PREFIX |
 				    KVM_SYNC_GPRS |
 				    KVM_SYNC_ACRS |
-				    KVM_SYNC_CRS;
+				    KVM_SYNC_CRS |
+				    KVM_SYNC_ARCH0 |
+				    KVM_SYNC_PFAULT;
 	return 0;
 }
 
@@ -1296,6 +1298,47 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
+static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
+	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
+	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
+		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
+	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
+		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
+		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
+	}
+	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
+		vcpu->arch.sie_block->cputm = kvm_run->s.regs.cputm;
+		vcpu->arch.sie_block->ckc = kvm_run->s.regs.ckc;
+		vcpu->arch.sie_block->todpr = kvm_run->s.regs.todpr;
+		vcpu->arch.sie_block->pp = kvm_run->s.regs.pp;
+		vcpu->arch.sie_block->gbea = kvm_run->s.regs.gbea;
+	}
+	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PFAULT) {
+		vcpu->arch.pfault_token = kvm_run->s.regs.pft;
+		vcpu->arch.pfault_select = kvm_run->s.regs.pfs;
+		vcpu->arch.pfault_compare = kvm_run->s.regs.pfc;
+	}
+	kvm_run->kvm_dirty_regs = 0;
+}
+
+static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
+{
+	kvm_run->psw_mask = vcpu->arch.sie_block->gpsw.mask;
+	kvm_run->psw_addr = vcpu->arch.sie_block->gpsw.addr;
+	kvm_run->s.regs.prefix = kvm_s390_get_prefix(vcpu);
+	memcpy(&kvm_run->s.regs.crs, &vcpu->arch.sie_block->gcr, 128);
+	kvm_run->s.regs.cputm = vcpu->arch.sie_block->cputm;
+	kvm_run->s.regs.ckc = vcpu->arch.sie_block->ckc;
+	kvm_run->s.regs.todpr = vcpu->arch.sie_block->todpr;
+	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
+	kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
+	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
+	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
+	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	int rc;
@@ -1317,15 +1360,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		return -EINVAL;
 	}
 
-	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
-	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
-	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
-		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
-	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
-		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
-		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
-	}
-	kvm_run->kvm_dirty_regs = 0;
+	sync_regs(vcpu, kvm_run);
 
 	might_fault();
 	rc = __vcpu_run(vcpu);
@@ -1355,10 +1390,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		rc = 0;
 	}
 
-	kvm_run->psw_mask     = vcpu->arch.sie_block->gpsw.mask;
-	kvm_run->psw_addr     = vcpu->arch.sie_block->gpsw.addr;
-	kvm_run->s.regs.prefix = kvm_s390_get_prefix(vcpu);
-	memcpy(&kvm_run->s.regs.crs, &vcpu->arch.sie_block->gcr, 128);
+	store_regs(vcpu, kvm_run);
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-- 
1.8.4.2
