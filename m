Return-Path: <linux-arch-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 01/10] arm64: mark (__)cpus_have_const_cap as __always_inline
Date: Tue, 23 Apr 2019 12:20:57 +0900
Message-ID: <20190423032106.11960-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190423032057.NGALSYo9VrVbxx29uTpeGcHMjnlM0mBqNpZc3SaVvHU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for arm64, the following errors are reported:

In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:
./arch/arm64/include/asm/jump_label.h: In function 'cpus_have_const_cap':
./include/linux/compiler-gcc.h:120:38: warning: asm operand 0 probably doesn't match constraints
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto(
  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:120:38: error: impossible constraint in 'asm'
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto(
  ^~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/arm64/include/asm/cpufeature.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e505e1fbd2b9..77d1aa57323e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -406,7 +406,7 @@ static inline bool cpu_have_feature(unsigned int num)
 }
 
 /* System capability check for constant caps */
-static inline bool __cpus_have_const_cap(int num)
+static __always_inline bool __cpus_have_const_cap(int num)
 {
 	if (num >= ARM64_NCAPS)
 		return false;
@@ -420,7 +420,7 @@ static inline bool cpus_have_cap(unsigned int num)
 	return test_bit(num, cpu_hwcaps);
 }
 
-static inline bool cpus_have_const_cap(int num)
+static __always_inline bool cpus_have_const_cap(int num)
 {
 	if (static_branch_likely(&arm64_const_caps_ready))
 		return __cpus_have_const_cap(num);
-- 
2.17.1
