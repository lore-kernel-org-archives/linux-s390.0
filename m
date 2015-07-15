From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 6/6] cputime: Introduce cputime_to_timespec64()/timespec64_to_cputime()
Date: Wed, 15 Jul 2015 14:07:21 +0800
Message-ID: <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
References: <cover.1436511577.git.baolin.wang@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <cover.1436511577.git.baolin.wang@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: benh@kernel.crashing.org
Cc: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org, peterz@infradead.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org, fweisbec@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, y2038@lists.linaro.org
List-ID: <linux-s390.vger.kernel.org>

The cputime_to_timespec() and timespec_to_cputime() functions are
not year 2038 safe on 32bit systems due to that the struct timepsec
will overflow in 2038 year. This patch introduces cputime_to_timespec64()
and timespec64_to_cputime() functions which use struct timespec64.
And converts arch specific implementations in arch/s390 and arch/powerpc.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/powerpc/include/asm/cputime.h    |    6 +++---
 arch/s390/include/asm/cputime.h       |    8 ++++----
 include/asm-generic/cputime_jiffies.h |   10 +++++-----
 include/asm-generic/cputime_nsecs.h   |    6 +++---
 include/linux/cputime.h               |   16 ++++++++++++++++
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index e245255..5dda5c0 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -154,9 +154,9 @@ static inline cputime_t secs_to_cputime(const unsigned long sec)
 }
 
 /*
- * Convert cputime <-> timespec
+ * Convert cputime <-> timespec64
  */
-static inline void cputime_to_timespec(const cputime_t ct, struct timespec *p)
+static inline void cputime_to_timespec64(const cputime_t ct, struct timespec64 *p)
 {
 	u64 x = (__force u64) ct;
 	unsigned int frac;
@@ -168,7 +168,7 @@ static inline void cputime_to_timespec(const cputime_t ct, struct timespec *p)
 	p->tv_nsec = x;
 }
 
-static inline cputime_t timespec_to_cputime(const struct timespec *p)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *p)
 {
 	u64 ct;
 
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 221b454..3319b51 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -81,16 +81,16 @@ static inline cputime_t secs_to_cputime(const unsigned int s)
 }
 
 /*
- * Convert cputime to timespec and back.
+ * Convert cputime to timespec64 and back.
  */
-static inline cputime_t timespec_to_cputime(const struct timespec *value)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *value)
 {
 	unsigned long long ret = value->tv_sec * CPUTIME_PER_SEC;
 	return (__force cputime_t)(ret + __div(value->tv_nsec * CPUTIME_PER_USEC, NSEC_PER_USEC));
 }
 
-static inline void cputime_to_timespec(const cputime_t cputime,
-				       struct timespec *value)
+static inline void cputime_to_timespec64(const cputime_t cputime,
+					 struct timespec64 *value)
 {
 	unsigned long long __cputime = (__force unsigned long long) cputime;
 	value->tv_nsec = (__cputime % CPUTIME_PER_SEC) * NSEC_PER_USEC / CPUTIME_PER_USEC;
diff --git a/include/asm-generic/cputime_jiffies.h b/include/asm-generic/cputime_jiffies.h
index fe386fc..54e034c 100644
--- a/include/asm-generic/cputime_jiffies.h
+++ b/include/asm-generic/cputime_jiffies.h
@@ -44,12 +44,12 @@ typedef u64 __nocast cputime64_t;
 #define secs_to_cputime(sec)		jiffies_to_cputime((sec) * HZ)
 
 /*
- * Convert cputime to timespec and back.
+ * Convert cputime to timespec64 and back.
  */
-#define timespec_to_cputime(__val)	\
-	jiffies_to_cputime(timespec_to_jiffies(__val))
-#define cputime_to_timespec(__ct,__val)	\
-	jiffies_to_timespec(cputime_to_jiffies(__ct),__val)
+#define timespec64_to_cputime(__val)	\
+	jiffies_to_cputime(timespec64_to_jiffies(__val))
+#define cputime_to_timespec64(__ct,__val)	\
+	jiffies_to_timespec64(cputime_to_jiffies(__ct),__val)
 
 /*
  * Convert cputime to timeval and back.
diff --git a/include/asm-generic/cputime_nsecs.h b/include/asm-generic/cputime_nsecs.h
index 0419485..c0cafc0 100644
--- a/include/asm-generic/cputime_nsecs.h
+++ b/include/asm-generic/cputime_nsecs.h
@@ -71,14 +71,14 @@ typedef u64 __nocast cputime64_t;
 	(__force cputime_t)((__secs) * NSEC_PER_SEC)
 
 /*
- * Convert cputime <-> timespec (nsec)
+ * Convert cputime <-> timespec64 (nsec)
  */
-static inline cputime_t timespec_to_cputime(const struct timespec *val)
+static inline cputime_t timespec64_to_cputime(const struct timespec64 *val)
 {
 	u64 ret = val->tv_sec * NSEC_PER_SEC + val->tv_nsec;
 	return (__force cputime_t) ret;
 }
-static inline void cputime_to_timespec(const cputime_t ct, struct timespec *val)
+static inline void cputime_to_timespec64(const cputime_t ct, struct timespec64 *val)
 {
 	u32 rem;
 
diff --git a/include/linux/cputime.h b/include/linux/cputime.h
index f2eb2ee..cd638a0 100644
--- a/include/linux/cputime.h
+++ b/include/linux/cputime.h
@@ -13,4 +13,20 @@
 	usecs_to_cputime((__nsecs) / NSEC_PER_USEC)
 #endif
 
+static inline cputime_t timespec_to_cputime(const struct timespec *ts)
+{
+	struct timespec64 ts64 = timespec_to_timespec64(*ts);
+
+	return timespec64_to_cputime(&ts64);
+}
+
+static inline void cputime_to_timespec(const cputime_t cputime,
+				       struct timespec *value)
+{
+	struct timespec64 ts64;
+
+	cputime_to_timespec64(cputime, &ts64);
+	*value = timespec64_to_timespec(ts64);
+}
+
 #endif /* __LINUX_CPUTIME_H */
-- 
1.7.9.5
