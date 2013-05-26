From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] arch: configuration issue, random return value when disable
 'CONFIG_BUG'
Date: Sun, 26 May 2013 12:43:22 +0800
Message-ID: <51A192EA.4010607@asianux.com>
References: <519DCBEF.3090208@asianux.com> <201305231259.43750.arnd@arndb.de>
 <20130523112401.GO18614@n2100.arm.linux.org.uk>
 <201305231409.02359.arnd@arndb.de>
 <20130523125033.GP18614@n2100.arm.linux.org.uk>
 <CAMuHMdUzcBuDupe4Fa6XieziGPMpPKC_k8X8gUUmDvLJ+Fe=Hg@mail.gmail.com>
 <519ECCCF.8090909@asianux.com> <519EE9D6.9010707@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <519EE9D6.9010707@asianux.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, =?UTF-8?B?SMOldmFyZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>, Serge Hallyn <serge.hallyn@canonical.com>, Mike Frysinger <vapier@gentoo.org>uml-devel <use>
List-ID: <linux-s390.vger.kernel.org>


If user disable 'CONFIG_BUG' in menuconfig, many areas not only will
report compiling warnings, but also may return a random value from the
function when BUG().

In fact, most of architectures need always let 'CONFIG_BUG' enabled, so
'#ifdef CONFIG_BUG' is already not 'generic' enough in "include/asm-
generic/".

Also kernel has already provided the 'generic' implementation in
"include/asm-generic" when 'CONFIG_BUG' enabled. Even if we disable
'CONFIG_BUG', we also shall have to implement the BUG() in "include/asm-
generic", just like when 'CONFIG_BUG' enabled (at least, it is not the
minimal size implementation).

So need remove 'CONFIG_BUG', and let it always enabled everywhere, then
fix this issue.

The architectures which need their own architecture specific features
(e.g. minimal size implementation), can customize their own BUG() and
__WARN_TAINT() to give a better fix (e.g. use one inline asm code, then
followed by 'unreachable' function, or another more better fix ways).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/Kconfig          |    1 -
 arch/avr32/Kconfig        |    1 -
 arch/blackfin/Kconfig     |    1 -
 arch/h8300/Kconfig        |    1 -
 arch/hexagon/Kconfig      |    1 -
 arch/parisc/Kconfig       |    2 --
 arch/powerpc/Kconfig      |    1 -
 arch/s390/Kconfig         |    2 +-
 arch/sh/Kconfig           |    2 +-
 arch/um/Kconfig.common    |    1 -
 arch/x86/Kconfig          |    1 -
 include/asm-generic/bug.h |   29 -----------------------------
 init/Kconfig              |   10 ----------
 lib/Kconfig.debug         |    2 +-
 14 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7fc5ea..ea4a146 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -265,7 +265,6 @@ config PHYS_OFFSET
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG
 
 source "init/Kconfig"
 
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index bdc3558..7c9005a 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -55,7 +55,6 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG
 
 source "init/Kconfig"
 
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index a117652..637dc42 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -47,7 +47,6 @@ config GENERIC_CSUM
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG
 
 config ZONE_DMA
 	def_bool y
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 303e4f9..88848da 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -56,7 +56,6 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_BUG
         bool
-        depends on BUG
 
 config TIME_LOW_RES
 	bool
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 33a9792..f50cc8f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -84,7 +84,6 @@ config STACKTRACE_SUPPORT
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG
 
 menu "Machine selection"
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 6507dab..5de1f8c 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -10,7 +10,6 @@ config PARISC
 	select RTC_CLASS
 	select RTC_DRV_GENERIC
 	select INIT_ALL_POSSIBLE
-	select BUG
 	select HAVE_PERF_EVENTS
 	select GENERIC_ATOMIC64 if !64BIT
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
@@ -62,7 +61,6 @@ config ARCH_HAS_ILOG2_U64
 config GENERIC_BUG
 	bool
 	default y
-	depends on BUG
 
 config GENERIC_HWEIGHT
 	bool
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c33e3ad..34f4ca9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -187,7 +187,6 @@ config AUDIT_ARCH
 config GENERIC_BUG
 	bool
 	default y
-	depends on BUG
 
 config SYS_SUPPORTS_APM_EMULATION
 	default y if PMAC_APM_EMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index da183c5..5d7b3db 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -29,7 +29,7 @@ config GENERIC_HWEIGHT
 	def_bool y
 
 config GENERIC_BUG
-	def_bool y if BUG
+	def_bool y
 
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8c868cf..d555e7f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -84,7 +84,7 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG && SUPERH32
+	depends on SUPERH32
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index bceee66..7aae42a 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -53,7 +53,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_BUG
 	bool
 	default y
-	depends on BUG
 
 config HZ
 	int
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 723e42e..a36e1b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -166,7 +166,6 @@ config GENERIC_ISA_DMA
 
 config GENERIC_BUG
 	def_bool y
-	depends on BUG
 	select GENERIC_BUG_RELATIVE_POINTERS if X86_64
 
 config GENERIC_BUG_RELATIVE_POINTERS
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..5d50903 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -12,8 +12,6 @@
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 
-#ifdef CONFIG_BUG
-
 #ifdef CONFIG_GENERIC_BUG
 struct bug_entry {
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
@@ -106,33 +104,6 @@ extern void warn_slowpath_null(const char *file, const int line);
 	unlikely(__ret_warn_on);					\
 })
 
-#else /* !CONFIG_BUG */
-#ifndef HAVE_ARCH_BUG
-#define BUG() do {} while(0)
-#endif
-
-#ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
-#endif
-
-#ifndef HAVE_ARCH_WARN_ON
-#define WARN_ON(condition) ({						\
-	int __ret_warn_on = !!(condition);				\
-	unlikely(__ret_warn_on);					\
-})
-#endif
-
-#ifndef WARN
-#define WARN(condition, format...) ({					\
-	int __ret_warn_on = !!(condition);				\
-	unlikely(__ret_warn_on);					\
-})
-#endif
-
-#define WARN_TAINT(condition, taint, format...) WARN_ON(condition)
-
-#endif
-
 #define WARN_ON_ONCE(condition)	({				\
 	static bool __section(.data.unlikely) __warned;		\
 	int __ret_warn_once = !!(condition);			\
diff --git a/init/Kconfig b/init/Kconfig
index 7fb26a6..bc1dd49 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1360,16 +1360,6 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
-config BUG
-	bool "BUG() support" if EXPERT
-	default y
-	help
-          Disabling this option eliminates support for BUG and WARN, reducing
-          the size of your kernel image and potentially quietly ignoring
-          numerous fatal conditions. You should only consider disabling this
-          option for embedded systems with no facilities for reporting errors.
-          Just say Y.
-
 config ELF_CORE
 	depends on COREDUMP
 	default y
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 566cf2b..54b3251 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -700,7 +700,7 @@ config HAVE_DEBUG_BUGVERBOSE
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
-	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
+	depends on GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE
 	default y
 	help
 	  Say Y here to make BUG() panics output the file name and line number
-- 
1.7.7.6
