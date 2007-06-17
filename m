Return-Path: <linux-kernel-owner+w=401wt.eu-S1759643AbXFQWdh@vger.kernel.org>
From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] use __asm__ and __volatile__ in i386/arm/s390 byteorder.h
Date: Sun, 17 Jun 2007 18:33:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706171833.29046.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

This changes asm() to __asm__() and volatile to __volatile__ so that these
headers can be used with gcc's -std=c99.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
diff --git a/include/asm-arm/byteorder.h b/include/asm-arm/byteorder.h
index e6f7fcd..39105dc 100644
--- a/include/asm-arm/byteorder.h
+++ b/include/asm-arm/byteorder.h
@@ -29,7 +29,7 @@ static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
 		 * right thing and not screw it up to different degrees
 		 * depending on the gcc version.
 		 */
-		asm ("eor\t%0, %1, %1, ror #16" : "=r" (t) : "r" (x));
+		__asm__ ("eor\t%0, %1, %1, ror #16" : "=r" (t) : "r" (x));
 	} else
 #endif
 		t = x ^ ((x << 16) | (x >> 16)); /* eor r1,r0,r0,ror #16 */
diff --git a/include/asm-i386/byteorder.h b/include/asm-i386/byteorder.h
index a45470a..4ead40b 100644
--- a/include/asm-i386/byteorder.h
+++ b/include/asm-i386/byteorder.h
@@ -32,13 +32,13 @@ static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 val)
 	} v;
 	v.u = val;
 #ifdef CONFIG_X86_BSWAP
-	asm("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
-	    : "=r" (v.s.a), "=r" (v.s.b) 
-	    : "0" (v.s.a), "1" (v.s.b)); 
+	__asm__("bswapl %0 ; bswapl %1 ; xchgl %0,%1" 
+	        : "=r" (v.s.a), "=r" (v.s.b) 
+	        : "0" (v.s.a), "1" (v.s.b)); 
 #else
    v.s.a = ___arch__swab32(v.s.a); 
 	v.s.b = ___arch__swab32(v.s.b); 
-	asm("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
+	__asm__("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
 #endif
 	return v.u;	
 } 
diff --git a/include/asm-s390/byteorder.h b/include/asm-s390/byteorder.h
index 1fe2492..07230f6 100644
--- a/include/asm-s390/byteorder.h
+++ b/include/asm-s390/byteorder.h
@@ -18,7 +18,7 @@ static inline __u64 ___arch__swab64p(const __u64 *x)
 {
 	__u64 result;
 
-	asm volatile("lrvg %0,%1" : "=d" (result) : "m" (*x));
+	__asm__ __volatile__("lrvg %0,%1" : "=d" (result) : "m" (*x));
 	return result;
 }
 
@@ -26,7 +26,7 @@ static inline __u64 ___arch__swab64(__u64 x)
 {
 	__u64 result;
 
-	asm volatile("lrvgr %0,%1" : "=d" (result) : "d" (x));
+	__asm__ __volatile__("lrvgr %0,%1" : "=d" (result) : "d" (x));
 	return result;
 }
 
@@ -40,7 +40,7 @@ static inline __u32 ___arch__swab32p(const __u32 *x)
 {
 	__u32 result;
 	
-	asm volatile(
+	__asm__ __volatile__(
 #ifndef __s390x__
 		"	icm	%0,8,3(%1)\n"
 		"	icm	%0,4,2(%1)\n"
@@ -61,7 +61,7 @@ static inline __u32 ___arch__swab32(__u32 x)
 #else /* __s390x__ */
 	__u32 result;
 	
-	asm volatile("lrvr  %0,%1" : "=d" (result) : "d" (x));
+	__asm__ __volatile__("lrvr  %0,%1" : "=d" (result) : "d" (x));
 	return result;
 #endif /* __s390x__ */
 }
@@ -75,7 +75,7 @@ static __inline__ __u16 ___arch__swab16p(const __u16 *x)
 {
 	__u16 result;
 	
-	asm volatile(
+	__asm__ __volatile__(
 #ifndef __s390x__
 		"	icm	%0,2,1(%1)\n"
 		"	ic	%0,0(%1)\n"
