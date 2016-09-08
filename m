From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/11] KVM: s390: Use memdup_user() rather than duplicating code
Date: Thu,  8 Sep 2016 14:00:23 +0200
Message-ID: <1473336023-15522-12-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Markus Elfring <elfring@users.sourceforge.net>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  This issue was detected by using the Coccinelle software.

* Return directly if this copy operation failed.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Message-Id: <c86f7520-885e-2829-ae9c-b81caa898e84@users.sourceforge.net>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index 70b71ac..d7c6a7f 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -216,20 +216,10 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
 		return -EINVAL;
 
-	bp_data = kmalloc_array(dbg->arch.nr_hw_bp,
-				sizeof(*bp_data),
-				GFP_KERNEL);
-	if (!bp_data) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (copy_from_user(bp_data,
-			   dbg->arch.hw_bp,
-			   sizeof(*bp_data) * dbg->arch.nr_hw_bp)) {
-		ret = -EFAULT;
-		goto error;
-	}
+	bp_data = memdup_user(dbg->arch.hw_bp,
+			      sizeof(*bp_data) * dbg->arch.nr_hw_bp);
+	if (IS_ERR(bp_data))
+		return PTR_ERR(bp_data);
 
 	for (i = 0; i < dbg->arch.nr_hw_bp; i++) {
 		switch (bp_data[i].type) {
-- 
2.5.5
