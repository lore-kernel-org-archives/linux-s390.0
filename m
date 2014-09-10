From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/7] KVM: s390: Limit guest size to 16TB
Date: Wed, 10 Sep 2014 15:53:50 +0200
Message-ID: <1410357234-8937-4-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Currently we fill up a full 5 level page table to hold the guest
mapping. Since commit "support gmap page tables with less than 5
levels" we can do better.
Having more than 4 TB might be useful for some testing scenarios,
so let's just limit ourselves to 16TB guest size.
Having more than that is totally untested as I do not have enough
swap space/memory.

We continue to allow ucontrol the full size.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2037738..b95d4a4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -458,7 +458,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (type & KVM_VM_S390_UCONTROL) {
 		kvm->arch.gmap = NULL;
 	} else {
-		kvm->arch.gmap = gmap_alloc(current->mm, -1UL);
+		kvm->arch.gmap = gmap_alloc(current->mm, (1UL << 44) - 1);
 		if (!kvm->arch.gmap)
 			goto out_nogmap;
 		kvm->arch.gmap->private = kvm;
-- 
1.8.4.2
