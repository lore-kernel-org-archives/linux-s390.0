Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 06/12] s390/airq: use DMA memory for adapter interrupts
Date: Fri,  5 Apr 2019 01:16:16 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-7-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Protected virtualization guests have to use shared pages for airq
notifier bit vectors, because hypervisor needs to write these bits.

Let us make sure we allocate DMA memory for the notifier bit vectors.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/airq.h |  2 ++
 arch/s390/include/asm/cio.h  |  1 +
 drivers/s390/cio/airq.c      | 18 ++++++++++++++----
 drivers/s390/cio/css.c       |  8 +++++++-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
index fcf539efb32f..1492d4856049 100644
--- a/arch/s390/include/asm/airq.h
+++ b/arch/s390/include/asm/airq.h
@@ -11,6 +11,7 @@
 #define _ASM_S390_AIRQ_H
 
 #include <linux/bit_spinlock.h>
+#include <linux/dma-mapping.h>
 
 struct airq_struct {
 	struct hlist_node list;		/* Handler queueing. */
@@ -29,6 +30,7 @@ void unregister_adapter_interrupt(struct airq_struct *airq);
 /* Adapter interrupt bit vector */
 struct airq_iv {
 	unsigned long *vector;	/* Adapter interrupt bit vector */
+	dma_addr_t vector_dma; /* Adapter interrupt bit vector dma */
 	unsigned long *avail;	/* Allocation bit mask for the bit vector */
 	unsigned long *bitlock;	/* Lock bit mask for the bit vector */
 	unsigned long *ptr;	/* Pointer associated with each bit */
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 4510e418614a..036d3a40d10d 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -330,6 +330,7 @@ extern void css_schedule_reprobe(void);
 
 extern void *cio_dma_zalloc(size_t size);
 extern void cio_dma_free(void *cpu_addr, size_t size);
+extern struct device *cio_get_dma_css_dev(void);
 
 /* Function from drivers/s390/cio/chsc.c */
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index a45011e4529e..7a5c0a08ee09 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -19,6 +19,7 @@
 
 #include <asm/airq.h>
 #include <asm/isc.h>
+#include <asm/cio.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -113,6 +114,11 @@ void __init init_airq_interrupts(void)
 	setup_irq(THIN_INTERRUPT, &airq_interrupt);
 }
 
+static inline unsigned long iv_size(unsigned long bits)
+{
+	return BITS_TO_LONGS(bits) * sizeof(unsigned long);
+}
+
 /**
  * airq_iv_create - create an interrupt vector
  * @bits: number of bits in the interrupt vector
@@ -123,14 +129,15 @@ void __init init_airq_interrupts(void)
 struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
 {
 	struct airq_iv *iv;
-	unsigned long size;
+	unsigned long size = 0;
 
 	iv = kzalloc(sizeof(*iv), GFP_KERNEL);
 	if (!iv)
 		goto out;
 	iv->bits = bits;
-	size = BITS_TO_LONGS(bits) * sizeof(unsigned long);
-	iv->vector = kzalloc(size, GFP_KERNEL);
+	size = iv_size(bits);
+	iv->vector = dma_alloc_coherent(cio_get_dma_css_dev(), size,
+						 &iv->vector_dma, GFP_KERNEL);
 	if (!iv->vector)
 		goto out_free;
 	if (flags & AIRQ_IV_ALLOC) {
@@ -165,7 +172,8 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
 	kfree(iv->ptr);
 	kfree(iv->bitlock);
 	kfree(iv->avail);
-	kfree(iv->vector);
+	dma_free_coherent(cio_get_dma_css_dev(), size, iv->vector,
+			  iv->vector_dma);
 	kfree(iv);
 out:
 	return NULL;
@@ -182,6 +190,8 @@ void airq_iv_release(struct airq_iv *iv)
 	kfree(iv->ptr);
 	kfree(iv->bitlock);
 	kfree(iv->vector);
+	dma_free_coherent(cio_get_dma_css_dev(), iv_size(iv->bits),
+			  iv->vector, iv->vector_dma);
 	kfree(iv->avail);
 	kfree(iv);
 }
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 72629d99d8e4..9e21c2a50682 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1031,13 +1031,19 @@ static struct gen_pool *cio_dma_pool;
 static struct device *cio_dma_css;
 static gfp_t  cio_dma_flags;
 
+
+struct device *cio_get_dma_css_dev(void)
+{
+	return &channel_subsystems[0]->device;
+}
+
 static void __init cio_dma_pool_init(void)
 {
 	void *cpu_addr;
 	dma_addr_t dma_addr;
 	int i;
 
-	cio_dma_css = &channel_subsystems[0]->device;
+	cio_dma_css =  cio_get_dma_css_dev();
 	cio_dma_flags = GFP_DMA | GFP_KERNEL | __GFP_ZERO;
 	cio_dma_pool = gen_pool_create(3, -1);
 	/* No need to free up the resources: compiled in */
-- 
2.16.4
