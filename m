Return-Path: <linux-kernel-owner+w=401wt.eu-S1760904AbXJDLgG@vger.kernel.org>
Message-Id: <20071004112832.051763381@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/34] Force link error if xchg/cmpxchg gets called with unsupported size.
Content-Disposition: inline; filename=027-xchg-linkerror.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/system.h |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -130,6 +130,8 @@ extern void pfault_fini(void);
 	__ret;								  \
 })
 
+extern void __xchg_called_with_bad_pointer(void);
+
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
 	unsigned long addr, old;
@@ -150,8 +152,7 @@ static inline unsigned long __xchg(unsig
 			: "=&d" (old), "=m" (*(int *) addr)
 			: "d" (x << shift), "d" (~(255 << shift)), "a" (addr),
 			  "m" (*(int *) addr) : "memory", "cc", "0");
-		x = old >> shift;
-		break;
+		return old >> shift;
 	case 2:
 		addr = (unsigned long) ptr;
 		shift = (2 ^ (addr & 2)) << 3;
@@ -166,8 +167,7 @@ static inline unsigned long __xchg(unsig
 			: "=&d" (old), "=m" (*(int *) addr)
 			: "d" (x << shift), "d" (~(65535 << shift)), "a" (addr),
 			  "m" (*(int *) addr) : "memory", "cc", "0");
-		x = old >> shift;
-		break;
+		return old >> shift;
 	case 4:
 		asm volatile(
 			"	l	%0,0(%3)\n"
@@ -176,8 +176,7 @@ static inline unsigned long __xchg(unsig
 			: "=&d" (old), "=m" (*(int *) ptr)
 			: "d" (x), "a" (ptr), "m" (*(int *) ptr)
 			: "memory", "cc");
-		x = old;
-		break;
+		return old;
 #ifdef __s390x__
 	case 8:
 		asm volatile(
@@ -187,11 +186,11 @@ static inline unsigned long __xchg(unsig
 			: "=&d" (old), "=m" (*(long *) ptr)
 			: "d" (x), "a" (ptr), "m" (*(long *) ptr)
 			: "memory", "cc");
-		x = old;
-		break;
+		return old;
 #endif /* __s390x__ */
-        }
-        return x;
+	}
+	__xchg_called_with_bad_pointer();
+	return x;
 }
 
 /*
@@ -206,6 +205,8 @@ static inline unsigned long __xchg(unsig
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
 
+extern void __cmpxchg_called_with_bad_pointer(void);
+
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
@@ -270,7 +271,8 @@ __cmpxchg(volatile void *ptr, unsigned l
 		return prev;
 #endif /* __s390x__ */
         }
-        return old;
+	__cmpxchg_called_with_bad_pointer();
+	return old;
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
