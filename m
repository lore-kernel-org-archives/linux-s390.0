From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/52] s390: Make diag224 public
Date: Tue, 14 Jun 2016 20:56:40 +0200
Message-ID: <1465930649-181383-4-git-send-email-borntraeger@de.ibm.com>
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

Diag204's cpu structures only contain the cpu type by means of an
index in the diag224 name table. Hence, to be able to use diag204 in
any meaningful way, we also need a usable diag224 interface.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c | 14 --------------
 arch/s390/include/asm/diag.h |  1 +
 arch/s390/kernel/diag.c      | 15 +++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 1e28414..28f03ca 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -360,20 +360,6 @@ out:
 
 /* Diagnose 224 functions */
 
-static int diag224(void *ptr)
-{
-	int rc = -EOPNOTSUPP;
-
-	diag_stat_inc(DIAG_STAT_X224);
-	asm volatile(
-		"	diag	%1,%2,0x224\n"
-		"0:	lhi	%0,0x0\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (rc) :"d" (0), "d" (ptr) : "memory");
-	return rc;
-}
-
 static int diag224_get_name_table(void)
 {
 	/* memory must be below 2GB */
diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index f72744f..197e303 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -205,4 +205,5 @@ struct diag204_x_phys_cpu {
 } __packed;
 
 int diag204(unsigned long subcode, unsigned long size, void *addr);
+int diag224(void *ptr);
 #endif /* _ASM_S390_DIAG_H */
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index f4ce4a2..a44faf4 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -218,3 +218,18 @@ int diag210(struct diag210 *addr)
 	return ccode;
 }
 EXPORT_SYMBOL(diag210);
+
+int diag224(void *ptr)
+{
+	int rc = -EOPNOTSUPP;
+
+	diag_stat_inc(DIAG_STAT_X224);
+	asm volatile(
+		"	diag	%1,%2,0x224\n"
+		"0:	lhi	%0,0x0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "+d" (rc) :"d" (0), "d" (ptr) : "memory");
+	return rc;
+}
+EXPORT_SYMBOL(diag224);
-- 
2.5.5
