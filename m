Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Mar 2010 17:33:52 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 2/12] arch/s390/kernel: Add missing unlock
Message-ID: <Pine.LNX.4.64.1003291733350.21896@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julia Lawall <julia@diku.dk>

In the default case the lock is not unlocked.  The return is
converted to a goto, to share the unlock at the end of the function.

A simplified version of the semantic patch that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression E1;
identifier f;
@@

f (...) { <+...
* spin_lock_irq (E1,...);
... when != E1
* return ...;
...+> }
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/s390/kernel/topology.c         |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 14ef6f0..247b4c2 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -165,10 +165,11 @@ static void tl_to_cores(struct tl_info *info)
 		default:
 			clear_cores();
 			machine_has_topology = 0;
-			return;
+			goto out;
 		}
 		tle = next_tle(tle);
 	}
+out:
 	spin_unlock_irq(&topology_lock);
 }
 
