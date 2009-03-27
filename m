From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Next March 27 : s390 defconfig build failure
Date: Fri, 27 Mar 2009 15:40:27 +0100
Message-ID: <20090327154027.55afeb02@osiris.boeblingen.de.ibm.com>
References: <20090327231924.4e4168c5.sfr@canb.auug.org.au>
	<49CCDB30.7010203@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49CCDB30.7010203@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>, Ingo Molnar <mingo@elte.hu>
Cc: linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 27 Mar 2009 19:27:04 +0530
Sachin Sant <sachinp@in.ibm.com> wrote:

> Today's Next defconfig s390 build failed with
> 
> arch/s390/hypfs/hypfs_diag.c: In function diag204_free_buffer:
> arch/s390/hypfs/hypfs_diag.c:364: error: implicit declaration of function free_pages
> arch/s390/hypfs/hypfs_diag.c: In function diag204_alloc_rbuf:
> arch/s390/hypfs/hypfs_diag.c:384: error: implicit declaration of function __get_free_pages
> arch/s390/hypfs/hypfs_diag.c:384: error: GFP_KERNEL undeclared (first use in this function)

Thanks for reporting. Ingo, could you pick up the patch below please?

Subject: [PATCH] s390/hypfs: fix build breakage

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix build breakage below which probably was introduced with
("rcu: don't include unnecessary headers, allow kmemtrace w/ tracepoints").

  CC      arch/s390/hypfs/hypfs_diag.o
arch/s390/hypfs/hypfs_diag.c: In function 'diag204_free_buffer':
arch/s390/hypfs/hypfs_diag.c:364: error: implicit declaration of function 'free_pages'
arch/s390/hypfs/hypfs_diag.c: In function 'diag204_alloc_rbuf':
arch/s390/hypfs/hypfs_diag.c:384: error: implicit declaration of function '__get_free_pages'
arch/s390/hypfs/hypfs_diag.c:384: error: 'GFP_KERNEL' undeclared (first use in this function)
arch/s390/hypfs/hypfs_diag.c:384: error: (Each undeclared identifier is reported only once
arch/s390/hypfs/hypfs_diag.c:384: error: for each function it appears in.)

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/hypfs/hypfs_diag.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-next/arch/s390/hypfs/hypfs_diag.c
===================================================================
--- linux-next.orig/arch/s390/hypfs/hypfs_diag.c
+++ linux-next/arch/s390/hypfs/hypfs_diag.c
@@ -12,6 +12,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <asm/ebcdic.h>
