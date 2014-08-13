From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 3/8] sparc: Remove unnecessary volatile usage
Date: Wed, 13 Aug 2014 12:28:53 +0200
Message-ID: <1407925738-26170-4-git-send-email-thierry.reding@gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The volatile keyword is only necessary in accessors that immediately
perform memory accesses. Wrappers around such accessors, such as the
_memset_io() and _memcpy_{to,from}io() functions don't need them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- new patch

 arch/sparc/include/asm/io_32.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 9f532902627c..49267f2575d7 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -16,18 +16,15 @@
 
 #include <asm-generic/io.h>
 
-static inline void _memset_io(volatile void __iomem *dst,
-                              int c, __kernel_size_t n)
+static inline void _memset_io(void __iomem *dst, int c, __kernel_size_t n)
 {
-	volatile void __iomem *d = dst;
-
 	while (n--) {
-		writeb(c, d);
-		d++;
+		writeb(c, dst);
+		dst++;
 	}
 }
 
-static inline void _memcpy_fromio(void *dst, const volatile void __iomem *src,
+static inline void _memcpy_fromio(void *dst, const void __iomem *src,
                                   __kernel_size_t n)
 {
 	char *d = dst;
@@ -39,16 +36,15 @@ static inline void _memcpy_fromio(void *dst, const volatile void __iomem *src,
 	}
 }
 
-static inline void _memcpy_toio(volatile void __iomem *dst, const void *src,
+static inline void _memcpy_toio(void __iomem *dst, const void *src,
                                 __kernel_size_t n)
 {
 	const char *s = src;
-	volatile void __iomem *d = dst;
 
 	while (n--) {
 		char tmp = *s++;
-		writeb(tmp, d);
-		d++;
+		writeb(tmp, dst);
+		dst++;
 	}
 }
 
-- 
2.0.4
