From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/47] s390/ptrace: add struct psw and accessor function
Date: Tue, 15 Apr 2014 14:00:10 +0200
Message-ID: <1397563250-3089-8-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce a 'struct psw' which makes it easier to decode and test if
certain bits in a psw are set or are not set.
In addition also add a 'psw_bits()' helper define which allows to
directly modify and test a psw_t structure. E.g.

psw_t psw;
psw_bits(psw).t = 1; /* set dat bit */

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/ptrace.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index f4783c0..6e7708f 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -16,6 +16,50 @@
 			 PSW_DEFAULT_KEY | PSW_MASK_BASE | PSW_MASK_MCHECK | \
 			 PSW_MASK_PSTATE | PSW_ASC_PRIMARY)
 
+struct psw_bits {
+	unsigned long long	: 1;
+	unsigned long long r	: 1; /* PER-Mask */
+	unsigned long long	: 3;
+	unsigned long long t	: 1; /* DAT Mode */
+	unsigned long long i	: 1; /* Input/Output Mask */
+	unsigned long long e	: 1; /* External Mask */
+	unsigned long long key	: 4; /* PSW Key */
+	unsigned long long	: 1;
+	unsigned long long m	: 1; /* Machine-Check Mask */
+	unsigned long long w	: 1; /* Wait State */
+	unsigned long long p	: 1; /* Problem State */
+	unsigned long long as	: 2; /* Address Space Control */
+	unsigned long long cc	: 2; /* Condition Code */
+	unsigned long long pm	: 4; /* Program Mask */
+	unsigned long long ri	: 1; /* Runtime Instrumentation */
+	unsigned long long	: 6;
+	unsigned long long eaba : 2; /* Addressing Mode */
+#ifdef CONFIG_64BIT
+	unsigned long long	: 31;
+	unsigned long long ia	: 64;/* Instruction Address */
+#else
+	unsigned long long ia	: 31;/* Instruction Address */
+#endif
+};
+
+enum {
+	PSW_AMODE_24BIT = 0,
+	PSW_AMODE_31BIT = 1,
+	PSW_AMODE_64BIT = 3
+};
+
+enum {
+	PSW_AS_PRIMARY	 = 0,
+	PSW_AS_ACCREG	 = 1,
+	PSW_AS_SECONDARY = 2,
+	PSW_AS_HOME	 = 3
+};
+
+#define psw_bits(__psw) (*({			\
+	typecheck(psw_t, __psw);		\
+	&(*(struct psw_bits *)(&(__psw)));	\
+}))
+
 /*
  * The pt_regs struct defines the way the registers are stored on
  * the stack during a system call.
-- 
1.8.4.2
