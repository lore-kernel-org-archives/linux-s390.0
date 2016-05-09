From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/10] KVM: s390: cmma: don't check entry content
Date: Mon,  9 May 2016 11:20:12 +0200
Message-ID: <1462785621-12600-2-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We should never inject an exception after we manually rewound the PSW
(to retry the ESSA instruction in this case). This will mess up the PSW.
So this never worked and therefore never really triggered.

Looking at the details, we don't even have to perform any validity checks.
1. Bits 52-63 of an entry are stored as 0 by the hardware.
2. We are dealing with absolute addresses but only check for the prefix
   starting at address 0. This isn't correct and doesn't make much sense,
   cpus could still zap the prefix of other cpus. But as prefix pages
   cannot be swapped out without a notifier being called for the affected
   VCPU, a zap can never remove a protected prefix.

Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 0a1591d..3561119 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -744,7 +744,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 {
 	/* entries expected to be 1FF */
 	int entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
-	unsigned long *cbrlo, cbrle;
+	unsigned long *cbrlo;
 	struct gmap *gmap;
 	int i;
 
@@ -765,17 +765,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->cbrlo &= PAGE_MASK;	/* reset nceo */
 	cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo);
 	down_read(&gmap->mm->mmap_sem);
-	for (i = 0; i < entries; ++i) {
-		cbrle = cbrlo[i];
-		if (unlikely(cbrle & ~PAGE_MASK || cbrle < 2 * PAGE_SIZE))
-			/* invalid entry */
-			break;
-		/* try to free backing */
-		__gmap_zap(gmap, cbrle);
-	}
+	for (i = 0; i < entries; ++i)
+		__gmap_zap(gmap, cbrlo[i]);
 	up_read(&gmap->mm->mmap_sem);
-	if (i < entries)
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	return 0;
 }
 
-- 
2.5.5
