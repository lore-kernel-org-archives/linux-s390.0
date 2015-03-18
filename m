From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/11] KVM: s390: cleanup jump lables in kvm_arch_init_vm
Date: Wed, 18 Mar 2015 12:44:00 +0100
Message-ID: <1426679049-37696-3-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

As all cleanup functions can handle their respective NULL case
there is no need to have more than one error jump label.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 02e03c8..4075acb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -897,7 +897,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.dbf = debug_register(debug_name, 8, 2, 8 * sizeof(long));
 	if (!kvm->arch.dbf)
-		goto out_nodbf;
+		goto out_err;
 
 	/*
 	 * The architectural maximum amount of facilities is 16 kbit. To store
@@ -909,7 +909,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.model.fac =
 		(struct kvm_s390_fac *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!kvm->arch.model.fac)
-		goto out_nofac;
+		goto out_err;
 
 	/* Populate the facility mask initially. */
 	memcpy(kvm->arch.model.fac->mask, S390_lowcore.stfle_fac_list,
@@ -929,7 +929,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.model.ibc = sclp_get_ibc() & 0x0fff;
 
 	if (kvm_s390_crypto_init(kvm) < 0)
-		goto out_crypto;
+		goto out_err;
 
 	spin_lock_init(&kvm->arch.float_int.lock);
 	INIT_LIST_HEAD(&kvm->arch.float_int.list);
@@ -944,7 +944,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	} else {
 		kvm->arch.gmap = gmap_alloc(current->mm, (1UL << 44) - 1);
 		if (!kvm->arch.gmap)
-			goto out_nogmap;
+			goto out_err;
 		kvm->arch.gmap->private = kvm;
 		kvm->arch.gmap->pfault_enabled = 0;
 	}
@@ -957,15 +957,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	spin_lock_init(&kvm->arch.start_stop_lock);
 
 	return 0;
-out_nogmap:
+out_err:
 	kfree(kvm->arch.crypto.crycb);
-out_crypto:
 	free_page((unsigned long)kvm->arch.model.fac);
-out_nofac:
 	debug_unregister(kvm->arch.dbf);
-out_nodbf:
 	free_page((unsigned long)(kvm->arch.sca));
-out_err:
 	return rc;
 }
 
-- 
2.3.0
