From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 01/11] atomic: add *_dec_not_zero
Date: Wed, 27 Jul 2011 11:47:40 +0200
Message-ID: <1311760070-21532-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, linux-m32r@ml.l
List-ID: <linux-s390.vger.kernel.org>

Introduce an *_dec_not_zero operation.  Make this a special case of
*_add_unless because batman-adv uses atomic_dec_not_zero in different
places like re-broadcast queue or aggregation queue management. There
are other non-final patches which may also want to use this macro.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m32r@ml.linux-m32r.org
Cc: linux-m32r-ja@ml.linux-m32r.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
---
David S. Miller recommended this change in
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-May/004560.html

Arnd Bergmann wanted to apply it in 201106172320.26476.arnd@arndb.de

... and then Arun Sharma created a big merge conflict with
https://lkml.org/lkml/2011/6/6/430

I don't think that it is a a good idea to asume that everyone still agrees
with the patch after I've rewritten it.

 Documentation/atomic_ops.txt       |    1 +
 arch/alpha/include/asm/atomic.h    |    1 +
 arch/alpha/include/asm/local.h     |    1 +
 arch/arm/include/asm/atomic.h      |    1 +
 arch/ia64/include/asm/atomic.h     |    1 +
 arch/m32r/include/asm/local.h      |    1 +
 arch/mips/include/asm/atomic.h     |    1 +
 arch/mips/include/asm/local.h      |    1 +
 arch/parisc/include/asm/atomic.h   |    1 +
 arch/powerpc/include/asm/atomic.h  |    1 +
 arch/powerpc/include/asm/local.h   |    1 +
 arch/s390/include/asm/atomic.h     |    1 +
 arch/sparc/include/asm/atomic_64.h |    1 +
 arch/tile/include/asm/atomic_32.h  |    1 +
 arch/tile/include/asm/atomic_64.h  |    1 +
 arch/um/sys-i386/atomic64_cx8_32.S |   28 ++++++++++++++++++++++++++++
 arch/x86/include/asm/atomic64_32.h |   12 ++++++++++++
 arch/x86/include/asm/atomic64_64.h |    1 +
 arch/x86/include/asm/local.h       |    1 +
 arch/x86/lib/atomic64_32.c         |    4 ++++
 arch/x86/lib/atomic64_386_32.S     |   21 +++++++++++++++++++++
 arch/x86/lib/atomic64_cx8_32.S     |   28 ++++++++++++++++++++++++++++
 include/asm-generic/atomic-long.h  |    2 ++
 include/asm-generic/atomic64.h     |    1 +
 include/asm-generic/local.h        |    1 +
 include/asm-generic/local64.h      |    2 ++
 include/linux/atomic.h             |    9 +++++++++
 27 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
index 3bd585b..1eec221 100644
--- a/Documentation/atomic_ops.txt
+++ b/Documentation/atomic_ops.txt
@@ -190,6 +190,7 @@ atomic_add_unless requires explicit memory barriers around the operation
 unless it fails (returns 0).
 
 atomic_inc_not_zero, equivalent to atomic_add_unless(v, 1, 0)
+atomic_dec_not_zero, equivalent to atomic_add_unless(v, -1, 0)
 
 
 If a caller requires memory barrier semantics around an atomic_t
diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index 640f909..09d1571 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -225,6 +225,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 #define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
 #define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0)
diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/local.h
index 9c94b84..51eb678 100644
--- a/arch/alpha/include/asm/local.h
+++ b/arch/alpha/include/asm/local.h
@@ -79,6 +79,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 	c != (u);						\
 })
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
 
 #define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
 
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 86976d0..80ed975 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -458,6 +458,7 @@ static inline int atomic64_add_unless(atomic64_t *v, u64 a, u64 u)
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
+#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
 
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 3fad89e..af6e9b2 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -122,6 +122,7 @@ static __inline__ long atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 #define atomic_add_return(i,v)						\
 ({									\
diff --git a/arch/m32r/include/asm/local.h b/arch/m32r/include/asm/local.h
index 734bca8..d536082 100644
--- a/arch/m32r/include/asm/local.h
+++ b/arch/m32r/include/asm/local.h
@@ -272,6 +272,7 @@ static inline int local_add_unless(local_t *l, long a, long u)
 }
 
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
 
 static inline void local_clear_mask(unsigned long  mask, local_t *addr)
 {
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 1d93f81..babb043 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -697,6 +697,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 #define atomic64_dec_return(v) atomic64_sub_return(1, (v))
 #define atomic64_inc_return(v) atomic64_add_return(1, (v))
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index 94fde8d..0242256 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -137,6 +137,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 	c != (u);						\
 })
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
 
 #define local_dec_return(l) local_sub_return(1, (l))
 #define local_inc_return(l) local_add_return(1, (l))
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index b1dc71f..8a50234 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -334,6 +334,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 #endif /* !CONFIG_64BIT */
 
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index e2a4c26..c0131a6 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -468,6 +468,7 @@ static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da913..d182e34 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -134,6 +134,7 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 }
 
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
 
 #define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
 #define local_dec_and_test(l)		(local_dec_return((l)) == 0)
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index 8517d2a..92e7d5d 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -325,6 +325,7 @@ static inline long long atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
 #define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
 
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 9f421df..94cf160 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -106,6 +106,7 @@ static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
diff --git a/arch/tile/include/asm/atomic_32.h b/arch/tile/include/asm/atomic_32.h
index c03349e..9cfafb3 100644
--- a/arch/tile/include/asm/atomic_32.h
+++ b/arch/tile/include/asm/atomic_32.h
@@ -233,6 +233,7 @@ static inline void atomic64_set(atomic64_t *v, u64 n)
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1LL, 0LL)
+#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
 
 /*
  * We need to barrier before modifying the word, since the _atomic_xxx()
diff --git a/arch/tile/include/asm/atomic_64.h b/arch/tile/include/asm/atomic_64.h
index 27fe667..9c22f50 100644
--- a/arch/tile/include/asm/atomic_64.h
+++ b/arch/tile/include/asm/atomic_64.h
@@ -141,6 +141,7 @@ static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
 #define atomic64_add_negative(i, v)	(atomic64_add_return((i), (v)) < 0)
 
 #define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
 
 /* Atomic dec and inc don't implement barrier, so provide them if needed. */
 #define smp_mb__before_atomic_dec()	smp_mb()
