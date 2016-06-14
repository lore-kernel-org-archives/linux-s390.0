From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/52] s390: Make cpc_name accessible
Date: Tue, 14 Jun 2016 20:56:39 +0200
Message-ID: <1465930649-181383-3-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

sclp_ocf.c is the only way to get the cpc name, as it registers the
sole event handler for the ocf event. By creating a new global
function that copies that name, we make it accessible to the world
which longs to retrieve it.

Additionally we now also store the cpc name as EBCDIC, so we don't
have to convert it to and from ASCII if it is requested in native
encoding.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/sclp.h |  1 +
 drivers/s390/char/sclp_ocf.c | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index e4f6f73..49736a0 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -101,5 +101,6 @@ int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count);
 int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count);
 void sclp_early_detect(void);
 void _sclp_print_early(const char *);
+void sclp_ocf_cpc_name_copy(char *dst);
 
 #endif /* _ASM_S390_SCLP_H */
diff --git a/drivers/s390/char/sclp_ocf.c b/drivers/s390/char/sclp_ocf.c
index 2553db0..f59b717 100644
--- a/drivers/s390/char/sclp_ocf.c
+++ b/drivers/s390/char/sclp_ocf.c
@@ -26,7 +26,7 @@
 #define OCF_LENGTH_CPC_NAME 8UL
 
 static char hmc_network[OCF_LENGTH_HMC_NETWORK + 1];
-static char cpc_name[OCF_LENGTH_CPC_NAME + 1];
+static char cpc_name[OCF_LENGTH_CPC_NAME]; /* in EBCDIC */
 
 static DEFINE_SPINLOCK(sclp_ocf_lock);
 static struct work_struct sclp_ocf_change_work;
@@ -72,9 +72,8 @@ static void sclp_ocf_handler(struct evbuf_header *evbuf)
 	}
 	if (cpc) {
 		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length);
+		memset(cpc_name, 0, OCF_LENGTH_CPC_NAME);
 		memcpy(cpc_name, cpc + 1, size);
-		EBCASC(cpc_name, size);
-		cpc_name[size] = 0;
 	}
 	spin_unlock(&sclp_ocf_lock);
 	schedule_work(&sclp_ocf_change_work);
@@ -85,15 +84,23 @@ static struct sclp_register sclp_ocf_event = {
 	.receiver_fn = sclp_ocf_handler,
 };
 
+void sclp_ocf_cpc_name_copy(char *dst)
+{
+	spin_lock_irq(&sclp_ocf_lock);
+	memcpy(dst, cpc_name, OCF_LENGTH_CPC_NAME);
+	spin_unlock_irq(&sclp_ocf_lock);
+}
+EXPORT_SYMBOL(sclp_ocf_cpc_name_copy);
+
 static ssize_t cpc_name_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *page)
 {
-	int rc;
+	char name[OCF_LENGTH_CPC_NAME + 1];
 
-	spin_lock_irq(&sclp_ocf_lock);
-	rc = snprintf(page, PAGE_SIZE, "%s\n", cpc_name);
-	spin_unlock_irq(&sclp_ocf_lock);
-	return rc;
+	sclp_ocf_cpc_name_copy(name);
+	name[OCF_LENGTH_CPC_NAME] = 0;
+	EBCASC(name, OCF_LENGTH_CPC_NAME);
+	return snprintf(page, PAGE_SIZE, "%s\n", name);
 }
 
 static struct kobj_attribute cpc_name_attr =
-- 
2.5.5
