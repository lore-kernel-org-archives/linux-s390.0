Return-Path: <linux-arch-owner@vger.kernel.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH v4 1/2] mm: Introducing arch_remap hook
Date: Thu, 26 Mar 2015 18:37:52 +0100
Message-ID: <fe0cafd7f98ce8cdd4b695de55a8c22dd903e334.1427390952.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
References: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
References: <20150326141730.GA23060@gmail.com> <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20150326173752.qL-bLPdFIaHBhQcNA_UWgSDTA-eqEfpunbSYoRuv8x8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>

Some architecture would like to be triggered when a memory area is moved
through the mremap system call.

This patch is introducing a new arch_remap mm hook which is placed in the
path of mremap, and is called before the old area is unmapped (and the
arch_unmap hook is called).

The architectures which need to call this hook should define
__HAVE_ARCH_REMAP in their asm/mmu_context.h and provide the arch_remap
service with the following prototype:
void arch_remap(struct mm_struct *mm,
                unsigned long old_start, unsigned long old_end,
                unsigned long new_start, unsigned long new_end);

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/mremap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 57dadc025c64..bafc234db45c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -25,6 +25,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 
 #include "internal.h"
 
@@ -286,8 +287,14 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
-	} else if (vma->vm_file && vma->vm_file->f_op->mremap)
-		vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
+	} else {
+		if (vma->vm_file && vma->vm_file->f_op->mremap)
+			vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
+#ifdef __HAVE_ARCH_REMAP
+		arch_remap(mm, old_addr, old_addr+old_len,
+			   new_addr, new_addr+new_len);
+#endif
+	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */
 	if (vm_flags & VM_ACCOUNT) {
-- 
1.9.1
