From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:44 +0000
Subject: [GIT PULL 17/28] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Message-Id: <20181002070655.224110-18-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

The comment preceding the shadow_crycb function is
misleading, we effectively accept FORMAT2 CRYCB in the
guest.

When using FORMAT2 in the host we do not need to or with
FORMAT1.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180925231641.4954-18-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 38ea5da4e642..e0e6fbfa88f4 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
  * Create a shadow copy of the crycb block and setup key wrapping, if
  * requested for guest 3 and enabled for guest 2.
  *
- * We only accept format-1 (no AP in g2), but convert it into format-2
+ * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
+ * and we convert it into format-2 in the shadow CRYCB.
  * There is nothing to do for format-0.
  *
  * Returns: - 0 if shadowed or nothing to do
@@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
-			CRYCB_FORMAT2;
+	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
 
 	/* xor both blocks in one run */
 	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
-- 
2.17.0
