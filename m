From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 19/23] s390/sclp: introduce check for SIE
Date: Wed,  2 Dec 2015 12:06:20 +0100
Message-ID: <1449054384-76374-20-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch adds a way to check if the SIE with zArchitecture support is
available.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 6 +++++-
 drivers/s390/char/sclp_early.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 8324abb..dea883f 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -29,7 +29,10 @@ struct sclp_ipl_info {
 
 struct sclp_core_entry {
 	u8 core_id;
-	u8 reserved0[2];
+	u8 reserved0;
+	u8 : 4;
+	u8 sief2 : 1;
+	u8 : 3;
 	u8 : 3;
 	u8 siif : 1;
 	u8 sigpif : 1;
@@ -55,6 +58,7 @@ struct sclp_info {
 	unsigned char has_sprp : 1;
 	unsigned char has_hvs : 1;
 	unsigned char has_esca : 1;
+	unsigned char has_sief2 : 1;
 	unsigned int ibc;
 	unsigned int mtid;
 	unsigned int mtid_cp;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index ff1e1bb..e0a1f4e 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -136,6 +136,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 			continue;
 		sclp.has_siif = cpue->siif;
 		sclp.has_sigpif = cpue->sigpif;
+		sclp.has_sief2 = cpue->sief2;
 		break;
 	}
 
-- 
2.3.0
