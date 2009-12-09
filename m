Return-Path: <linux-kernel-owner+w=401wt.eu-S1757452AbZLITYk@vger.kernel.org>
Date: Wed, 9 Dec 2009 20:24:28 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 7/12] drivers/s390: Correct size given to memset
Message-ID: <Pine.LNX.4.64.0912092024100.1870@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

Memset should be given the size of the structure, not the size of the pointer.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
T *x;
expression E;
@@

memset(x, E, sizeof(
+ *
 x))
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/s390/cio/fcx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/s390/cio/fcx.c b/drivers/s390/cio/fcx.c
--- a/drivers/s390/cio/fcx.c
+++ b/drivers/s390/cio/fcx.c
@@ -163,7 +163,7 @@ void tcw_finalize(struct tcw *tcw, int n
 	/* Add tcat to tccb. */
 	tccb = tcw_get_tccb(tcw);
 	tcat = (struct tccb_tcat *) &tccb->tca[tca_size(tccb)];
-	memset(tcat, 0, sizeof(tcat));
+	memset(tcat, 0, sizeof(*tcat));
 	/* Calculate tcw input/output count and tcat transport count. */
 	count = calc_dcw_count(tccb);
 	if (tcw->w && (tcw->flags & TCW_FLAGS_OUTPUT_TIDA))
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(tccb_init);
  */
 void tsb_init(struct tsb *tsb)
 {
-	memset(tsb, 0, sizeof(tsb));
+	memset(tsb, 0, sizeof(*tsb));
 }
 EXPORT_SYMBOL(tsb_init);
 
