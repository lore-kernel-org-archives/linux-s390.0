From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 11/12] KVM: s390: Fix RRBE return code not being CC
Date: Wed,  1 Feb 2017 12:38:13 +0100
Message-ID: <1485949094-138708-12-git-send-email-borntraeger@de.ibm.com>
References: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1485949094-138708-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

reset_guest_reference_bit needs to return the CC, so we can set it in
the guest PSW when emulating RRBE. Right now it only returns 0.

Let's fix that.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7a1897c..f70db83 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -741,7 +741,7 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 
 	pgste_set_unlock(ptep, new);
 	pte_unmap_unlock(ptep, ptl);
-	return 0;
+	return cc;
 }
 EXPORT_SYMBOL(reset_guest_reference_bit);
 
-- 
2.7.4
