From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:24 +0000
Subject: [GIT PULL 13/18] KVM: s390: kvm_s390_gisa_clear() now clears the IPM only
Message-Id: <1550835749-26436-14-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

Function kvm_s390_gisa_clear() now clears the Interruption
Pending Mask of the GISA asap. If the GISA is in the alert
list at this time it stays in the list but is removed by
process_gib_alert_list().

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <20190131085247.13826-13-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 040745b..9faaa8f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -249,6 +249,25 @@ static inline int gisa_set_iam(struct kvm_s390_gisa *gisa, u8 iam)
 	return 0;
 }
 
+/**
+ * gisa_clear_ipm - clear the GISA interruption pending mask
+ *
+ * @gisa: gisa to operate on
+ *
+ * Clear the IPM atomically with the next alert address and the IAM
+ * of the GISA unconditionally. All three fields are located in the
+ * first long word of the GISA.
+ */
+static inline void gisa_clear_ipm(struct kvm_s390_gisa *gisa)
+{
+	u64 word, _word;
+
+	do {
+		word = READ_ONCE(gisa->u64.word[0]);
+		_word = word & ~(0xffUL << 24);
+	} while (cmpxchg(&gisa->u64.word[0], word, _word) != word);
+}
+
 static inline void gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
 {
 	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
@@ -2926,8 +2945,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 
 	if (!gi->origin)
 		return;
-	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
-	gi->origin->next_alert = (u32)(u64)gi->origin;
+	gisa_clear_ipm(gi->origin);
 	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", gi->origin);
 }
 
@@ -2940,7 +2958,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	gi->origin = &kvm->arch.sie_page2->gisa;
 	gi->alert.mask = 0;
 	spin_lock_init(&gi->alert.ref_lock);
-	kvm_s390_gisa_clear(kvm);
+	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
+	gi->origin->next_alert = (u32)(u64)gi->origin;
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
 }
 
-- 
2.7.4
