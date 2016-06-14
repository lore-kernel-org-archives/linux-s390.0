From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 50/52] s390/sclp: detect storage-key facility
Date: Tue, 14 Jun 2016 20:57:27 +0200
Message-ID: <1465930649-181383-51-git-send-email-borntraeger@de.ibm.com>
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

Let's correctly detect that facility.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 4 +++-
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 99a0150..2ad9c20 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -32,7 +32,8 @@ struct sclp_core_entry {
 	u8 reserved0;
 	u8 : 4;
 	u8 sief2 : 1;
-	u8 : 3;
+	u8 skey : 1;
+	u8 : 2;
 	u8 : 2;
 	u8 gpere : 1;
 	u8 siif : 1;
@@ -73,6 +74,7 @@ struct sclp_info {
 	unsigned char has_cei : 1;
 	unsigned char has_pfmfi : 1;
 	unsigned char has_ibs : 1;
+	unsigned char has_skey : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index d5b873c..c71df0c 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -154,6 +154,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 		sclp.has_gpere = cpue->gpere;
 		sclp.has_ib = cpue->ib;
 		sclp.has_cei = cpue->cei;
+		sclp.has_skey = cpue->skey;
 		break;
 	}
 
-- 
2.5.5
