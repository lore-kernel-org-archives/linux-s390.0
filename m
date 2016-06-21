From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/51] s390/mm: push ste protection down to shadow pte
Date: Tue, 21 Jun 2016 15:12:52 +0200
Message-ID: <1466514809-146638-15-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If a guest ste is read-only, it doesn't make sense to force the ptes in as
writable in the host. If the source page is read-only in the host, it won't
have to be made writable. Please note that if the source page is not
available, it will still be faulted in writable. This can be changed
internally later on.

If ste protection is removed, underlying shadow tables are also removed,
therefore this change does not affect the guest.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index e70f916..a85bc6c 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1111,6 +1111,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 		rc = PGM_PAGE_TRANSLATION;
 	if (!rc && (pte.z || pte.co))
 		rc = PGM_TRANSLATION_SPEC;
+	pte.p |= dat_protection;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
 	ipte_unlock(vcpu);
-- 
2.5.5
