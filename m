From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:57:11 +0000
Subject: [GIT PULL 34/52] s390/sclp: detect interlock-and-broadcast-suppression facility
Message-Id: <201606141857.u5EItq3O145321@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's detect that facility.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index bdb7f22..99a0150 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -72,6 +72,7 @@ struct sclp_info {
 	unsigned char has_ib : 1;
 	unsigned char has_cei : 1;
 	unsigned char has_pfmfi : 1;
+	unsigned char has_ibs : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 500cbfd..d5b873c 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -120,6 +120,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.has_cmma = !!(sccb->fac116 & 0x40);
 	sclp.has_esca = !!(sccb->fac116 & 0x08);
 	sclp.has_pfmfi = !!(sccb->fac117 & 0x40);
+	sclp.has_ibs = !!(sccb->fac117 & 0x20);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
-- 
2.5.5
