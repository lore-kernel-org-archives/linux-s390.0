Return-Path: <linux-kernel-owner+w=401wt.eu-S1754854AbYJUGMs@vger.kernel.org>
Date: Tue, 21 Oct 2008 08:12:19 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] Fix page_cgroup build breakage
Message-ID: <20081021061219.GA4980@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Subject: [PATCH] Fix page_cgroup build breakage

From: Heiko Carstens <heiko.carstens@de.ibm.com>

On s390 I get this:

  CC      mm/page_cgroup.o
mm/page_cgroup.c: In function 'init_section_page_cgroup':
mm/page_cgroup.c:111: error: implicit declaration of function 'vmalloc_node'
mm/page_cgroup.c:111: warning: assignment makes pointer from integer without a cast
mm/page_cgroup.c: In function '__free_page_cgroup':
mm/page_cgroup.c:140: error: implicit declaration of function 'vfree'
make[1]: *** [mm/page_cgroup.o] Error 1
make: *** [mm] Error 2

caused by 52d4b9ac0b985168009c2a57098324e67bae171f
("memcg: allocate all page_cgroup at boot")

Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 mm/page_cgroup.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/mm/page_cgroup.c
===================================================================
--- linux-2.6.orig/mm/page_cgroup.c
+++ linux-2.6/mm/page_cgroup.c
@@ -3,6 +3,7 @@
 #include <linux/bootmem.h>
 #include <linux/bit_spinlock.h>
 #include <linux/page_cgroup.h>
+#include <linux/vmalloc.h>
 #include <linux/hash.h>
 #include <linux/memory.h>
 
