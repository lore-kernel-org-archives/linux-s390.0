From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] s390/kvm,tprot: use new gmap_translate() function
Date: Tue,  5 Mar 2013 13:14:42 +0100
Message-ID: <1362485687-2799-4-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When out-of-memory the tprot code incorrectly injected a program check
for the guest which reported an addressing exception even if the guest
address was valid.
Let's use the new gmap_translate() which translates a guest address to
a user space address whithout the chance of running into an out-of-memory
situation.
Also make it more explicit that for -EFAULT we won't find a vma.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 0ef9894..75ad91e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -575,20 +575,13 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
 		return -EOPNOTSUPP;
 
-
-	/* we must resolve the address without holding the mmap semaphore.
-	 * This is ok since the userspace hypervisor is not supposed to change
-	 * the mapping while the guest queries the memory. Otherwise the guest
-	 * might crash or get wrong info anyway. */
-	user_address = (unsigned long) __guestaddr_to_user(vcpu, address1);
-
 	down_read(&current->mm->mmap_sem);
+	user_address = __gmap_translate(address1, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(user_address))
+		goto out_inject;
 	vma = find_vma(current->mm, user_address);
-	if (!vma) {
-		up_read(&current->mm->mmap_sem);
-		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	}
-
+	if (!vma)
+		goto out_inject;
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	if (!(vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_READ))
 		vcpu->arch.sie_block->gpsw.mask |= (1ul << 44);
@@ -597,6 +590,10 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 
 	up_read(&current->mm->mmap_sem);
 	return 0;
+
+out_inject:
+	up_read(&current->mm->mmap_sem);
+	return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 }
 
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu)
-- 
1.8.0.1
