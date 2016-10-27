From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] KVM: s390: Fix STHYI buffer alignment for diag224
Date: Thu, 27 Oct 2016 10:07:53 +0200
Message-ID: <1477555673-5876-2-git-send-email-borntraeger@de.ibm.com>
References: <1477555673-5876-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1477555673-5876-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v4.8+@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

Diag224 requires a page-aligned 4k buffer to store the name table
into. kmalloc does not guarantee page alignment, hence we replace it
with __get_free_page for the buffer allocation.

Cc: stable@vger.kernel.org # v4.8+
Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sthyi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/sthyi.c b/arch/s390/kvm/sthyi.c
index bd98b7d..05c98bb 100644
--- a/arch/s390/kvm/sthyi.c
+++ b/arch/s390/kvm/sthyi.c
@@ -315,7 +315,7 @@ static void fill_diag(struct sthyi_sctns *sctns)
 	if (r < 0)
 		goto out;
 
-	diag224_buf = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
+	diag224_buf = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
 	if (!diag224_buf || diag224(diag224_buf))
 		goto out;
 
@@ -378,7 +378,7 @@ static void fill_diag(struct sthyi_sctns *sctns)
 	sctns->par.infpval1 |= PAR_WGHT_VLD;
 
 out:
-	kfree(diag224_buf);
+	free_page((unsigned long)diag224_buf);
 	vfree(diag204_buf);
 }
 
-- 
2.5.5
