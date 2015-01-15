From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 12/21] s390/sclp: introduce check for the SIGP Interpretation Facility
Date: Thu, 15 Jan 2015 14:43:25 +0100
Message-ID: <1421329414-76826-13-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch introduces the infrastructure to check whether the SIGP
Interpretation Facility is installed on all VCPUs in the configuration.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   | 4 +++-
 drivers/s390/char/sclp_early.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 1aba89b..425e6cc 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -31,7 +31,8 @@ struct sclp_cpu_entry {
 	u8 reserved0[2];
 	u8 : 3;
 	u8 siif : 1;
-	u8 : 4;
+	u8 sigpif : 1;
+	u8 : 3;
 	u8 reserved2[10];
 	u8 type;
 	u8 reserved1;
@@ -66,6 +67,7 @@ int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode);
 unsigned long sclp_get_hsa_size(void);
 void sclp_early_detect(void);
 int sclp_has_siif(void);
+int sclp_has_sigpif(void);
 unsigned int sclp_get_ibc(void);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 5bd6cb1..b8a5bf5 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -49,6 +49,7 @@ static unsigned long sclp_hsa_size;
 static unsigned int sclp_max_cpu;
 static struct sclp_ipl_info sclp_ipl_info;
 static unsigned char sclp_siif;
+static unsigned char sclp_sigpif;
 static u32 sclp_ibc;
 
 u64 sclp_facilities;
@@ -131,6 +132,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 		if (boot_cpu_address != cpue->address)
 			continue;
 		sclp_siif = cpue->siif;
+		sclp_sigpif = cpue->sigpif;
 		break;
 	}
 
@@ -172,6 +174,12 @@ int sclp_has_siif(void)
 }
 EXPORT_SYMBOL(sclp_has_siif);
 
+int sclp_has_sigpif(void)
+{
+	return sclp_sigpif;
+}
+EXPORT_SYMBOL(sclp_has_sigpif);
+
 unsigned int sclp_get_ibc(void)
 {
 	return sclp_ibc;
-- 
1.9.3
