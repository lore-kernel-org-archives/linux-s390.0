Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43689 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSFNA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Jun 2019 01:13:00 -0400
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 3/8] sparc: Start fallback of top-down mmap at mm->mmap_base
Date: Wed, 19 Jun 2019 01:08:39 -0400
Message-Id: <20190619050844.5294-4-alex@ghiti.fr>
In-Reply-To: <20190619050844.5294-1-alex@ghiti.fr>
References: <20190619050844.5294-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>

In case of mmap failure in top-down mode, there is no need to go through
the whole address space again for the bottom-up fallback: the goal of this
fallback is to find, as a last resort, space between the top-down mmap base
and the stack, which is the only place not covered by the top-down mmap.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 arch/sparc/mm/hugetlbpage.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index ccc88926bc00..ea1de1e5fa8d 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -206,7 +206,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr & ~PAGE_MASK) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = mm->mmap_base;
 		info.high_limit = STACK_TOP32;
 		addr = vm_unmapped_area(&info);
 	}
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index f78793a06bbd..9c67f805abc8 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -86,7 +86,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr & ~PAGE_MASK) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = mm->mmap_base;
 		info.high_limit = STACK_TOP32;
 		addr = vm_unmapped_area(&info);
 	}
-- 
2.20.1
