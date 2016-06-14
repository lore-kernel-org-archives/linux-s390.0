From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/52] KVM: s390: Extend diag 204 fields
Date: Tue, 14 Jun 2016 20:56:42 +0200
Message-ID: <1465930649-181383-6-git-send-email-borntraeger@de.ibm.com>
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

The new store hypervisor information instruction, which we are going
to introduce, needs previously unused fields in diag 204 structures.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/diag.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 197e303..f4000cd 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -97,6 +97,11 @@ enum diag204_format {
 	DIAG204_INFO_EXT = 0x00010000
 };
 
+enum diag204_cpu_flags {
+	DIAG204_CPU_ONLINE = 0x20,
+	DIAG204_CPU_CAPPED = 0x40,
+};
+
 struct diag204_info_blk_hdr {
 	__u8  npar;
 	__u8  flags;
@@ -136,10 +141,13 @@ struct diag204_x_part_hdr {
 	__u64 online_cs;
 	__u64 online_es;
 	__u8  upid;
-	char  reserved1[3];
+	__u8  reserved:3;
+	__u8  mtid:5;
+	char  reserved1[2];
 	__u32 group_mlu;
 	char  group_name[8];
-	char  reserved2[32];
+	char  hardware_group_name[8];
+	char  reserved2[24];
 } __packed;
 
 struct diag204_cpu_info {
@@ -168,7 +176,9 @@ struct diag204_x_cpu_info {
 	__u64 wait_time;
 	__u32 pma_weight;
 	__u32 polar_weight;
-	char  reserved3[40];
+	__u32 cpu_type_cap;
+	__u32 group_cpu_type_cap;
+	char  reserved3[32];
 } __packed;
 
 struct diag204_phys_hdr {
@@ -199,7 +209,8 @@ struct diag204_x_phys_cpu {
 	__u16 cpu_addr;
 	char  reserved1[2];
 	__u8  ctidx;
-	char  reserved2[3];
+	char  reserved2[1];
+	__u16 weight;
 	__u64 mgm_time;
 	char  reserved3[80];
 } __packed;
-- 
2.5.5
