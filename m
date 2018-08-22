From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Wed, 22 Aug 2018 18:51:53 +0200
Message-ID: <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Copy the key mask to the right offset inside the shadow CRYCB

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 9175518..12b9707 100644
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
2.7.4
