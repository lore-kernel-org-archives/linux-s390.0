From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/12] KVM: s390: we are always in czam mode
Date: Wed, 30 Aug 2017 09:54:10 +0200
Message-ID: <1504079650-82735-6-git-send-email-borntraeger@de.ibm.com>
References: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1504079650-82735-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Independent of the underlying hardware, kvm will now always handle
SIGP SET ARCHITECTURE as if czam were enabled. Therefore, let's not
only forward that bit but always set it.

While at it, add a comment regarding STHYI.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170829143108.14703-1-david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c         | 4 ++++
 arch/s390/tools/gen_facilities.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 84c069a..39115f5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1927,6 +1927,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
+	/* we are always in czam mode - even on pre z14 machines */
+	set_kvm_facility(kvm->arch.model.fac_mask, 138);
+	set_kvm_facility(kvm->arch.model.fac_list, 138);
+	/* we emulate STHYI in kvm */
 	set_kvm_facility(kvm->arch.model.fac_mask, 74);
 	set_kvm_facility(kvm->arch.model.fac_list, 74);
 	if (MACHINE_HAS_TLB_GUEST) {
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 601bfcf..19f12ce 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -80,7 +80,6 @@ static struct facility_def facility_defs[] = {
 			78, /* enhanced-DAT 2 */
 			130, /* instruction-execution-protection */
 			131, /* enhanced-SOP 2 and side-effect */
-			138, /* configuration z/architecture mode (czam) */
 			139, /* multiple epoch facility */
 			146, /* msa extension 8 */
 			-1  /* END */
-- 
2.7.4
