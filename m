Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Oct 2017 05:11:03 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] bitmap: Fix optimization of bitmap_set/clear for
 big-endian machines
Message-ID: <20171025121102.GA15531@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Matthew Wilcox <mawilcox@microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


(I don't think I can reliably send patches from outlook; sorry for
breaking the threading)

I see where we're not incrementing the failure count ... try this patch!

--- 8< ---

Subject: Fix bitmap optimisation tests to report errors correctly
From: Matthew Wilcox <mawilcox@microsoft.com>

I had neglected to increment the error counter when the tests failed,
which made the tests noisy when they fail, but not actually return an
error code.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Cc: stable@kernel.org

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index aa1f2669bdd5..ae8a830e4e54 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -430,23 +430,32 @@ static void noinline __init test_mem_optimisations(void)
 	unsigned int start, nbits;
 
 	for (start = 0; start < 1024; start += 8) {
-		memset(bmap1, 0x5a, sizeof(bmap1));
-		memset(bmap2, 0x5a, sizeof(bmap2));
 		for (nbits = 0; nbits < 1024 - start; nbits += 8) {
+			memset(bmap1, 0x5a, sizeof(bmap1));
+			memset(bmap2, 0x5a, sizeof(bmap2));
+
 			bitmap_set(bmap1, start, nbits);
 			__bitmap_set(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("set not __equal %d %d\n", start, nbits);
+				failed_tests++;
+			}
 
 			bitmap_clear(bmap1, start, nbits);
 			__bitmap_clear(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024))
+			if (!bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not equal %d %d\n", start, nbits);
-			if (!__bitmap_equal(bmap1, bmap2, 1024))
+				failed_tests++;
+			}
+			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
 				printk("clear not __equal %d %d\n", start,
 									nbits);
+				failed_tests++;
+			}
 		}
 	}
 }
