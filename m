From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/7] KVM: s390/cmm: Fix prefix handling for diag 10 balloon
Date: Wed, 10 Sep 2014 15:53:53 +0200
Message-ID: <1410357234-8937-7-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The old handling of prefix pages was broken in the diag10 ballooner.
We now rely on gmap_discard to check for start > end and do a
slow path if the prefix swap pages are affected:
1. discard the pages from start to prefix
2. discard the absolute 0 pages
3. discard the pages after prefix swap to end

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 arch/s390/kvm/diag.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index b374b6c..9254aff 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -28,22 +28,32 @@ static int diag_release_pages(struct kvm_vcpu *vcpu)
 	start = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
 	end = vcpu->run->s.regs.gprs[vcpu->arch.sie_block->ipa & 0xf] + 4096;
 
-	if (start & ~PAGE_MASK || end & ~PAGE_MASK || start > end
+	if (start & ~PAGE_MASK || end & ~PAGE_MASK || start >= end
 	    || start < 2 * PAGE_SIZE)
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	VCPU_EVENT(vcpu, 5, "diag release pages %lX %lX", start, end);
 	vcpu->stat.diagnose_10++;
 
-	/* we checked for start > end above */
-	if (end < prefix || start >= prefix + 2 * PAGE_SIZE) {
+	/*
+	 * We checked for start >= end above, so lets check for the
+	 * fast path (no prefix swap page involved)
+	 */
+	if (end <= prefix || start >= prefix + 2 * PAGE_SIZE) {
 		gmap_discard(vcpu->arch.gmap, start, end);
 	} else {
-		if (start < prefix)
-			gmap_discard(vcpu->arch.gmap, start, prefix);
-		if (end >= prefix)
-			gmap_discard(vcpu->arch.gmap,
-				     prefix + 2 * PAGE_SIZE, end);
+		/*
+		 * This is slow path.  gmap_discard will check for start
+		 * so lets split this into before prefix, prefix, after
+		 * prefix and let gmap_discard make some of these calls
+		 * NOPs.
+		 */
+		gmap_discard(vcpu->arch.gmap, start, prefix);
+		if (start <= prefix)
+			gmap_discard(vcpu->arch.gmap, 0, 4096);
+		if (end > prefix + 4096)
+			gmap_discard(vcpu->arch.gmap, 4096, 8192);
+		gmap_discard(vcpu->arch.gmap, prefix + 2 * PAGE_SIZE, end);
 	}
 	return 0;
 }
-- 
1.8.4.2
