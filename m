From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 31 May 2018 21:07:57 +0000
Subject: [GIT PULL 4/7] KVM: s390: no need to inititalize kvm->arch members to 0
Message-Id: <20180531210800.137347-5-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

KVM is allocated with kzalloc(), so these members are already 0.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 60bb3b7243d9..fd7ce3ab45eb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1989,10 +1989,10 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	rc = -ENOMEM;
 
-	kvm->arch.use_esca = 0; /* start with basic SCA */
 	if (!sclp.has_64bscao)
 		alloc_flags |= GFP_DMA;
 	rwlock_init(&kvm->arch.sca_lock);
+	/* start with basic SCA */
 	kvm->arch.sca = (struct bsca_block *) get_zeroed_page(alloc_flags);
 	if (!kvm->arch.sca)
 		goto out_err;
@@ -2043,8 +2043,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm_s390_crypto_init(kvm);
 
 	mutex_init(&kvm->arch.float_int.ais_lock);
-	kvm->arch.float_int.simm = 0;
-	kvm->arch.float_int.nimm = 0;
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
@@ -2070,12 +2068,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm->arch.gmap->pfault_enabled = 0;
 	}
 
-	kvm->arch.css_support = 0;
-	kvm->arch.use_irqchip = 0;
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.epoch = 0;
-
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	kvm_s390_gisa_init(kvm);
-- 
2.14.2
