From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] s390: fix ext2_find_next_bit
Date: Thu, 21 Aug 2008 01:18:45 -0500
Message-ID: <48AD08C5.204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ext4-owner@vger.kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-ext4/>
List-Post: <mailto:linux-ext4@vger.kernel.org>
To: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: ext4 development <linux-ext4@vger.kernel.org>, Jan Glauber <jglauber@redhat.com>, Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
List-ID: <linux-s390.vger.kernel.org>

(oops, left off the s390 list on the first send)

The following changes get ext4 on s390 up and running for me.

the switch from ffs to __ffs changes where we start counting
(if the first bit is set, is that "0" or "1?"  ext2 wants to 
start counting with "0") and the rest is, honestly, just lifted 
from the stock find_next_bit() implementation.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
--

Index: linux-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/bitops.h	2008-08-11 16:23:58.000000000 -0500
+++ linux-2.6/arch/s390/include/asm/bitops.h	2008-08-21 00:49:40.950176518 -0500
@@ -862,10 +862,10 @@ static inline int ext2_find_next_bit(voi
 	p = addr + offset / __BITOPS_WORDSIZE;
 	if (bit) {
 		/*
-		 * s390 version of ffz returns __BITOPS_WORDSIZE
-		 * if no zero bit is present in the word.
+		 * s390 version of ffs returns __BITOPS_WORDSIZE
+		 * if no set bit is present in the word.
 		 */
-		set = ffs(__load_ulong_le(p, 0) >> bit) + bit;
+		set = __ffs(__load_ulong_le(p, 0) & (~0UL << bit));
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
