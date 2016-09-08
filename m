From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/11] KVM: s390: Improve determination of sizes in kvm_s390_import_bp_data()
Date: Thu,  8 Sep 2016 14:00:22 +0200
Message-ID: <1473336023-15522-11-git-send-email-borntraeger@de.ibm.com>
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

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kmalloc_array".

  Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

  This issue was detected also by using the Coccinelle software.

* Replace the specification of data structures by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

* Delete the local variable "size" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Message-Id: <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/guestdbg.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index d1f8241..70b71ac 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -206,7 +206,7 @@ static int __import_wp_info(struct kvm_vcpu *vcpu,
 int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 			    struct kvm_guest_debug *dbg)
 {
-	int ret = 0, nr_wp = 0, nr_bp = 0, i, size;
+	int ret = 0, nr_wp = 0, nr_bp = 0, i;
 	struct kvm_hw_breakpoint *bp_data = NULL;
 	struct kvm_hw_wp_info_arch *wp_info = NULL;
 	struct kvm_hw_bp_info_arch *bp_info = NULL;
@@ -216,14 +216,17 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
 		return -EINVAL;
 
-	size = dbg->arch.nr_hw_bp * sizeof(struct kvm_hw_breakpoint);
-	bp_data = kmalloc(size, GFP_KERNEL);
+	bp_data = kmalloc_array(dbg->arch.nr_hw_bp,
+				sizeof(*bp_data),
+				GFP_KERNEL);
 	if (!bp_data) {
 		ret = -ENOMEM;
 		goto error;
 	}
 
-	if (copy_from_user(bp_data, dbg->arch.hw_bp, size)) {
+	if (copy_from_user(bp_data,
+			   dbg->arch.hw_bp,
+			   sizeof(*bp_data) * dbg->arch.nr_hw_bp)) {
 		ret = -EFAULT;
 		goto error;
 	}
@@ -241,17 +244,19 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
 		}
 	}
 
-	size = nr_wp * sizeof(struct kvm_hw_wp_info_arch);
-	if (size > 0) {
-		wp_info = kmalloc(size, GFP_KERNEL);
+	if (nr_wp > 0) {
+		wp_info = kmalloc_array(nr_wp,
+					sizeof(*wp_info),
+					GFP_KERNEL);
 		if (!wp_info) {
 			ret = -ENOMEM;
 			goto error;
 		}
 	}
-	size = nr_bp * sizeof(struct kvm_hw_bp_info_arch);
-	if (size > 0) {
-		bp_info = kmalloc(size, GFP_KERNEL);
+	if (nr_bp > 0) {
+		bp_info = kmalloc_array(nr_bp,
+					sizeof(*bp_info),
+					GFP_KERNEL);
 		if (!bp_info) {
 			ret = -ENOMEM;
 			goto error;
-- 
2.5.5
