From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/12] KVM: s390: Introduce BCD Vector Instructions to the guest
Date: Wed,  1 Feb 2017 12:38:09 +0100
Message-ID: <1485949094-138708-8-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Guenther Hutzl <hutzl@linux.vnet.ibm.com>

We can directly forward the vector BCD instructions to the guest
if available and VX is requested by user space.

Please note that user space will have to take care of the final state
of the facility bit when migrating to older machines.

Signed-off-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 1fd4b85..69401b8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -505,6 +505,10 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		} else if (MACHINE_HAS_VX) {
 			set_kvm_facility(kvm->arch.model.fac_mask, 129);
 			set_kvm_facility(kvm->arch.model.fac_list, 129);
+			if (test_facility(134)) {
+				set_kvm_facility(kvm->arch.model.fac_mask, 134);
+				set_kvm_facility(kvm->arch.model.fac_list, 134);
+			}
 			if (test_facility(135)) {
 				set_kvm_facility(kvm->arch.model.fac_mask, 135);
 				set_kvm_facility(kvm->arch.model.fac_list, 135);
-- 
2.7.4
