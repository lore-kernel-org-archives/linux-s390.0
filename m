From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: linux-next: 20090925 - build breaks with !CONFIG_AIO
Date: Fri, 25 Sep 2009 18:49:58 +0530
Message-ID: <20090925131958.GC6831@linux.vnet.ibm.com>
References: <20090925133830.1ba29584.sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751999AbZIYNUD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090925133830.1ba29584.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, adobriyan@gmail.com
List-ID: <linux-s390.vger.kernel.org>

Hi Stephen,

	next-20090925 randconfig build breaks on s390x, with CONFIG_AIO=n.

arch/s390/mm/pgtable.c: In function 's390_enable_sie':
arch/s390/mm/pgtable.c:282: error: 'struct mm_struct' has no member named 'ioctx_list'
arch/s390/mm/pgtable.c:298: error: 'struct mm_struct' has no member named 'ioctx_list'
make[1]: *** [arch/s390/mm/pgtable.o] Error 1

Reverting the below commit helps

commit 858f09930b32c11b40fd0c5c467982ba09b10894
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Sep 23 15:57:32 2009 -0700

    aio: ifdef fields in mm_struct

	->ioctx_lock and ->ioctx_list are used only under CONFIG_AIO.
			    

			Kamalesh
