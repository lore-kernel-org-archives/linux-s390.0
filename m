Return-Path: <linux-kernel-owner+w=401wt.eu-S1753884AbXEXWLU@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.22-rc1-mm1 - s390 vs. md
Date: Thu, 24 May 2007 15:11:08 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E5201E703A5@azsmsx413.amr.corp.intel.com>
In-Reply-To: <20070523104639.6bc0650e@gondolin.boeblingen.de.ibm.com>
From: "Williams, Dan J" <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, schwidefsky@de.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> On Wed, 23 May 2007 10:05:39 +0200,
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > We are trying to get rid of dma-mapping.h, see the last change to
the
> > file with commit 411f0f3edc141a582190d3605cadd1d993abb6df. I don't
think
> > we should reintroduce dma related definition but split the async_tx
in a
> > way that allows to compile it on an architecture with
CONFIG_NO_DMA=y
> > (yes I know that is harder that to just add the dma stubs).

Not harder, it just a question of which is "uglier", but given the
direction taken with CONFIG_HAS_DMA it now appears more appropriate to
change async_tx.

> > You've said that there is a software implementation if there is no
dma
> > engine present. This software implementation should be independent
of
> > dma-mapping.h. Without having looked at the code, isn't it possible
to
> > isolate that software implementation into its own C file? That would
be
> > the only one that gets compiled for s390.
> 
> Taking a quick look at the async_*.c stuff, the functions in question
> basically seem to be of the form
> 
> check_if_we_can_do_it_async();
> if (async_ok) {
> 	/* do async stuff */
> 	/* that's where the dma mapping creeps in */
> } else {
> 	/* do it sync */
> 	/* seems fine for us */
> }
> 
> So you should be able to factor out (say) async_memset_{sync,async}()
> and put it into async_memset_{sync,async}.c. async_memset() would then
> be
> 
> async_memset()
> {
> #if CONFIG_HAS_DMA
> 	if (check_if_we_can_do_at_async())
> 		async_memset_async();
> #endif
> 	return async_memset_sync();
> }
> 
> Kconfig could then do
> 
> config ASYNC_MEMSET
> 	default m
> 	tristate "async_memset support"
> 	select ASYNC_MEMSET_ASYNC if HAS_DMA
> 
> config ASYNC_MEMSET_ASYNC
> 	depends on HAS_DMA
> 	tristate "async_memset async via dma support"
> 
> Thoughts?

I took your approach of encasing the HAS_DMA dependent portion of the
code in #ifdef CONFIG_HAS_DMA, and I dropped the dma-mapping-stub patch.
I let the compiler do the factoring out for me by making
async_tx_find_channel become the following when CONFIG_DMA_ENGINE=n:

static inline struct dma_chan *
async_tx_find_channel(struct dma_async_tx_descriptor *depend_tx,
	enum dma_transaction_type tx_type)
{
	return NULL;
}

---

diff --git a/async_tx/async_memcpy.c b/async_tx/async_memcpy.c
index 7896ba8..547976e 100644
--- a/async_tx/async_memcpy.c
+++ b/async_tx/async_memcpy.c
@@ -56,6 +56,7 @@ async_memcpy(struct page *dest, struct page *src,
unsigned int dest_offset,
 		int_en) : NULL;
 
 	if (tx) { /* run the memcpy asynchronously */
+		#ifdef CONFIG_HAS_DMA
 		dma_addr_t dma_addr;
 		enum dma_data_direction dir;
 
@@ -75,6 +76,9 @@ async_memcpy(struct page *dest, struct page *src,
unsigned int dest_offset,
 
 		async_tx_submit(chan, tx, flags, depend_tx, callback,
 			callback_param);
+		#else
+		BUG();
+		#endif /* CONFIG_HAS_DMA */
 	} else { /* run the memcpy synchronously */
 		void *dest_buf, *src_buf;
 		pr_debug("%s: (sync) len: %zu\n", __FUNCTION__, len);
diff --git a/async_tx/async_memset.c b/async_tx/async_memset.c
index 736c7c2..9166a27 100644
--- a/async_tx/async_memset.c
+++ b/async_tx/async_memset.c
@@ -55,6 +55,7 @@ async_memset(struct page *dest, int val, unsigned int
offset,
 			int_en) : NULL;
 
 	if (tx) { /* run the memset asynchronously */
+		#ifdef CONFIG_HAS_DMA
 		dma_addr_t dma_addr;
 		enum dma_data_direction dir;
 
@@ -67,6 +68,9 @@ async_memset(struct page *dest, int val, unsigned int
offset,
 
 		async_tx_submit(chan, tx, flags, depend_tx, callback,
 			callback_param);
+		#else
+		BUG();
+		#endif /* CONFIG_HAS_DMA */
 	} else { /* run the memset synchronously */
 		void *dest_buf;
 		pr_debug("%s: (sync) len: %zu\n", __FUNCTION__, len);
diff --git a/async_tx/async_xor.c b/async_tx/async_xor.c
index 37ae5fc..5e4bc29 100644
--- a/async_tx/async_xor.c
+++ b/async_tx/async_xor.c
@@ -31,6 +31,7 @@
 #include <linux/raid/xor.h>
 #include <linux/async_tx.h>
 
+#ifdef CONFIG_HAS_DMA
 static void
 do_async_xor(struct dma_async_tx_descriptor *tx, struct dma_device
*device,
 	struct dma_chan *chan, struct page *dest, struct page
**src_list,
@@ -62,6 +63,17 @@ do_async_xor(struct dma_async_tx_descriptor *tx,
struct dma_device *device,
 	async_tx_submit(chan, tx, flags, depend_tx, callback,
 		callback_param);
 }
+#else
+static void
+do_async_xor(struct dma_async_tx_descriptor *tx, struct dma_device
*device,
+	struct dma_chan *chan, struct page *dest, struct page
**src_list,
+	unsigned int offset, unsigned int src_cnt, size_t len,
+	enum async_tx_flags flags, struct dma_async_tx_descriptor
*depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	BUG();
+}
+#endif /* CONFIG_HAS_DMA */
 
 static void
 do_sync_xor(struct page *dest, struct page **src_list, unsigned int
offset,
@@ -265,6 +277,7 @@ async_xor_zero_sum(struct page *dest, struct page
**src_list,
 	BUG_ON(src_cnt <= 1);
 
 	if (tx) {
+		#ifdef CONFIG_HAS_DMA
 		dma_addr_t dma_addr;
 		enum dma_data_direction dir;
 
@@ -281,6 +294,9 @@ async_xor_zero_sum(struct page *dest, struct page
**src_list,
 
 		async_tx_submit(chan, tx, flags, depend_tx, callback,
 			callback_param);
+		#else
+		BUG();
+		#endif /* CONFIG_HAS_DMA */
 	} else {
 		unsigned long xor_flags = flags;
 
