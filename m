Return-Path: <linux-kernel-owner+w=401wt.eu-S1758628AbYFXI0S@vger.kernel.org>
Date: Tue, 24 Jun 2008 10:25:54 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 11/14] drivers/s390: Eliminate NULL test and memset after
 alloc_bootmem
Message-ID: <Pine.LNX.4.64.0806241025280.26777@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akinobu.mita@gmail.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

As noted by Akinobu Mita in patch b1fceac2b9e04d278316b2faddf276015fc06e3b,
alloc_bootmem and related functions never return NULL and always return a
zeroed region of memory.  Thus a NULL test or memset after calls to these
functions is unnecessary.

 drivers/s390/char/raw3270.c  |   11 +----------
 drivers/s390/char/sclp_con.c |    2 --
 2 files changed, 1 insertion(+), 12 deletions(-)

This was fixed using the following semantic patch.
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression E;
statement S;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
(
- BUG_ON (E == NULL);
|
- if (E == NULL) S
)

@@
expression E,E1;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\)(...)
... when != E
- memset(E,0,E1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---

diff -u -p a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -153,19 +153,10 @@ struct raw3270_request __init *raw3270_r
 	struct raw3270_request *rq;
 
 	rq = alloc_bootmem_low(sizeof(struct raw3270));
-	if (!rq)
-		return ERR_PTR(-ENOMEM);
-	memset(rq, 0, sizeof(struct raw3270_request));
 
 	/* alloc output buffer. */
-	if (size > 0) {
+	if (size > 0)
 		rq->buffer = alloc_bootmem_low(size);
-		if (!rq->buffer) {
-			free_bootmem((unsigned long) rq,
-				     sizeof(struct raw3270));
-			return ERR_PTR(-ENOMEM);
-		}
-	}
 	rq->size = size;
 	INIT_LIST_HEAD(&rq->list);
 
diff -u -p a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -222,8 +222,6 @@ sclp_console_init(void)
 	INIT_LIST_HEAD(&sclp_con_pages);
 	for (i = 0; i < MAX_CONSOLE_PAGES; i++) {
 		page = alloc_bootmem_low_pages(PAGE_SIZE);
-		if (page == NULL)
-			return -ENOMEM;
 		list_add_tail((struct list_head *) page, &sclp_con_pages);
 	}
 	INIT_LIST_HEAD(&sclp_con_outqueue);
