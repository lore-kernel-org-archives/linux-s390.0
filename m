From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Next April 15: s390 allnoconfig build failure
Date: Wed, 15 Apr 2009 10:35:57 +0200
Message-ID: <20090415103557.0b313e35@osiris.boeblingen.de.ibm.com>
References: <20090415144745.c4fb5c4b.sfr@canb.auug.org.au>
	<49E58211.6040900@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758508AbZDOIgZ@vger.kernel.org>
In-Reply-To: <49E58211.6040900@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Apr 2009 12:13:29 +0530
Sachin Sant <sachinp@in.ibm.com> wrote:

> Today's next tree build (s390 allnoconfig) failed with
> 
> arch/s390/kernel/ipl.c: In function 'stop_run':
> arch/s390/kernel/ipl.c:1461: error: implicit declaration of function 
> 'signal_processor'
> arch/s390/kernel/ipl.c:1461: error: 'sigp_stop' undeclared (first use in 
> this function)
> arch/s390/kernel/ipl.c:1461: error: (Each undeclared identifier is 
> reported only once
> arch/s390/kernel/ipl.c:1461: error: for each function it appears in.)
> make[1]: *** [arch/s390/kernel/ipl.o] Error 1

Patch below will fix it. Thanks for reporting.

Subject: [PATCH] ipl: fix compile breakage

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix this for !CONFIG_SMP:

arch/s390/kernel/ipl.c: In function 'stop_run':
arch/s390/kernel/ipl.c:1461: error: implicit declaration of function 'signal_processor'

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diff -u -r1.67 -r1.68 linux-2.5/arch/s390/kernel/ipl.c
--- linux-2.5/arch/s390/kernel/ipl.c	24 Mar 2009 11:33:16 -0000	1.67
+++ linux-2.5/arch/s390/kernel/ipl.c	15 Apr 2009 08:33:38 -0000	1.68
@@ -23,6 +23,7 @@
 #include <asm/ebcdic.h>
 #include <asm/reset.h>
 #include <asm/sclp.h>
+#include <asm/sigp.h>
 #include <asm/checksum.h>

 #define IPL_PARM_BLOCK_VERSION 0
