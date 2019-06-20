Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45045 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFM0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Jun 2019 01:12:26 -0400
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH RESEND 7/8] x86: Use mmap_*base, not mmap_*legacy_base, as low_limit for bottom-up mmap
Date: Thu, 20 Jun 2019 01:03:27 -0400
Message-Id: <20190620050328.8942-8-alex@ghiti.fr>
In-Reply-To: <20190620050328.8942-1-alex@ghiti.fr>
References: <20190620050328.8942-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>

Bottom-up mmap scheme is used twice:

- for legacy mode, in which mmap_legacy_base and mmap_compat_legacy_base
are respectively equal to mmap_base and mmap_compat_base.

- in case of mmap failure in top-down mode, where there is no need to go
through the whole address space again for the bottom-up fallback: the goal
of this fallback is to find, as a last resort, space between the top-down
mmap base and the stack, which is the only place not covered by the
top-down mmap.

Then this commit removes the usage of mmap_legacy_base and
mmap_compat_legacy_base fields from x86 code.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/x86/include/asm/elf.h   |  2 +-
 arch/x86/kernel/sys_x86_64.c |  4 ++--
 arch/x86/mm/hugetlbpage.c    |  4 ++--
 arch/x86/mm/mmap.c           | 20 +++++++++-----------
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..bbfd81453250 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -307,7 +307,7 @@ static inline int mmap_is_ia32(void)
 
 extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
-extern unsigned long get_mmap_base(int is_legacy);
+extern unsigned long get_mmap_base(void);
 extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index f7476ce23b6e..0bf8604bea5e 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -121,7 +121,7 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 		return;
 	}
 
-	*begin	= get_mmap_base(1);
+	*begin	= get_mmap_base();
 	if (in_32bit_syscall())
 		*end = task_size_32bit();
 	else
@@ -211,7 +211,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
-	info.high_limit = get_mmap_base(0);
+	info.high_limit = get_mmap_base();
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 4b90339aef50..3a7f11e66114 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -86,7 +86,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = get_mmap_base(1);
+	info.low_limit = get_mmap_base();
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -106,7 +106,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 {
 	struct hstate *h = hstate_file(file);
 	struct vm_unmapped_area_info info;
-	unsigned long mmap_base = get_mmap_base(0);
+	unsigned long mmap_base = get_mmap_base();
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index aae9a933dfd4..54c9ff301323 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -113,13 +113,12 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
+static void arch_pick_mmap_base(unsigned long *base,
 		unsigned long random_factor, unsigned long task_size,
 		struct rlimit *rlim_stack)
 {
-	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
-		*base = *legacy_base;
+		*base = mmap_legacy_base(random_factor, task_size);
 	else
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
@@ -131,7 +130,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	else
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 
-	arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
+	arch_pick_mmap_base(&mm->mmap_base,
 			arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
 			rlim_stack);
 
@@ -142,23 +141,22 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	 * applications and 32bit applications. The 64bit syscall uses
 	 * mmap_base, the compat syscall uses mmap_compat_base.
 	 */
-	arch_pick_mmap_base(&mm->mmap_compat_base, &mm->mmap_compat_legacy_base,
+	arch_pick_mmap_base(&mm->mmap_compat_base,
 			arch_rnd(mmap32_rnd_bits), task_size_32bit(),
 			rlim_stack);
 #endif
 }
 
-unsigned long get_mmap_base(int is_legacy)
+unsigned long get_mmap_base(void)
 {
 	struct mm_struct *mm = current->mm;
 
 #ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
-	if (in_32bit_syscall()) {
-		return is_legacy ? mm->mmap_compat_legacy_base
-				 : mm->mmap_compat_base;
-	}
+	if (in_32bit_syscall())
+		return mm->mmap_compat_base;
 #endif
-	return is_legacy ? mm->mmap_legacy_base : mm->mmap_base;
+
+	return mm->mmap_base;
 }
 
 const char *arch_vma_name(struct vm_area_struct *vma)
-- 
2.20.1
