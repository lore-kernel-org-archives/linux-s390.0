Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732365AbgGaJq2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 05:46:28 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 05/11] s390x: clock and delays calculations
Date: Fri, 31 Jul 2020 11:46:01 +0200
Message-Id: <20200731094607.15204-6-frankja@linux.ibm.com>
In-Reply-To: <20200731094607.15204-1-frankja@linux.ibm.com>
References: <20200731094607.15204-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

From: Pierre Morel <pmorel@linux.ibm.com>

The hardware gives us a good definition of the microsecond,
let's keep this information and let the routine accessing
the hardware keep all the information and return microseconds.

Calculate delays in microseconds and take care about wrapping
around zero.

Define values with macros and use inlines to keep the
milliseconds interface.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-Id: <1594887809-10521-5-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/time.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
index 1791380..7375aa2 100644
--- a/lib/s390x/asm/time.h
+++ b/lib/s390x/asm/time.h
@@ -13,14 +13,38 @@
 #ifndef ASM_S390X_TIME_H
 #define ASM_S390X_TIME_H
 
-static inline uint64_t get_clock_ms(void)
+#define STCK_SHIFT_US	(63 - 51)
+#define STCK_MAX	((1UL << 52) - 1)
+
+static inline uint64_t get_clock_us(void)
 {
 	uint64_t clk;
 
 	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
 
-	/* Bit 51 is incrememented each microsecond */
-	return (clk >> (63 - 51)) / 1000;
+	return clk >> STCK_SHIFT_US;
+}
+
+static inline uint64_t get_clock_ms(void)
+{
+	return get_clock_us() / 1000;
+}
+
+static inline void udelay(unsigned long us)
+{
+	unsigned long startclk = get_clock_us();
+	unsigned long c;
+
+	do {
+		c = get_clock_us();
+		if (c < startclk)
+			c += STCK_MAX;
+	} while (c < startclk + us);
+}
+
+static inline void mdelay(unsigned long ms)
+{
+	udelay(ms * 1000);
 }
 
 #endif
-- 
2.25.4
