From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/10] s390/sclp: Add hmfai field
Date: Mon,  9 May 2016 11:20:20 +0200
Message-ID: <1462785621-12600-10-git-send-email-borntraeger@de.ibm.com>
References: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462785621-12600-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

Let's add hypervisor-managed facility-apportionment indications field to
SCLP structs. KVM will use it to reduce maintenance cost of
Non-Hypervisor-Managed facility bits.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 1 +
 drivers/s390/char/sclp_early.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index bab456b..994a66c 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -69,6 +69,7 @@ struct sclp_info {
 	unsigned int max_cores;
 	unsigned long hsa_size;
 	unsigned long facilities;
+	unsigned int hmfai;
 };
 extern struct sclp_info sclp;
 
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 6804354..0ac520d 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -49,7 +49,9 @@ struct read_info_sccb {
 	u8	_pad_117[119 - 117];	/* 117-118 */
 	u8	fac119;			/* 119 */
 	u16	hcpua;			/* 120-121 */
-	u8	_pad_122[4096 - 122];	/* 122-4095 */
+	u8	_pad_122[124 - 122];	/* 122-123 */
+	u32	hmfai;			/* 124-127 */
+	u8	_pad_128[4096 - 128];	/* 128-4095 */
 } __packed __aligned(PAGE_SIZE);
 
 static char sccb_early[PAGE_SIZE] __aligned(PAGE_SIZE) __initdata;
@@ -155,6 +157,8 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp.mtid = (sccb->fac42 & 0x80) ? (sccb->fac42 & 31) : 0;
 	sclp.mtid_cp = (sccb->fac42 & 0x80) ? (sccb->fac43 & 31) : 0;
 	sclp.mtid_prev = (sccb->fac42 & 0x80) ? (sccb->fac66 & 31) : 0;
+
+	sclp.hmfai = sccb->hmfai;
 }
 
 /*
-- 
2.5.5
