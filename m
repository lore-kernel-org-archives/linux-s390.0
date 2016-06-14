From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 30/52] s390/sclp: detect conditional-external-interception facility
Date: Tue, 14 Jun 2016 20:57:07 +0200
Message-ID: <201606141857.u5EIs2pX000843@mx0b-001b2d01.pphosted.com>
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

Let's detect if we have that facility.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 4 +++-
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index ef1f427..c91ad19 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -41,7 +41,8 @@ struct sclp_core_entry {
 	u8 reserved2[3];
 	u8 : 2;
 	u8 ib : 1;
-	u8 : 5;
+	u8 cei : 1;
+	u8 : 4;
 	u8 reserved3[6];
 	u8 type;
 	u8 reserved1;
@@ -69,6 +70,7 @@ struct sclp_info {
 	unsigned char has_cmma : 1;
 	unsigned char has_gsls : 1;
 	unsigned char has_ib : 1;
+	unsigned char has_cei : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 2240b61..4b330fb 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -150,6 +150,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 		sclp.has_sief2 = cpue->sief2;
 		sclp.has_gpere = cpue->gpere;
 		sclp.has_ib = cpue->ib;
+		sclp.has_cei = cpue->cei;
 		break;
 	}
 
-- 
2.5.5
