Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbgDPWBd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 06/11] s390: Add clear_bit_unlock_is_negative_byte implementation
Date: Thu, 16 Apr 2020 15:01:25 -0700
Message-Id: <20200416220130.13343-7-willy@infradead.org>
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This is the generic implementation.  I can't figure out an optimised
implementation for s390.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/bitops.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 431e208a5ea4..d313ca6affaf 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -241,6 +241,15 @@ static inline void arch___clear_bit_unlock(unsigned long nr,
 	arch___clear_bit(nr, ptr);
 }
 
+static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
+						volatile unsigned long *p)
+{
+	arch_clear_bit_unlock(nr, p);
+	return arch_test_bit(7, p);
+}
+#define arch_clear_bit_unlock_is_negative_byte \
+	arch_clear_bit_unlock_is_negative_byte
+
 #include <asm-generic/bitops/instrumented-atomic.h>
 #include <asm-generic/bitops/instrumented-non-atomic.h>
 #include <asm-generic/bitops/instrumented-lock.h>
-- 
2.25.1
