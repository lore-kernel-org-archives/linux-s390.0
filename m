Return-Path: <linux-kernel-owner+w=401wt.eu-S1762219AbXEJN5o@vger.kernel.org>
Message-Id: <20070510135643.590801026@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/15] monreader inlining cleanup.
Content-Disposition: inline; filename=004-inline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monreader.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: quilt-2.6/drivers/s390/char/monreader.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monreader.c
+++ quilt-2.6/drivers/s390/char/monreader.c
@@ -97,7 +97,7 @@ static u8 user_data_sever[16] = {
  * Create the 8 bytes EBCDIC DCSS segment name from
  * an ASCII name, incl. padding
  */
-static inline void dcss_mkname(char *ascii_name, char *ebcdic_name)
+static void dcss_mkname(char *ascii_name, char *ebcdic_name)
 {
 	int i;
 
@@ -191,7 +191,7 @@ static inline u32 mon_rec_end(struct mon
 	return *((u32 *) (mon_mca_start(monmsg) + monmsg->mca_offset + 8));
 }
 
-static inline int mon_check_mca(struct mon_msg *monmsg)
+static int mon_check_mca(struct mon_msg *monmsg)
 {
 	if ((mon_rec_end(monmsg) <= mon_rec_start(monmsg)) ||
 	    (mon_rec_start(monmsg) < mon_dcss_start) ||
@@ -209,8 +209,8 @@ static inline int mon_check_mca(struct m
 	return 0;
 }
 
-static inline int mon_send_reply(struct mon_msg *monmsg,
-				 struct mon_private *monpriv)
+static int mon_send_reply(struct mon_msg *monmsg,
+			  struct mon_private *monpriv)
 {
 	int rc;
 
@@ -236,7 +236,7 @@ static inline int mon_send_reply(struct 
 	return 0;
 }
 
-static inline void mon_free_mem(struct mon_private *monpriv)
+static void mon_free_mem(struct mon_private *monpriv)
 {
 	int i;
 
@@ -246,7 +246,7 @@ static inline void mon_free_mem(struct m
 	kfree(monpriv);
 }
 
-static inline struct mon_private *mon_alloc_mem(void)
+static struct mon_private *mon_alloc_mem(void)
 {
 	int i;
 	struct mon_private *monpriv;
@@ -307,7 +307,7 @@ static inline void mon_next_mca(struct m
 	monmsg->pos = 0;
 }
 
-static inline struct mon_msg *mon_next_message(struct mon_private *monpriv)
+static struct mon_msg *mon_next_message(struct mon_private *monpriv)
 {
 	struct mon_msg *monmsg;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
