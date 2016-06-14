From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 32/52] s390/sclp: detect PFMF interpretation facility
Date: Tue, 14 Jun 2016 20:57:09 +0200
Message-ID: <1465930649-181383-33-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's detect that facility.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index c91ad19..bdb7f22 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -71,6 +71,7 @@ struct sclp_info {
 	unsigned char has_gsls : 1;
 	unsigned char has_ib : 1;
 	unsigned char has_cei : 1;
+	unsigned char has_pfmfi : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 4b330fb..500cbfd 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -46,7 +46,8 @@ struct read_info_sccb {
 	u64	rnmax2;			/* 104-111 */
 	u8	_pad_112[116 - 112];	/* 112-115 */
 	u8	fac116;			/* 116 */
-	u8	_pad_117[119 - 117];	/* 117-118 */
+	u8	fac117;			/* 117 */
+	u8	_pad_118;		/* 118 */
 	u8	fac119;			/* 119 */
 	u16	hcpua;			/* 120-121 */
 	u8	_pad_122[124 - 122];	/* 122-123 */
@@ -118,6 +119,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.has_64bscao = !!(sccb->fac116 & 0x80);
 	sclp.has_cmma = !!(sccb->fac116 & 0x40);
 	sclp.has_esca = !!(sccb->fac116 & 0x08);
+	sclp.has_pfmfi = !!(sccb->fac117 & 0x40);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
-- 
2.5.5
