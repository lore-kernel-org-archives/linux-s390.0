From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/10] KVM: s390: enable SRS only if enabled for the guest
Date: Mon,  9 May 2016 14:26:44 +0200
Message-ID: <1462796804-13750-3-git-send-email-borntraeger@de.ibm.com>
References: <1462796804-13750-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462796804-13750-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If we don't have SIGP SENSE RUNNING STATUS enabled for the guest, let's
not enable interpretation so we can correctly report an invalid order.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sigp.h | 1 +
 arch/s390/kvm/kvm-s390.c     | 4 +++-
 arch/s390/kvm/sigp.c         | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index ec60cf7..1c8f33f 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -27,6 +27,7 @@
 
 /* SIGP cpu status bits */
 
+#define SIGP_STATUS_INVALID_ORDER	0x00000002UL
 #define SIGP_STATUS_CHECK_STOP		0x00000010UL
 #define SIGP_STATUS_STOPPED		0x00000040UL
 #define SIGP_STATUS_EXT_CALL_PENDING	0x00000080UL
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 13b3f5e..e1e375c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1645,7 +1645,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvm_s390_vcpu_setup_model(vcpu);
 
-	vcpu->arch.sie_block->ecb   = 6;
+	vcpu->arch.sie_block->ecb = 0x02;
+	if (test_kvm_facility(vcpu->kvm, 9))
+		vcpu->arch.sie_block->ecb |= 0x04;
 	if (test_kvm_facility(vcpu->kvm, 50) && test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= 0x10;
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 77c22d6..28ea0ca 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -240,6 +240,12 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu,
 	struct kvm_s390_local_interrupt *li;
 	int rc;
 
+	if (!test_kvm_facility(vcpu->kvm, 9)) {
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_INVALID_ORDER;
+		return SIGP_CC_STATUS_STORED;
+	}
+
 	li = &dst_vcpu->arch.local_int;
 	if (atomic_read(li->cpuflags) & CPUSTAT_RUNNING) {
 		/* running */
-- 
2.5.5
