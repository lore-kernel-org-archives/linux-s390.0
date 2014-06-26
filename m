From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/1] KVM: s390: add sie.h uapi header file to Kbuild and remove header dependency
Date: Thu, 26 Jun 2014 11:09:33 +0200
Message-ID: <1403773773-11279-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1403773773-11279-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1403773773-11279-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

sie.h was missing in arch/s390/include/uapi/asm/Kbuild and therefore missed
the "make headers_check" target.
If added it reveals that also arch/s390/include/asm/sigp.h would become uapi.
This is something we certainly do not want. So remove that dependency as well.

The header file was merged with ceae283bb2e0176c "KVM: s390: add sie exit
reasons tables", therefore we never had a kernel release with this commit and
can still change anything.

Acked-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/uapi/asm/Kbuild |    1 +
 arch/s390/include/uapi/asm/sie.h  |   26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 6a9a9eb..7366373 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -36,6 +36,7 @@ header-y += signal.h
 header-y += socket.h
 header-y += sockios.h
 header-y += sclp_ctl.h
+header-y += sie.h
 header-y += stat.h
 header-y += statfs.h
 header-y += swab.h
diff --git a/arch/s390/include/uapi/asm/sie.h b/arch/s390/include/uapi/asm/sie.h
index 3d97f61..5d9cc19 100644
--- a/arch/s390/include/uapi/asm/sie.h
+++ b/arch/s390/include/uapi/asm/sie.h
@@ -1,8 +1,6 @@
 #ifndef _UAPI_ASM_S390_SIE_H
 #define _UAPI_ASM_S390_SIE_H
 
-#include <asm/sigp.h>
-
 #define diagnose_codes						\
 	{ 0x10, "DIAG (0x10) release pages" },			\
 	{ 0x44, "DIAG (0x44) time slice end" },			\
@@ -13,18 +11,18 @@
 	{ 0x500, "DIAG (0x500) KVM virtio functions" },		\
 	{ 0x501, "DIAG (0x501) KVM breakpoint" }
 
-#define sigp_order_codes						\
-	{ SIGP_SENSE, "SIGP sense" },					\
-	{ SIGP_EXTERNAL_CALL, "SIGP external call" },			\
-	{ SIGP_EMERGENCY_SIGNAL, "SIGP emergency signal" },		\
-	{ SIGP_STOP, "SIGP stop" },					\
-	{ SIGP_STOP_AND_STORE_STATUS, "SIGP stop and store status" },	\
-	{ SIGP_SET_ARCHITECTURE, "SIGP set architecture" },		\
-	{ SIGP_SET_PREFIX, "SIGP set prefix" },				\
-	{ SIGP_SENSE_RUNNING, "SIGP sense running" },			\
-	{ SIGP_RESTART, "SIGP restart" },				\
-	{ SIGP_INITIAL_CPU_RESET, "SIGP initial cpu reset" },		\
-	{ SIGP_STORE_STATUS_AT_ADDRESS, "SIGP store status at address" }
+#define sigp_order_codes					\
+	{ 0x01, "SIGP sense" },					\
+	{ 0x02, "SIGP external call" },				\
+	{ 0x03, "SIGP emergency signal" },			\
+	{ 0x05, "SIGP stop" },					\
+	{ 0x06, "SIGP restart" },				\
+	{ 0x09, "SIGP stop and store status" },			\
+	{ 0x0b, "SIGP initial cpu reset" },			\
+	{ 0x0d, "SIGP set prefix" },				\
+	{ 0x0e, "SIGP store status at address" },		\
+	{ 0x12, "SIGP set architecture" },			\
+	{ 0x15, "SIGP sense running" }
 
 #define icpt_prog_codes						\
 	{ 0x0001, "Prog Operation" },				\
-- 
1.7.9.5
