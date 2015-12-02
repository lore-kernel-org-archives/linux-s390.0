From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/23] s390/sclp: introduce checks for ESCA and HVS
Date: Wed,  2 Dec 2015 12:06:06 +0100
Message-ID: <1449054384-76374-6-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

Introduce sclp.has_hvs and sclp.has_esca to provide a way for kvm to check
whether the extended-SCA and the home-virtual-SCA facilities are available.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 2 ++
 drivers/s390/char/sclp_early.c | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 821dde5..8324abb 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -53,6 +53,8 @@ struct sclp_info {
 	unsigned char has_sigpif : 1;
 	unsigned char has_core_type : 1;
 	unsigned char has_sprp : 1;
+	unsigned char has_hvs : 1;
+	unsigned char has_esca : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 7bc6df3..ff1e1bb 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -43,7 +43,10 @@ struct read_info_sccb {
 	u8	_pad_92[100 - 92];	/* 92-99 */
 	u32	rnsize2;		/* 100-103 */
 	u64	rnmax2;			/* 104-111 */
-	u8	_pad_112[120 - 112];	/* 112-119 */
+	u8	_pad_112[116 - 112];	/* 112-115 */
+	u8	fac116;			/* 116 */
+	u8	_pad_117[119 - 117];	/* 117-118 */
+	u8	fac119;			/* 119 */
 	u16	hcpua;			/* 120-121 */
 	u8	_pad_122[4096 - 122];	/* 122-4095 */
 } __packed __aligned(PAGE_SIZE);
@@ -108,6 +111,8 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.facilities = sccb->facilities;
 	sclp.has_sprp = !!(sccb->fac84 & 0x02);
 	sclp.has_core_type = !!(sccb->fac84 & 0x01);
+	sclp.has_esca = !!(sccb->fac116 & 0x08);
+	sclp.has_hvs = !!(sccb->fac119 & 0x80);
 	if (sccb->fac85 & 0x02)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_ESOP;
 	sclp.rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
-- 
2.3.0
