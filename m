From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 19/52] s390/sclp: detect 64-bit-SCAO facility
Date: Tue, 14 Jun 2016 20:56:56 +0200
Message-ID: <201606141857.u5EIs1RW040015@mx0b-001b2d01.pphosted.com>
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

Let's correctly detect that facility, so we can correctly handle its
abscence later on.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 49736a0..5214000 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -59,6 +59,7 @@ struct sclp_info {
 	unsigned char has_hvs : 1;
 	unsigned char has_esca : 1;
 	unsigned char has_sief2 : 1;
+	unsigned char has_64bscao : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 0ac520d..211eb86a 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -114,6 +114,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.facilities = sccb->facilities;
 	sclp.has_sprp = !!(sccb->fac84 & 0x02);
 	sclp.has_core_type = !!(sccb->fac84 & 0x01);
+	sclp.has_64bscao = !!(sccb->fac116 & 0x80);
 	sclp.has_esca = !!(sccb->fac116 & 0x08);
 	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	if (sccb->fac85 & 0x02)
-- 
2.5.5
