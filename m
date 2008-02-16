Return-Path: <linux-kernel-owner+w=401wt.eu-S1758484AbYBPOws@vger.kernel.org>
Date: Sat, 16 Feb 2008 15:52:33 +0100 (MET)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 4/4] : More use DIV_ROUND_UP
Message-ID: <Pine.LNX.4.58.0802161552070.1185@pc-041.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

The kernel.h macro DIV_ROUND_UP performs the computation (((n) + (d) - 1) /
(d)) but is perhaps more readable.

An extract of the semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
expression n,d;
@@

(
- (n + d - 1) / d
+ DIV_ROUND_UP(n,d)
|
- (n + (d - 1)) / d
+ DIV_ROUND_UP(n,d)
)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP((n),d)
+ DIV_ROUND_UP(n,d)

@depends on haskernel@
expression n,d;
@@

- DIV_ROUND_UP(n,(d))
+ DIV_ROUND_UP(n,d)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
--- a/drivers/s390/net/claw.c 2008-02-02 15:28:31.000000000 +0100
+++ b/drivers/s390/net/claw.c 2008-02-15 22:29:44.000000000 +0100
@@ -2114,8 +2114,7 @@ init_ccw_bk(struct net_device *dev)
         */
         ccw_blocks_perpage= PAGE_SIZE /  CCWBK_SIZE;
         ccw_pages_required=
-		(ccw_blocks_required+ccw_blocks_perpage -1) /
-			 ccw_blocks_perpage;
+		DIV_ROUND_UP(ccw_blocks_required, ccw_blocks_perpage);

 #ifdef DEBUGMSG
         printk(KERN_INFO "%s: %s() > ccw_blocks_perpage=%d\n",
@@ -2133,12 +2132,12 @@ init_ccw_bk(struct net_device *dev)
          */
         if (privptr->p_env->read_size < PAGE_SIZE) {
             claw_reads_perpage= PAGE_SIZE / privptr->p_env->read_size;
-            claw_read_pages= (privptr->p_env->read_buffers +
-	    	claw_reads_perpage -1) / claw_reads_perpage;
+	     claw_read_pages=
+		DIV_ROUND_UP(privptr->p_env->read_buffers, claw_reads_perpage);
          }
          else {       /* > or equal  */
             privptr->p_buff_pages_perread=
-	    	(privptr->p_env->read_size + PAGE_SIZE - 1) / PAGE_SIZE;
+		DIV_ROUND_UP(privptr->p_env->read_size, PAGE_SIZE);
             claw_read_pages=
 	    	privptr->p_env->read_buffers * privptr->p_buff_pages_perread;
          }
@@ -2146,13 +2145,13 @@ init_ccw_bk(struct net_device *dev)
             claw_writes_perpage=
 	    	PAGE_SIZE / privptr->p_env->write_size;
             claw_write_pages=
-	    	(privptr->p_env->write_buffers + claw_writes_perpage -1) /
-			claw_writes_perpage;
+		DIV_ROUND_UP(privptr->p_env->write_buffers,
+			     claw_writes_perpage);

         }
         else {      /* >  or equal  */
             privptr->p_buff_pages_perwrite=
-	    	 (privptr->p_env->read_size + PAGE_SIZE - 1) / PAGE_SIZE;
+		DIV_ROUND_UP(privptr->p_env->read_size, PAGE_SIZE);
             claw_write_pages=
 	     	privptr->p_env->write_buffers * privptr->p_buff_pages_perwrite;
         }
