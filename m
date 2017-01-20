From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: do not expose random data via facility bitmap
Date: Fri, 20 Jan 2017 16:04:59 +0100
Message-ID: <1484924699-183878-2-git-send-email-borntraeger@de.ibm.com>
References: <1484924699-183878-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1484924699-183878-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

kvm_s390_get_machine() populates the facility bitmap by copying bytes
from the host results that are stored in a 256 byte array in the prefix
page. The KVM code does use the size of the target buffer (2k), thus
copying and exposing unrelated kernel memory (mostly machine check
related logout data).

Let's use the size of the source buffer instead.  This is ok, as the
target buffer will always be greater or equal than the source buffer as
the KVM internal buffers (and thus S390_ARCH_FAC_LIST_SIZE_BYTE) cover
the maximum possible size that is allowed by STFLE, which is 256
doublewords. All structures are zero allocated so we can leave bytes
256-2047 unchanged.

Add a similar fix for kvm_arch_init_vm().

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
[found with smatch]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: stable@vger.kernel.org
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index bec71e9..6484a25 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -916,7 +916,7 @@ static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
 	memcpy(&mach->fac_mask, kvm->arch.model.fac_mask,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
-	       S390_ARCH_FAC_LIST_SIZE_BYTE);
+	       sizeof(S390_lowcore.stfle_fac_list));
 	if (copy_to_user((void __user *)attr->addr, mach, sizeof(*mach)))
 		ret = -EFAULT;
 	kfree(mach);
@@ -1437,7 +1437,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	/* Populate the facility mask initially. */
 	memcpy(kvm->arch.model.fac_mask, S390_lowcore.stfle_fac_list,
-	       S390_ARCH_FAC_LIST_SIZE_BYTE);
+	       sizeof(S390_lowcore.stfle_fac_list));
 	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
 		if (i < kvm_s390_fac_list_mask_size())
 			kvm->arch.model.fac_mask[i] &= kvm_s390_fac_list_mask[i];
-- 
2.7.4
