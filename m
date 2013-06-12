From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 3/6] KVM: s390: code cleanup to use common vcpu slab cache
Date: Wed, 12 Jun 2013 13:54:54 +0200
Message-ID: <1371038097-28577-4-git-send-email-cornelia.huck@de.ibm.com>
References: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1371038097-28577-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

cleanup of arch specific code to use common code provided vcpu slab cache
instead of kzalloc() provided memory

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e56caec..757e1c6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -278,7 +278,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	free_page((unsigned long)(vcpu->arch.sie_block));
 	kvm_vcpu_uninit(vcpu);
-	kfree(vcpu);
+	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
 static void kvm_free_vcpus(struct kvm *kvm)
@@ -408,7 +408,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	rc = -ENOMEM;
 
-	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+	vcpu = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
 	if (!vcpu)
 		goto out;
 
@@ -453,7 +453,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 out_free_sie_block:
 	free_page((unsigned long)(vcpu->arch.sie_block));
 out_free_cpu:
-	kfree(vcpu);
+	kmem_cache_free(kvm_vcpu_cache, vcpu);
 out:
 	return ERR_PTR(rc);
 }
-- 
1.8.1.6
