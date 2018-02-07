From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 5/6] KVM: s390: no need to inititalize kvm->arch members to 0
Date: Wed,  7 Feb 2018 12:46:46 +0100
Message-ID: <20180207114647.6220-6-david@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

KVM is allocated with kzalloc(), so these members are already 0.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c2b62379049e..0c0eed7d60a8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1972,8 +1972,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
 		if (i < kvm_s390_fac_list_mask_size())
 			kvm->arch.model.fac_mask[i] &= kvm_s390_fac_list_mask[i];
-		else
-			kvm->arch.model.fac_mask[i] = 0UL;
 	}
 
 	/* Populate the facility list initially. */
@@ -1998,8 +1996,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm_s390_crypto_init(kvm);
 
 	mutex_init(&kvm->arch.float_int.ais_lock);
-	kvm->arch.float_int.simm = 0;
-	kvm->arch.float_int.nimm = 0;
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
 		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
@@ -2025,10 +2021,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm->arch.gmap->pfault_enabled = 0;
 	}
 
-	kvm->arch.css_support = 0;
-	kvm->arch.use_irqchip = 0;
-	kvm->arch.epoch = 0;
-
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	kvm_s390_gisa_init(kvm);
-- 
2.14.3
