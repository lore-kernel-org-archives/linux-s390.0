From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/4] s390/sclp: Detect KSS facility
Date: Fri, 21 Apr 2017 12:09:44 +0200
Message-ID: <1492769385-237420-4-git-send-email-borntraeger@de.ibm.com>
References: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1492769385-237420-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Farhan Ali <alifm@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Let's detect the keyless subset facility.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index ace3bd3..6f5167b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -75,6 +75,7 @@ struct sclp_info {
 	unsigned char has_pfmfi : 1;
 	unsigned char has_ibs : 1;
 	unsigned char has_skey : 1;
+	unsigned char has_kss : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 519ec17..efd84d1 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -40,7 +40,8 @@ struct read_info_sccb {
 	u8	fac85;			/* 85 */
 	u8	_pad_86[91 - 86];	/* 86-90 */
 	u8	flags;			/* 91 */
-	u8	_pad_92[99 - 92];	/* 92-98 */
+	u8	_pad_92[98 - 92];	/* 92-97 */
+	u8	fac98;			/* 98 */
 	u8	hamaxpow;		/* 99 */
 	u32	rnsize2;		/* 100-103 */
 	u64	rnmax2;			/* 104-111 */
@@ -99,6 +100,7 @@ static void __init sclp_early_facilities_detect(struct read_info_sccb *sccb)
 	sclp.has_pfmfi = !!(sccb->fac117 & 0x40);
 	sclp.has_ibs = !!(sccb->fac117 & 0x20);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
+	sclp.has_kss = !!(sccb->fac98 & 0x01);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
-- 
2.7.4
