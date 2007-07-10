Return-Path: <linux-kernel-owner+w=401wt.eu-S1764448AbXGJJcB@vger.kernel.org>
Message-Id: <20070710093118.952355099@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/16] Remove volatile from atomic_t
Content-Disposition: inline; filename=010-atomic.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Follow i386/x86_64 and remove 'volatile' from atomic_t.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/atomic.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/include/asm-s390/atomic.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/atomic.h
+++ quilt-2.6/include/asm-s390/atomic.h
@@ -24,7 +24,7 @@
  */
 
 typedef struct {
-	volatile int counter;
+	int counter;
 } __attribute__ ((aligned (4))) atomic_t;
 #define ATOMIC_INIT(i)  { (i) }
 
@@ -141,7 +141,7 @@ static __inline__ int atomic_add_unless(
 
 #ifdef __s390x__
 typedef struct {
-	volatile long long counter;
+	long long counter;
 } __attribute__ ((aligned (8))) atomic64_t;
 #define ATOMIC64_INIT(i)  { (i) }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
