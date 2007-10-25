Return-Path: <linux-arch-owner@vger.kernel.org>
Message-Id: <20071025181520.880272069@de.ibm.com>
Date: Thu, 25 Oct 2007 20:15:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] s390 page tables on steroids ..
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, benh@kernel.crashing.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
this patch series of six patches contains three mm related changes
for the s390 architecture:
i) 1K/2K page tables. With this patch set the cheating with the
   pmd_t on s390 stops. So far a pmd contained 2/4 pointers instead
   of just one which would be correct from an architectural stand
   point. The Trouble with this is that it requires two common code
   changes to make sub-page page tables possible. This features
   is an important requirement for the kvm support on s390.
ii) Support for 4 levels of page tables. The address space limit for
   64 bit processes is now 2^53. That should be enough for anyone ?
iii) Support for different number of page table levels. The limit
   of 2^53 is nice but it slows down the tlb lookup that now has
   to walk 4 instead of 3 levels. Patch #5 make the number of page
   table levels dependent on the highest address a process is using.
   If an mmap is done that raises the limit to the next level, the
   page table gets another level. A downgrade is only done at process
   start, so that 31 bit processes get a two level page table. A
   normal 64 bit process starts with three levels.

The first three patches in the series contain the common code changes
that are needed to get all of this done. I did my best to find all the
place in the different architectures that need to be updated after the
common code changed. Please let me know if you find a place I missed.

The patches are against Linus's git tree.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
