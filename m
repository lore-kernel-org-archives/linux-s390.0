From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 11/11] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Date: Fri, 19 Apr 2019 18:47:54 +0900
Message-ID: <20190419094754.24667-12-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.

The idea is obviously arch-agnostic. This commit moves the config
entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
architectures can benefit from it.

This can make a huge difference in kernel image size especially when
CONFIG_OPTIMIZE_FOR_SIZE is enabled.

For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.

  dec       file
  18983424  arch/arm64/boot/Image.before
  18321920  arch/arm64/boot/Image.after

This also slightly improves the "Kernel hacking" Kconfig menu as
e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
this config option would be a good fit in the "compiler option" menu.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - split into a separate patch

 arch/x86/Kconfig               |  3 ---
 arch/x86/Kconfig.debug         | 14 --------------
 include/linux/compiler_types.h |  3 +--
 lib/Kconfig.debug              | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..9e93d109a6cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -310,9 +310,6 @@ config ZONE_DMA32
 config AUDIT_ARCH
 	def_bool y if X86_64
 
-config ARCH_SUPPORTS_OPTIMIZED_INLINING
-	def_bool y
-
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..f730680dc818 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -266,20 +266,6 @@ config CPA_DEBUG
 	---help---
 	  Do change_page_attr() self-tests every 30 seconds.
 
-config OPTIMIZE_INLINING
-	bool "Allow gcc to uninline functions marked 'inline'"
-	---help---
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
-	  If unsure, say N.
-
 config DEBUG_ENTRY
 	bool "Debug low-level entry code"
 	depends on DEBUG_KERNEL
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ba814f18cb4c..19e58b9138a0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -140,8 +140,7 @@ struct ftrace_likely_data {
  * Do not use __always_inline here, since currently it expands to inline again
  * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-	!defined(CONFIG_OPTIMIZE_INLINING)
+#if !defined(CONFIG_OPTIMIZE_INLINING)
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
 	__maybe_unused notrace
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..f8f284f46c85 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -310,6 +310,20 @@ config HEADERS_CHECK
 	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
 	  your build tree), to make sure they're suitable.
 
+config OPTIMIZE_INLINING
+	bool "Allow compiler to uninline functions marked 'inline'"
+	help
+	  This option determines if the kernel forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable for the gcc 3.x series of
+	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
+	  enabling this option will generate a smaller kernel there. Hopefully
+	  this algorithm is so good that allowing gcc 4.x and above to make the
+	  decision will become the default in the future. Until then this option
+	  is there to test gcc for this.
+
+	  If unsure, say N.
+
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1
