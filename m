From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 10/11] powerpc/mm/radix: mark as __tlbie_pid() and friends
 as__always_inline
Date: Fri, 19 Apr 2019 18:47:53 +0900
Message-ID: <20190419094754.24667-11-yamada.masahiro@socionext.com>
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

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for powerpc, the following errors are reported:

arch/powerpc/mm/tlb-radix.c: In function '__tlbie_lpid':
arch/powerpc/mm/tlb-radix.c:148:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
arch/powerpc/mm/tlb-radix.c: In function '__tlbie_pid':
arch/powerpc/mm/tlb-radix.c:118:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
  ^~~
arch/powerpc/mm/tlb-radix.c: In function '__tlbiel_pid':
arch/powerpc/mm/tlb-radix.c:104:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
  ^~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - new patch

 arch/powerpc/mm/tlb-radix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index a2b2848f0ae3..14ff414d1545 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -90,8 +90,8 @@ void radix__tlbiel_all(unsigned int action)
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
-static inline void __tlbiel_pid(unsigned long pid, int set,
-				unsigned long ric)
+static __always_inline void __tlbiel_pid(unsigned long pid, int set,
+					 unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -106,7 +106,7 @@ static inline void __tlbiel_pid(unsigned long pid, int set,
 	trace_tlbie(0, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_pid(unsigned long pid, unsigned long ric)
+static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -136,7 +136,7 @@ static inline void __tlbiel_lpid(unsigned long lpid, int set,
 	trace_tlbie(lpid, 1, rb, rs, ric, prs, r);
 }
 
-static inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
+static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
 
@@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
 	int set;
 
-- 
2.17.1
