From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/5] KVM: s390: non-LPAR case obsolete during facilities mask init
Date: Wed,  4 Mar 2015 12:41:54 +0100
Message-ID: <1425469314-48913-6-git-send-email-borntraeger@de.ibm.com>
References: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425469314-48913-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

With patch "include guest facilities in kvm facility test" it is no
longer necessary to have special handling for the non-LPAR case.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5a02be4..f6579cf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -902,24 +902,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (!kvm->arch.model.fac)
 		goto out_nofac;
 
+	/* Populate the facility mask initially. */
 	memcpy(kvm->arch.model.fac->mask, S390_lowcore.stfle_fac_list,
 	       S390_ARCH_FAC_LIST_SIZE_BYTE);
-
-	/*
-	 * If this KVM host runs *not* in a LPAR, relax the facility bits
-	 * of the kvm facility mask by all missing facilities. This will allow
-	 * to determine the right CPU model by means of the remaining facilities.
-	 * Live guest migration must prohibit the migration of KVMs running in
-	 * a LPAR to non LPAR hosts.
-	 */
-	if (!MACHINE_IS_LPAR)
-		for (i = 0; i < kvm_s390_fac_list_mask_size(); i++)
-			kvm_s390_fac_list_mask[i] &= kvm->arch.model.fac->mask[i];
-
-	/*
-	 * Apply the kvm facility mask to limit the kvm supported/tolerated
-	 * facility list.
-	 */
 	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
 		if (i < kvm_s390_fac_list_mask_size())
 			kvm->arch.model.fac->mask[i] &= kvm_s390_fac_list_mask[i];
-- 
2.3.0