diff --git a/arch/um/sys-i386/atomic64_cx8_32.S b/arch/um/sys-i386/atomic64_cx8_32.S
index 1e901d3..a58a1d4 100644
--- a/arch/um/sys-i386/atomic64_cx8_32.S
+++ b/arch/um/sys-i386/atomic64_cx8_32.S
@@ -223,3 +223,31 @@ ENTRY(atomic64_inc_not_zero_cx8)
 	jmp 3b
 	CFI_ENDPROC
 ENDPROC(atomic64_inc_not_zero_cx8)
+
+ENTRY(atomic64_dec_not_zero_cx8)
+	CFI_STARTPROC
+	SAVE ebx
+
+	read64 %esi
+1:
+	testl %eax, %eax
+	je 4f
+2:
+	movl %eax, %ebx
+	movl %edx, %ecx
+	subl $1, %ebx
+	sbbl $0, %ecx
+	LOCK_PREFIX
+	cmpxchg8b (%esi)
+	jne 1b
+
+	movl $1, %eax
+3:
+	RESTORE ebx
+	ret
+4:
+	testl %edx, %edx
+	jne 2b
+	jmp 3b
+	CFI_ENDPROC
+ENDPROC(atomic64_dec_not_zero_cx8)
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 24098aa..3cd4431 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -287,6 +287,18 @@ static inline int atomic64_inc_not_zero(atomic64_t *v)
 	return r;
 }
 
