From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 4/5] KVM: s390: vsie: Always test the crycbd for NULL
Date: Wed, 22 Aug 2018 18:51:56 +0200
Message-ID: <1534956717-14087-5-git-send-email-pmorel@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

BUG: the crycbd must be tested for null even if
not crossing a page boundary (which will never
occur in this case anyway).

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0b12916..7ee4329 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -172,7 +172,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 
 	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
 		return set_validity_icpt(scb_s, 0x003CU);
-	else if (!crycb_addr)
+	if (!crycb_addr)
 		return set_validity_icpt(scb_s, 0x0039U);
 
 	/* copy only the wrapping keys */
-- 
2.7.4
