Return-Path: <schwidefsky@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/6] s390: add optimized array_index_mask_nospec
Date: Wed,  7 Feb 2018 08:00:07 +0100
In-Reply-To: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
Message-Id: <1517986811-27819-3-git-send-email-schwidefsky@de.ibm.com>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Add an optimized version of the array_index_mask_nospec function for
s390 based on a compare and a subtract with borrow.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/barrier.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index 1043260..f9eddbc 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -49,6 +49,30 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/**
+ * array_index_mask_nospec - generate a mask for array_idx() that is
+ * ~0UL when the bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	if (__builtin_constant_p(size) && size > 0) {
+		asm("	clgr	%2,%1\n"
+		    "	slbgr	%0,%0\n"
+		    :"=d" (mask) : "d" (size-1), "d" (index) :"cc");
+		return mask;
+	}
+	asm("	clgr	%1,%2\n"
+	    "	slbgr	%0,%0\n"
+	    :"=d" (mask) : "d" (size), "d" (index) :"cc");
+	return ~mask;
+}
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
2.7.4
