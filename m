From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 7/8] s390/airq: add support for irq ranges
Date: Tue,  4 Mar 2014 12:27:17 +0100
Message-ID: <1393932438-58848-8-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add airq_iv_alloc and airq_iv_free to allocate and free consecutive
ranges of irqs from the interrupt vector.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/airq.h | 14 ++++++++--
 drivers/s390/cio/airq.c      | 66 +++++++++++++++++++++++++++-----------------
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
index 4bbb595..bd93ff6 100644
--- a/arch/s390/include/asm/airq.h
+++ b/arch/s390/include/asm/airq.h
@@ -44,11 +44,21 @@ struct airq_iv {
 
 struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags);
 void airq_iv_release(struct airq_iv *iv);
-unsigned long airq_iv_alloc_bit(struct airq_iv *iv);
-void airq_iv_free_bit(struct airq_iv *iv, unsigned long bit);
+unsigned long airq_iv_alloc(struct airq_iv *iv, unsigned long num);
+void airq_iv_free(struct airq_iv *iv, unsigned long bit, unsigned long num);
 unsigned long airq_iv_scan(struct airq_iv *iv, unsigned long start,
 			   unsigned long end);
 
+static inline unsigned long airq_iv_alloc_bit(struct airq_iv *iv)
+{
+	return airq_iv_alloc(iv, 1);
+}
+
+static inline void airq_iv_free_bit(struct airq_iv *iv, unsigned long bit)
+{
+	airq_iv_free(iv, bit, 1);
+}
+
 static inline unsigned long airq_iv_end(struct airq_iv *iv)
 {
 	return iv->end;
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index f055df0..445564c 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -186,55 +186,71 @@ void airq_iv_release(struct airq_iv *iv)
 EXPORT_SYMBOL(airq_iv_release);
 
 /**
- * airq_iv_alloc_bit - allocate an irq bit from an interrupt vector
+ * airq_iv_alloc - allocate irq bits from an interrupt vector
  * @iv: pointer to an interrupt vector structure
+ * @num: number of consecutive irq bits to allocate
  *
- * Returns the bit number of the allocated irq, or -1UL if no bit
- * is available or the AIRQ_IV_ALLOC flag has not been specified
+ * Returns the bit number of the first irq in the allocated block of irqs,
+ * or -1UL if no bit is available or the AIRQ_IV_ALLOC flag has not been
+ * specified
  */
-unsigned long airq_iv_alloc_bit(struct airq_iv *iv)
+unsigned long airq_iv_alloc(struct airq_iv *iv, unsigned long num)
 {
-	unsigned long bit;
+	unsigned long bit, i;
 
-	if (!iv->avail)
+	if (!iv->avail || num == 0)
 		return -1UL;
 	spin_lock(&iv->lock);
 	bit = find_first_bit_inv(iv->avail, iv->bits);
-	if (bit < iv->bits) {
-		clear_bit_inv(bit, iv->avail);
-		if (bit >= iv->end)
-			iv->end = bit + 1;
-	} else
+	while (bit + num <= iv->bits) {
+		for (i = 1; i < num; i++)
+			if (!test_bit_inv(bit + i, iv->avail))
+				break;
+		if (i >= num) {
+			/* Found a suitable block of irqs */
+			for (i = 0; i < num; i++)
+				clear_bit_inv(bit + i, iv->avail);
+			if (bit + num >= iv->end)
+				iv->end = bit + num + 1;
+			break;
+		}
+		bit = find_next_bit_inv(iv->avail, iv->bits, bit + i + 1);
+	}
+	if (bit + num > iv->bits)
 		bit = -1UL;
 	spin_unlock(&iv->lock);
 	return bit;
 
 }
-EXPORT_SYMBOL(airq_iv_alloc_bit);
+EXPORT_SYMBOL(airq_iv_alloc);
 
 /**
- * airq_iv_free_bit - free an irq bit of an interrupt vector
+ * airq_iv_free - free irq bits of an interrupt vector
  * @iv: pointer to interrupt vector structure
- * @bit: number of the irq bit to free
+ * @bit: number of the first irq bit to free
+ * @num: number of consecutive irq bits to free
  */
-void airq_iv_free_bit(struct airq_iv *iv, unsigned long bit)
+void airq_iv_free(struct airq_iv *iv, unsigned long bit, unsigned long num)
 {
-	if (!iv->avail)
+	unsigned long i;
+
+	if (!iv->avail || num == 0)
 		return;
 	spin_lock(&iv->lock);
-	/* Clear (possibly left over) interrupt bit */
-	clear_bit_inv(bit, iv->vector);
-	/* Make the bit position available again */
-	set_bit_inv(bit, iv->avail);
-	if (bit == iv->end - 1) {
+	for (i = 0; i < num; i++) {
+		/* Clear (possibly left over) interrupt bit */
+		clear_bit_inv(bit + i, iv->vector);
+		/* Make the bit positions available again */
+		set_bit_inv(bit + i, iv->avail);
+	}
+	if (bit + num >= iv->end) {
 		/* Find new end of bit-field */
-		while (--iv->end > 0)
-			if (!test_bit_inv(iv->end - 1, iv->avail))
-				break;
+		while (iv->end > 0 && !test_bit_inv(iv->end - 1, iv->avail))
+			iv->end--;
 	}
 	spin_unlock(&iv->lock);
 }
-EXPORT_SYMBOL(airq_iv_free_bit);
+EXPORT_SYMBOL(airq_iv_free);
 
 /**
  * airq_iv_scan - scan interrupt vector for non-zero bits
-- 
1.8.4.2
