Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728283AbgERQHl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 May 2020 12:07:41 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v7 06/12] s390x: use get_clock_ms() to calculate a delay in ms
Date: Mon, 18 May 2020 18:07:25 +0200
Message-Id: <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

use get_clock_ms() to calculate a delay in ms

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/asm/time.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
index 25c7a3c..931a119 100644
--- a/lib/s390x/asm/time.h
+++ b/lib/s390x/asm/time.h
@@ -23,4 +23,14 @@ static inline uint64_t get_clock_ms(void)
 	return (clk >> (63 - 51)) / 1000;
 }
 
+static inline void mdelay(unsigned long ms)
+{
+	unsigned long startclk;
+
+	startclk = get_clock_ms();
+	for (;;)
+		if (get_clock_ms() - startclk > ms)
+			break;
+}
+
 #endif
-- 
2.25.1
