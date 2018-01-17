From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/6] s390: implement nospec_[load|ptr]
Date: Wed, 17 Jan 2018 10:48:35 +0100
Message-ID: <1516182519-10623-3-git-send-email-schwidefsky@de.ibm.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Implement nospec_load() and nospec_ptr() for s390 with the new
gmb() barrier between the boundary condition and the load that
may not be done speculatively.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/barrier.h | 38 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/alternative.c  |  7 +++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index 1043260..b8836a6 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_BARRIER_H
 #define __ASM_BARRIER_H
 
+#include <asm/alternative.h>
+
 /*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
@@ -23,6 +25,42 @@
 
 #define mb() do {  asm volatile(__ASM_BARRIER : : : "memory"); } while (0)
 
+static inline void gmb(void)
+{
+	asm volatile(
+		ALTERNATIVE("", ".long 0xb2e8f000", 81)
+		: : : "memory");
+}
+#define gmb gmb
+
+#define nospec_ptr(ptr, lo, hi)					\
+({								\
+	typeof (ptr) __ptr = (ptr);				\
+	typeof (ptr) __lo = (lo);				\
+	typeof (ptr) __hi = (hi);				\
+	typeof (ptr) __vptr = NULL;				\
+								\
+	if (__lo <= __ptr && __ptr < __hi) {			\
+		gmb();						\
+		__vptr = __ptr;					\
+	}							\
+	__vptr;							\
+})
+
+#define nospec_load(ptr, lo, hi)				\
+({								\
+	typeof (ptr) __ptr = (ptr);				\
+	typeof (ptr) __lo = (lo);				\
+	typeof (ptr) __hi = (hi);				\
+	typeof (*ptr) __v = (typeof(*__ptr))(unsigned long) 0;	\
+								\
+	if (__lo <= __ptr && __ptr < __hi) {			\
+		gmb();						\
+		__v = *__ptr;					\
+	}							\
+	__v;							\
+})
+
 #define rmb()				barrier()
 #define wmb()				barrier()
 #define dma_rmb()			mb()
diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 1abf4f3..33d2e88 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -15,6 +15,13 @@ static int __init disable_alternative_instructions(char *str)
 
 early_param("noaltinstr", disable_alternative_instructions);
 
+static int __init nogmb_setup_early(char *str)
+{
+	__clear_facility(81, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nogmb", nogmb_setup_early);
+
 struct brcl_insn {
 	u16 opc;
 	s32 disp;
-- 
2.7.4
