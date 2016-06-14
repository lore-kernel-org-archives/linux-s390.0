From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:57:00 +0000
Subject: [GIT PULL 23/52] s390/sclp: detect cmma
Message-Id: <201606141857.u5EIsTj9007919@mx0a-001b2d01.pphosted.com>
In-Reply-To: <201606141857.u5EIs0f9052344@mx0b-001b2d01.pphosted.com>
References: <201606141857.u5EIs0f9052344@mx0b-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's detect the Collaborative-memory-management-interpretation facility,
aka CMM assist, so we can correctly enable cmma later.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 076f631..fa40ac8 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -62,6 +62,7 @@ struct sclp_info {
 	unsigned char has_sief2 : 1;
 	unsigned char has_64bscao : 1;
 	unsigned char has_gpere : 1;
+	unsigned char has_cmma : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index a05f2d0..366e1a4 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -115,6 +115,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.has_sprp = !!(sccb->fac84 & 0x02);
 	sclp.has_core_type = !!(sccb->fac84 & 0x01);
 	sclp.has_64bscao = !!(sccb->fac116 & 0x80);
+	sclp.has_cmma = !!(sccb->fac116 & 0x40);
 	sclp.has_esca = !!(sccb->fac116 & 0x08);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	if (sccb->fac85 & 0x02)
-- 
2.5.5
