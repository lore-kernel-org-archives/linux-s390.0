From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: asm-geniric: for atomic_set_mask() 1st param, use 'unsigned
 int' instead of 'unsigned long'
Date: Sat, 08 Jun 2013 15:50:58 +0800
Message-ID: <51B2E262.3030603@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>, takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>
Cc: linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


atomic_set_mask() and atomic_clear_mask() are the pairs, so the related
parameters' type need match with each other.

The type of 'addr->counter' is 'int', so use 'unsigned int' instead
of 'unsigned long', and let atomic_set_mask() match atomic_clear_mask().


For arch sub-system, currently, have 3 types of definition for them:
1st for 'int', 2nd for 'long', 3rd is conflict to use 'int' and 'long'.

At least, better to fix 3rd (conflict using 'int' and 'long').


using 'long':
  ./h8300/include/asm/atomic.h:129:static __inline__ void atomic_set_mask(unsigned long mask, unsigned long *v) 
  ./h8300/include/asm/atomic.h:118:static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *v) 
  ./mn10300/include/asm/atomic.h:211:static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
  ./mn10300/include/asm/atomic.h:177:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
  ./m68k/include/asm/atomic.h:192:static inline void atomic_set_mask(unsigned long mask, unsigned long *v) 
  ./m68k/include/asm/atomic.h:187:static inline void atomic_clear_mask(unsigned long mask, unsigned long *v) 
  ./frv/include/asm/bitops.h:113:#define atomic_set_mask(mask, v) atomic_test_and_OR_mask((mask), (v))
  ./frv/include/asm/bitops.h:112:#define atomic_clear_mask(mask, v)       atomic_test_and_ANDNOT_mask((mask), (v))
  ./x86/include/asm/atomic.h:260:#define atomic_set_mask(mask, addr)                              \   
  ./x86/include/asm/atomic.h:256:#define atomic_clear_mask(mask, addr)                            \   

also using 'long': (but only atomic_clear_mask, no atomic_set_mask)
  ./arm64/include/asm/atomic.h:129:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
  ./arc/include/asm/atomic.h:89:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
  ./arc/include/asm/atomic.h:182:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
  ./arm/include/asm/atomic.h:137:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
  ./arm/include/asm/atomic.h:200:static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)

using 'int':
  ./metag/include/asm/atomic_lock1.h:100:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./metag/include/asm/atomic_lnkget.h:127:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./metag/include/asm/atomic_lock1.h:90:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 
  ./metag/include/asm/atomic_lnkget.h:110:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-grb.h:104:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-irq.h:64:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-llsc.h:93:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-grb.h:84:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-irq.h:55:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 
  ./sh/include/asm/atomic-llsc.h:79:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 
  ./xtensa/include/asm/atomic.h:357:static inline void atomic_set_mask(unsigned int mask, atomic_t *v) 
  ./xtensa/include/asm/atomic.h:322:static inline void atomic_clear_mask(unsigned int mask, atomic_t *v) 

also using 'int', (better to notice 'signed' and 'unsigned'):
  ./blackfin/include/asm/atomic.h:31:#define atomic_set_mask(m, v)   __raw_atomic_set_asm(&(v)->counter, m)
  ./blackfin/include/asm/atomic.h:30:#define atomic_clear_mask(m, v) __raw_atomic_clear_asm(&(v)->counter, m)

conflict to use 'int' and 'long':
  ./m32r/include/asm/atomic.h:289:static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
  ./m32r/include/asm/atomic.h:267:static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
  ./s390/include/asm/atomic.h:79:static inline void atomic_set_mask(unsigned long mask, atomic_t *v) 
  ./s390/include/asm/atomic.h:74:static inline void atomic_clear_mask(unsigned long mask, atomic_t *v) 
  (in fact, 'generic' is also conflict to use 'int' and 'long')


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/blackfin/include/asm/atomic.h |    4 ++--
 arch/m32r/include/asm/atomic.h     |    4 ++--
 arch/s390/include/asm/atomic.h     |    4 ++--
 include/asm-generic/atomic.h       |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/blackfin/include/asm/atomic.h b/arch/blackfin/include/asm/atomic.h
index a107a98..feefef8 100644
--- a/arch/blackfin/include/asm/atomic.h
+++ b/arch/blackfin/include/asm/atomic.h
@@ -27,8 +27,8 @@ asmlinkage int __raw_atomic_test_asm(const volatile int *ptr, int value);
 #define atomic_add_return(i, v) __raw_atomic_update_asm(&(v)->counter, i)
 #define atomic_sub_return(i, v) __raw_atomic_update_asm(&(v)->counter, -(i))
 
-#define atomic_clear_mask(m, v) __raw_atomic_clear_asm(&(v)->counter, m)
-#define atomic_set_mask(m, v)   __raw_atomic_set_asm(&(v)->counter, m)
+#define atomic_clear_mask(m, v) __raw_atomic_clear_asm(&(v)->counter, (int)(m))
+#define atomic_set_mask(m, v)   __raw_atomic_set_asm(&(v)->counter, (int)(m))
 
 #endif
 
diff --git a/arch/m32r/include/asm/atomic.h b/arch/m32r/include/asm/atomic.h
index 0d81697..233c743 100644
--- a/arch/m32r/include/asm/atomic.h
+++ b/arch/m32r/include/asm/atomic.h
@@ -264,7 +264,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
 }
 
 
-static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *addr)
 {
 	unsigned long flags;
 	unsigned long tmp;
@@ -286,7 +286,7 @@ static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
 	local_irq_restore(flags);
 }
 
-static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
+static __inline__ void atomic_set_mask(unsigned int mask, atomic_t *addr)
 {
 	unsigned long flags;
 	unsigned long tmp;
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index c797832..82cd683 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -71,12 +71,12 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	__CS_LOOP(v, ~mask, "nr");
 }
 
-static inline void atomic_set_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
 {
 	__CS_LOOP(v, mask, "or");
 }
diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 33bd2de..f31bff97 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -153,7 +153,7 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
  * Atomically clears the bits set in @mask from @v
  */
 #ifndef atomic_clear_mask
-static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
 
-- 
1.7.7.6
