Return-Path: <linux-kernel-owner+w=401wt.eu-S1763687AbZBYP0v@vger.kernel.org>
Message-Id: <20090225150838.743662062@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 42/46] bitops: remove likely annotations
Content-Disposition: inline; filename=141-bitops-remove-likely.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

likely/unlikely profiling revealed that none of the branches in bitops
is taken likely or unlikely. So remove the annotations.
In addition the generated code is shorter.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/bitops.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/bitops.h
+++ quilt-2.6/arch/s390/include/asm/bitops.h
@@ -525,16 +525,16 @@ static inline unsigned long __ffs_word_l
 static inline unsigned long __ffz_word(unsigned long nr, unsigned long word)
 {
 #ifdef __s390x__
-	if (likely((word & 0xffffffff) == 0xffffffff)) {
+	if ((word & 0xffffffff) == 0xffffffff) {
 		word >>= 32;
 		nr += 32;
 	}
 #endif
-	if (likely((word & 0xffff) == 0xffff)) {
+	if ((word & 0xffff) == 0xffff) {
 		word >>= 16;
 		nr += 16;
 	}
-	if (likely((word & 0xff) == 0xff)) {
+	if ((word & 0xff) == 0xff) {
 		word >>= 8;
 		nr += 8;
 	}
@@ -549,16 +549,16 @@ static inline unsigned long __ffz_word(u
 static inline unsigned long __ffs_word(unsigned long nr, unsigned long word)
 {
 #ifdef __s390x__
-	if (likely((word & 0xffffffff) == 0)) {
+	if ((word & 0xffffffff) == 0) {
 		word >>= 32;
 		nr += 32;
 	}
 #endif
-	if (likely((word & 0xffff) == 0)) {
+	if ((word & 0xffff) == 0) {
 		word >>= 16;
 		nr += 16;
 	}
-	if (likely((word & 0xff) == 0)) {
+	if ((word & 0xff) == 0) {
 		word >>= 8;
 		nr += 8;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
