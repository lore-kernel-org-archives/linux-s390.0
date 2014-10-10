From: Alexey Ishchuk <aishchuk@linux.vnet.ibm.com>
Date: Fri, 10 Oct 2014 09:40:24 +0000
Subject: [PATCH 2/3] libibverbs: add support for the s390x platform
Message-Id: <1412934025-56018-3-git-send-email-aishchuk@linux.vnet.ibm.com>
In-Reply-To: <1412933657-52641-3-git-send-email-aishchuk@linux.vnet.ibm.com>
References: <1412933657-52641-3-git-send-email-aishchuk@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This patch adds the required platform specific code to allow execution of
the libibverbs functions on the s390x platform.

Signed-off-by: Alexey Ishchuk <aishchuk@linux.vnet.ibm.com>
---
 include/infiniband/arch.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/infiniband/arch.h
+++ b/include/infiniband/arch.h
@@ -115,6 +115,13 @@ static inline uint64_t ntohll(uint64_t x
 #define wmb()	 mb()
 #define wc_wmb() wmb()
 
+#elif defined(__s390x__)
+
+#define mb()	{ asm volatile("" : : : "memory"); }	/* for s390x */
+#define rmb()	mb()					/* for s390x */
+#define wmb()	mb()					/* for s390x */
+#define wc_wmb() wmb()					/* for s390x */
+
 #else
 
 #warning No architecture specific defines found.  Using generic implementation.
