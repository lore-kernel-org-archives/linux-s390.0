From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 05 Sep 2018 08:29:48 +0000
Subject: [GIT PULL 2/3] KVM: s390: vsie: copy wrapping keys to right place
Message-Id: <20180905082949.100517-3-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

Copy the key mask to the right offset inside the shadow CRYCB

Fixes: bbeaa58b3 ("KVM: s390: vsie: support aes dea wrapping keys")
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.8+
Message-Id: <1535019956-23539-2-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 63844b95c22c..a2b28cd1e3fe 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0039U);
 
 	/* copy only the wrapping keys */
-	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
+	if (read_guest_real(vcpu, crycb_addr + 72,
+			    vsie_page->crycb.dea_wrapping_key_mask, 56))
 		return set_validity_icpt(scb_s, 0x0035U);
 
 	scb_s->ecb3 |= ecb3_flags;
-- 
2.17.0