+
+static inline int atomic64_dec_not_zero(atomic64_t *v)
+{
+	int r;
+	asm volatile(ATOMIC64_ALTERNATIVE(dec_not_zero)
+		     : "=a" (r)
+		     : "S" (v)
+		     : "ecx", "edx", "memory"
+		     );
+	return r;
+}
+
 static inline long long atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long r;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 017594d..93c9d8b 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -220,6 +220,7 @@ static inline int atomic64_add_unless(atomic64_t *v, long a, long u)
 }
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
 
 /*
  * atomic64_dec_if_positive - decrement by 1 if old value positive
diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 9cdae5d..2c8c92d 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -185,6 +185,7 @@ static inline long local_sub_return(long i, local_t *l)
 	c != (u);						\
 })
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
 
 /* On x86_32, these are no better than the atomic variants.
  * On x86-64 these are better than the atomic variants on SMP kernels
diff --git a/arch/x86/lib/atomic64_32.c b/arch/x86/lib/atomic64_32.c
index 042f682..7da05c3 100644
--- a/arch/x86/lib/atomic64_32.c
+++ b/arch/x86/lib/atomic64_32.c
@@ -24,6 +24,8 @@ long long atomic64_dec_if_positive_cx8(atomic64_t *v);
 EXPORT_SYMBOL(atomic64_dec_if_positive_cx8);
 int atomic64_inc_not_zero_cx8(atomic64_t *v);
 EXPORT_SYMBOL(atomic64_inc_not_zero_cx8);
+int atomic64_dec_not_zero_cx8(atomic64_t *v);
+EXPORT_SYMBOL(atomic64_dec_not_zero_cx8);
 int atomic64_add_unless_cx8(atomic64_t *v, long long a, long long u);
 EXPORT_SYMBOL(atomic64_add_unless_cx8);
 
@@ -54,6 +56,8 @@ long long atomic64_dec_if_positive_386(atomic64_t *v);
 EXPORT_SYMBOL(atomic64_dec_if_positive_386);
 int atomic64_inc_not_zero_386(atomic64_t *v);
 EXPORT_SYMBOL(atomic64_inc_not_zero_386);
+int atomic64_dec_not_zero_386(atomic64_t *v);
+EXPORT_SYMBOL(atomic64_dec_not_zero_386);
 int atomic64_add_unless_386(atomic64_t *v, long long a, long long u);
 EXPORT_SYMBOL(atomic64_add_unless_386);
 #endif
diff --git a/arch/x86/lib/atomic64_386_32.S b/arch/x86/lib/atomic64_386_32.S
index e8e7e0d..c78337b 100644
--- a/arch/x86/lib/atomic64_386_32.S
+++ b/arch/x86/lib/atomic64_386_32.S
@@ -181,6 +181,27 @@ ENDP
 #undef v
 
 #define v %esi
+BEGIN(dec_not_zero)
+	movl  (v), %eax
+	movl 4(v), %edx
+	testl %eax, %eax
+	je 3f
+1:
+	subl $1, %eax
+	sbbl $0, %edx
+	movl %eax,  (v)
+	movl %edx, 4(v)
+	movl $1, %eax
+2:
+	RET
+3:
+	testl %edx, %edx
+	jne 1b
+	jmp 2b
+ENDP
+#undef v
+
+#define v %esi
 BEGIN(dec_if_positive)
 	movl  (v), %eax
 	movl 4(v), %edx
diff --git a/arch/x86/lib/atomic64_cx8_32.S b/arch/x86/lib/atomic64_cx8_32.S
index 391a083..989638c 100644
--- a/arch/x86/lib/atomic64_cx8_32.S
+++ b/arch/x86/lib/atomic64_cx8_32.S
@@ -220,3 +220,31 @@ ENTRY(atomic64_inc_not_zero_cx8)
 	jmp 3b
 	CFI_ENDPROC
 ENDPROC(atomic64_inc_not_zero_cx8)
+
+ENTRY(atomic64_dec_not_zero_cx8)
+	CFI_STARTPROC
+	SAVE ebx
+
+	read64 %esi
+1:
+	testl %eax, %eax
+	je 4f
+2:
+	movl %eax, %ebx
+	movl %edx, %ecx
+	subl $1, %ebx
+	sbbl $0, %ecx
+	LOCK_PREFIX
+	cmpxchg8b (%esi)
+	jne 1b
+
+	movl $1, %eax
+3:
+	RESTORE ebx
+	ret
+4:
+	testl %edx, %edx
+	jne 2b
+	jmp 3b
+	CFI_ENDPROC
+ENDPROC(atomic64_dec_not_zero_cx8)
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index b7babf0..0fe75ab 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -130,6 +130,7 @@ static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 }
 
 #define atomic_long_inc_not_zero(l) atomic64_inc_not_zero((atomic64_t *)(l))
+#define atomic_long_dec_not_zero(l) atomic64_dec_not_zero((atomic64_t *)(l))
 
 #define atomic_long_cmpxchg(l, old, new) \
 	(atomic64_cmpxchg((atomic64_t *)(l), (old), (new)))
@@ -247,6 +248,7 @@ static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 }
 
 #define atomic_long_inc_not_zero(l) atomic_inc_not_zero((atomic_t *)(l))
+#define atomic_long_dec_not_zero(l) atomic_dec_not_zero((atomic_t *)(l))
 
 #define atomic_long_cmpxchg(l, old, new) \
 	(atomic_cmpxchg((atomic_t *)(l), (old), (new)))
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index b18ce4f..90ff9b1 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -38,5 +38,6 @@ extern int	 atomic64_add_unless(atomic64_t *v, long long a, long long u);
 #define atomic64_dec_return(v)		atomic64_sub_return(1LL, (v))
 #define atomic64_dec_and_test(v)	(atomic64_dec_return((v)) == 0)
 #define atomic64_inc_not_zero(v) 	atomic64_add_unless((v), 1LL, 0LL)
+#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
index 9ceb03b..fabf4f3 100644
--- a/include/asm-generic/local.h
+++ b/include/asm-generic/local.h
@@ -44,6 +44,7 @@ typedef struct
 #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
 #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
 #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
+#define local_dec_not_zero(l) atomic_long_dec_not_zero(&(l)->a)
 
 /* Non-atomic variants, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well. */
diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
index 5980002..76acbe2 100644
--- a/include/asm-generic/local64.h
+++ b/include/asm-generic/local64.h
@@ -45,6 +45,7 @@ typedef struct {
 #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
+#define local64_dec_not_zero(l)	local_dec_not_zero(&(l)->a)
 
 /* Non-atomic variants, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well. */
@@ -83,6 +84,7 @@ typedef struct {
 #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
 #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
 #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
+#define local64_dec_not_zero(l)	atomic64_dec_not_zero(&(l)->a)
 
 /* Non-atomic variants, ie. preemption disabled and won't be touched
  * in interrupt, etc.  Some archs can optimize this case well. */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 42b77b5..ad2b750 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -27,6 +27,15 @@ static inline int atomic_add_unless(atomic_t *v, int a, int u)
 #define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
 
 /**
+ * atomic_dec_not_zero - decrement unless the number is zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1, so long as @v is non-zero.
+ * Returns non-zero if @v was non-zero, and zero otherwise.
+ */
+#define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)
+
+/**
  * atomic_inc_not_zero_hint - increment if not null
  * @v: pointer of type atomic_t
  * @hint: probable value of the atomic before the increment
-- 
1.7.5.4
