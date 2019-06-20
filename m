Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40273 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFLX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Jun 2019 01:11:23 -0400
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH RESEND 6/8] parisc: Use mmap_base, not mmap_legacy_base, as low_limit for bottom-up mmap
Date: Thu, 20 Jun 2019 01:03:26 -0400
Message-Id: <20190620050328.8942-7-alex@ghiti.fr>
In-Reply-To: <20190620050328.8942-1-alex@ghiti.fr>
References: <20190620050328.8942-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>

Bottom-up mmap scheme is used twice:

- for legacy mode, in which mmap_legacy_base and mmap_base are equal.

- in case of mmap failure in top-down mode, where there is no need to go
through the whole address space again for the bottom-up fallback: the goal
of this fallback is to find, as a last resort, space between the top-down
mmap base and the stack, which is the only place not covered by the
top-down mmap.

Then this commit removes the usage of mmap_legacy_base field from parisc
code.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/parisc/kernel/sys_parisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 5d458a44b09c..e987f3a8eb0b 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -119,7 +119,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = mm->mmap_legacy_base;
+	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_upper_limit(NULL);
 	info.align_mask = last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
 	info.align_offset = shared_align_offset(last_mmap, pgoff);
@@ -240,13 +240,11 @@ static unsigned long mmap_legacy_base(void)
  */
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
-	mm->mmap_legacy_base = mmap_legacy_base();
-	mm->mmap_base = mmap_upper_limit(rlim_stack);
-
 	if (mmap_is_legacy()) {
-		mm->mmap_base = mm->mmap_legacy_base;
+		mm->mmap_base = mmap_legacy_base();
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
+		mm->mmap_base = mmap_upper_limit(rlim_stack);
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-- 
2.20.1
