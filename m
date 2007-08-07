Return-Path: <linux-kernel-owner+w=401wt.eu-S1765941AbXHGLQs@vger.kernel.org>
Message-Id: <20070807111845.418962873@de.ibm.com>
References: <20070807111519.972871123@de.ibm.com>
Date: Tue, 07 Aug 2007 13:15:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/18] qdio: make sure data structures are correctly aligned.
Content-Disposition: inline; filename=003-qdio-align.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The slsb structure contained at the beginning of the qdio_q structure
must start on a 256 byte boundary. To make sure this is the case even
if slab debugging is turned on create an own slab cache for qdio_q
structures.
Besides that don't use the slab allocator to allocate whole pages. Use
the page allocator instead.
Also fix a few memory leaks in error handling code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   92 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -81,6 +81,7 @@ static __u32 volatile spare_indicator;
 static atomic_t spare_indicator_usecount;
 #define QDIO_MEMPOOL_SCSSC_ELEMENTS 2
 static mempool_t *qdio_mempool_scssc;
+static struct kmem_cache *qdio_q_cache;
 
 static debug_info_t *qdio_dbf_setup;
 static debug_info_t *qdio_dbf_sbal;
@@ -1617,23 +1618,21 @@ static void
 qdio_release_irq_memory(struct qdio_irq *irq_ptr)
 {
 	int i;
+	struct qdio_q *q;
 
-	for (i=0;i<QDIO_MAX_QUEUES_PER_IRQ;i++) {
-		if (!irq_ptr->input_qs[i])
-			goto next;
-
-		kfree(irq_ptr->input_qs[i]->slib);
-		kfree(irq_ptr->input_qs[i]);
-
-next:
-		if (!irq_ptr->output_qs[i])
-			continue;
-
-		kfree(irq_ptr->output_qs[i]->slib);
-		kfree(irq_ptr->output_qs[i]);
-
+	for (i = 0; i < QDIO_MAX_QUEUES_PER_IRQ; i++) {
+		q = irq_ptr->input_qs[i];
+		if (q) {
+			free_page((unsigned long) q->slib);
+			kmem_cache_free(qdio_q_cache, q);
+		}
+		q = irq_ptr->output_qs[i];
+		if (q) {
+			free_page((unsigned long) q->slib);
+			kmem_cache_free(qdio_q_cache, q);
+		}
 	}
-	kfree(irq_ptr->qdr);
+	free_page((unsigned long) irq_ptr->qdr);
 	free_page((unsigned long) irq_ptr);
 }
 
@@ -1680,44 +1679,35 @@ qdio_alloc_qs(struct qdio_irq *irq_ptr,
 {
 	int i;
 	struct qdio_q *q;
-	int result=-ENOMEM;
-
-	for (i=0;i<no_input_qs;i++) {
-		q = kzalloc(sizeof(struct qdio_q), GFP_KERNEL);
 
-		if (!q) {
-			QDIO_PRINT_ERR("kmalloc of q failed!\n");
-			goto out;
-		}
+	for (i = 0; i < no_input_qs; i++) {
+		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		if (!q)
+			return -ENOMEM;
+		memset(q, 0, sizeof(*q));
 
-		q->slib = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		q->slib = (struct slib *) __get_free_page(GFP_KERNEL);
 		if (!q->slib) {
-			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
-			goto out;
+			kmem_cache_free(qdio_q_cache, q);
+			return -ENOMEM;
 		}
-
 		irq_ptr->input_qs[i]=q;
 	}
 
-	for (i=0;i<no_output_qs;i++) {
-		q = kzalloc(sizeof(struct qdio_q), GFP_KERNEL);
-
-		if (!q) {
-			goto out;
-		}
+	for (i = 0; i < no_output_qs; i++) {
+		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		if (!q)
+			return -ENOMEM;
+		memset(q, 0, sizeof(*q));
 
-		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
+		q->slib = (struct slib *) __get_free_page(GFP_KERNEL);
 		if (!q->slib) {
-			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
-			goto out;
+			kmem_cache_free(qdio_q_cache, q);
+			return -ENOMEM;
 		}
-
 		irq_ptr->output_qs[i]=q;
 	}
-
-	result=0;
-out:
-	return result;
+	return 0;
 }
 
 static void
@@ -2985,17 +2975,17 @@ qdio_allocate(struct qdio_initialize *in
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
 
 	if (!irq_ptr) {
-		QDIO_PRINT_ERR("kmalloc of irq_ptr failed!\n");
+		QDIO_PRINT_ERR("allocation of irq_ptr failed!\n");
 		return -ENOMEM;
 	}
 
 	init_MUTEX(&irq_ptr->setting_up_sema);
 
 	/* QDR must be in DMA area since CCW data address is only 32 bit */
-	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
+	irq_ptr->qdr = (struct qdr *) __get_free_page(GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
    		free_page((unsigned long) irq_ptr);
-    		QDIO_PRINT_ERR("kmalloc of irq_ptr->qdr failed!\n");
+		QDIO_PRINT_ERR("allocation of irq_ptr->qdr failed!\n");
 		return -ENOMEM;
        	}
 	QDIO_DBF_TEXT0(0,setup,"qdr:");
@@ -3004,6 +2994,7 @@ qdio_allocate(struct qdio_initialize *in
 	if (qdio_alloc_qs(irq_ptr,
        			  init_data->no_input_qs,
 			  init_data->no_output_qs)) {
+		QDIO_PRINT_ERR("queue allocation failed!\n");
 		qdio_release_irq_memory(irq_ptr);
 		return -ENOMEM;
 	}
@@ -3895,9 +3886,19 @@ init_QDIO(void)
 	if (res)
 		return res;
 
+	qdio_q_cache = kmem_cache_create("qdio_q", sizeof(struct qdio_q),
+					 256, 0, NULL);
+	if (!qdio_q_cache) {
+		qdio_release_qdio_memory();
+		return -ENOMEM;
+	}
+
 	res = qdio_register_dbf_views();
-	if (res)
+	if (res) {
+		kmem_cache_destroy(qdio_q_cache);
+		qdio_release_qdio_memory();
 		return res;
+	}
 
 	QDIO_DBF_TEXT0(0,setup,"initQDIO");
 	res = bus_create_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
@@ -3929,6 +3930,7 @@ cleanup_QDIO(void)
 	qdio_release_qdio_memory();
 	qdio_unregister_dbf_views();
 	mempool_destroy(qdio_mempool_scssc);
+	kmem_cache_destroy(qdio_q_cache);
 	bus_remove_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
   	printk("qdio: %s: module removed\n",version);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
