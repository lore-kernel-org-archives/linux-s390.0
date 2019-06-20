Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51937 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFNa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Jun 2019 01:13:30 -0400
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH RESEND 8/8] mm: Remove mmap_legacy_base and mmap_compat_legacy_code fields from mm_struct
Date: Thu, 20 Jun 2019 01:03:28 -0400
Message-Id: <20190620050328.8942-9-alex@ghiti.fr>
In-Reply-To: <20190620050328.8942-1-alex@ghiti.fr>
References: <20190620050328.8942-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>

Now that x86 and parisc do not use those fields anymore, remove them from
mm code.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/mm_types.h | 2 --
 mm/debug.c               | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1d1093474c1a..9a5935f9cc7e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -364,11 +364,9 @@ struct mm_struct {
 				unsigned long pgoff, unsigned long flags);
 #endif
 		unsigned long mmap_base;	/* base of mmap area */
-		unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
 #ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
 		/* Base adresses for compatible mmap() */
 		unsigned long mmap_compat_base;
-		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
 		unsigned long highest_vm_end;	/* highest vma end address */
diff --git a/mm/debug.c b/mm/debug.c
index 8345bb6e4769..3ddffe1efcda 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -134,7 +134,7 @@ void dump_mm(const struct mm_struct *mm)
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu highest_vm_end %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -162,7 +162,7 @@ void dump_mm(const struct mm_struct *mm)
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->highest_vm_end,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
-- 
2.20.1
