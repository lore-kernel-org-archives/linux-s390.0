From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/4] smc: allocate RMBs as compound pages
Date: Thu,  3 May 2018 18:12:38 +0200
Message-ID: <20180503161239.71747-4-ubraun@linux.ibm.com>
References: <20180503161239.71747-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180503161239.71747-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <stefan.raspl@linux.ibm.com>

Preparatory work for splice() support.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com><
---
 net/smc/smc_core.c | 18 +++++++++---------
 net/smc/smc_core.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 1f3ea62fac5c..4051fb504393 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -274,8 +274,8 @@ static void smc_buf_free(struct smc_buf_desc *buf_desc, struct smc_link *lnk,
 				    DMA_TO_DEVICE);
 	}
 	sg_free_table(&buf_desc->sgt[SMC_SINGLE_LINK]);
-	if (buf_desc->cpu_addr)
-		free_pages((unsigned long)buf_desc->cpu_addr, buf_desc->order);
+	if (buf_desc->pages)
+		__free_pages(buf_desc->pages, buf_desc->order);
 	kfree(buf_desc);
 }
 
@@ -550,16 +550,16 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 	if (!buf_desc)
 		return ERR_PTR(-ENOMEM);
 
-	buf_desc->cpu_addr =
-		(void *)__get_free_pages(GFP_KERNEL | __GFP_NOWARN |
-					 __GFP_NOMEMALLOC |
-					 __GFP_NORETRY | __GFP_ZERO,
-					 get_order(bufsize));
-	if (!buf_desc->cpu_addr) {
+	buf_desc->order = get_order(bufsize);
+	buf_desc->pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
+				      __GFP_NOMEMALLOC | __GFP_COMP |
+				      __GFP_NORETRY | __GFP_ZERO,
+				      buf_desc->order);
+	if (!buf_desc->pages) {
 		kfree(buf_desc);
 		return ERR_PTR(-EAGAIN);
 	}
-	buf_desc->order = get_order(bufsize);
+	buf_desc->cpu_addr = (void *)page_address(buf_desc->pages);
 
 	/* build the sg table from the pages */
 	lnk = &lgr->lnk[SMC_SINGLE_LINK];
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 97339f03ba79..cdf800f1fae7 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -120,6 +120,7 @@ struct smc_link {
 struct smc_buf_desc {
 	struct list_head	list;
 	void			*cpu_addr;	/* virtual address of buffer */
+	struct page		*pages;
 	struct sg_table		sgt[SMC_LINKS_PER_LGR_MAX];/* virtual buffer */
 	struct ib_mr		*mr_rx[SMC_LINKS_PER_LGR_MAX];
 						/* for rmb only: memory region
-- 
2.13.5
