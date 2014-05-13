From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v1 RFC 1/6] s390/sclp: add sclp_get_ibc function
Date: Tue, 13 May 2014 16:58:29 +0200
Message-ID: <1399993114-15333-2-git-send-email-mimu@linux.vnet.ibm.com>
References: <1399993114-15333-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1399993114-15333-1-git-send-email-mimu@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mimu@linux.vnet.ibm.com, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

The patch adds functionality to retrieve the IBC configuration
by means of function sclp_get_ibc().

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h   |  1 +
 drivers/s390/char/sclp_early.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 943d434..1aba89b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -66,5 +66,6 @@ int memcpy_hsa(void *dest, unsigned long src, size_t count, int mode);
 unsigned long sclp_get_hsa_size(void);
 void sclp_early_detect(void);
 int sclp_has_siif(void);
+unsigned int sclp_get_ibc(void);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index b57fe0e..1918d9d 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -27,7 +27,9 @@ struct read_info_sccb {
 	u8	loadparm[8];		/* 24-31 */
 	u8	_reserved1[48 - 32];	/* 32-47 */
 	u64	facilities;		/* 48-55 */
-	u8	_reserved2[84 - 56];	/* 56-83 */
+	u8	_reserved2a[76 - 56];	/* 56-75 */
+	u32	ibc;			/* 76-79 */
+	u8	_reserved2b[84 - 80];	/* 80-83 */
 	u8	fac84;			/* 84 */
 	u8	fac85;			/* 85 */
 	u8	_reserved3[91 - 86];	/* 86-90 */
@@ -47,6 +49,7 @@ static unsigned long sclp_hsa_size;
 static unsigned int sclp_max_cpu;
 static struct sclp_ipl_info sclp_ipl_info;
 static unsigned char sclp_siif;
+static u32 sclp_ibc;
 
 u64 sclp_facilities;
 u8 sclp_fac84;
@@ -111,6 +114,7 @@ static void __init sclp_facilities_detect(struct read_info_sccb *sccb)
 	sclp_rnmax = sccb->rnmax ? sccb->rnmax : sccb->rnmax2;
 	sclp_rzm = sccb->rnsize ? sccb->rnsize : sccb->rnsize2;
 	sclp_rzm <<= 20;
+	sclp_ibc = sccb->ibc;
 
 	if (!sccb->hcpua) {
 		if (MACHINE_IS_VM)
@@ -168,6 +172,12 @@ int sclp_has_siif(void)
 }
 EXPORT_SYMBOL(sclp_has_siif);
 
+unsigned int sclp_get_ibc(void)
+{
+	return sclp_ibc;
+}
+EXPORT_SYMBOL(sclp_get_ibc);
+
 /*
  * This function will be called after sclp_facilities_detect(), which gets
  * called from early.c code. The sclp_facilities_detect() function retrieves
-- 
1.8.3.1
