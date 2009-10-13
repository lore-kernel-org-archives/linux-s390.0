From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [BUILD-FAILURE] next-20091013 - s390x build breaks at mm/fault
	with !CONFIG_S390_EXEC_PROTECT
Date: Tue, 13 Oct 2009 15:36:48 +0530
Message-ID: <20091013100648.GA7542@linux.vnet.ibm.com>
References: <20091013162312.8b93998b.sfr@canb.auug.org.au>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091013162312.8b93998b.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Martin,

	next-20091013 randconfig build breaks on s390, with
CONFIG_S390_EXEC_PROTECT=y

arch/s390/mm/fault.c: In function 'signal_return':
arch/s390/mm/fault.c:221: error: implicit declaration of function 'is_compat_task'
make[1]: *** [arch/s390/mm/fault.o] Error 1

is_compat_task is defined at asm/compat.h, including the 
header, helps

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
--
 arch/s390/mm/fault.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 43b3778..4e73e8b 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
 #include <asm/mmu_context.h>
+#include <asm/compat.h>
 #include "../kernel/entry.h"
 
 #ifndef CONFIG_64BIT

			
			Kamalesh
