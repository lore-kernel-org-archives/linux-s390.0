From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 1/2] KVM: s390: Improve determination of sizes in
 kvm_s390_import_bp_data()
Date: Wed, 24 Aug 2016 20:36:26 +0200
Message-ID: <c3323f6b-4af2-0bfb-9399-e529952e378e@users.sourceforge.net>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <bb710b21-d8c4-e172-63d4-b46c80645cb3@users.sourceforge.net>
 <ddb2bbd9-757b-fc62-8642-ce827a7a666d@de.ibm.com>
 <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e72e9854-443b-7033-d674-8a2d237600ca@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Walter Harms <wharms@bfs.de>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Aug 2016 19:45:23 +0200

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
---

v2: Rebased on source files from "Linux next-20160824".
    Advices were integrated from source code review.

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
2.9.3
