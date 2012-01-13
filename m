From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 3/7] bitops: introduce list_for_each_clear_bit
Date: Sat, 14 Jan 2012 00:53:20 +0900
Message-Id: <1326470004-10096-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1326470004-10096-1-git-send-email-akinobu.mita@gmail.com>
References: <1326470004-10096-1-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, Robert Richter <robert.richter@amd.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Introduce list_for_each_clear_bit() and list_for_each_clear_bit_from().
They are similar to for_each_set_bit() and list_for_each_set_bit_from(),
but they iterate over all the cleared bits in a memory region.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 include/linux/bitops.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 15ad702..c8a0d65 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -32,6 +32,17 @@ extern unsigned long __sw_hweight64(__u64 w);
 	     (bit) < (size);					\
 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
 
+#define for_each_clear_bit(bit, addr, size) \
+	for ((bit) = find_first_zero_bit((addr), (size));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
+/* same as for_each_clear_bit() but use bit as value to start with */
+#define for_each_clear_bit_from(bit, addr, size) \
+	for ((bit) = find_next_zero_bit((addr), (size), (bit));	\
+	     (bit) < (size);					\
+	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
+
 static __inline__ int get_bitmask_order(unsigned int count)
 {
 	int order;
-- 
1.7.4.4
