From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 0/3] Optimize CONFIG_DEBUG_PAGEALLOC
Date: Wed, 27 Jan 2016 11:09:58 +0100
Message-ID: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Andrew, since the arch patches depend on the base patch, maybe the mm
tree is the right one? I have acks/reviews for the s390/x86 part.


As CONFIG_DEBUG_PAGEALLOC can be enabled/disabled via kernel
parameters we can optimize some cases by checking the enablement
state.

I have done s390 and x86 as examples.
s390 should be ok, I tested several combinations, x86 seems to
work as well.

Power can probably do the same, Michael/Ben?
I am not sure about sparc. Sparc seems to allocate the TSB buffer
really early. David?


V2->V3:
- Fix whitespace/indent breakage in s390 patch
V1->V2:
- replace DEBUG_PAGEALLOC(disabled/enabled) with DEBUG_PAGEALLOC
  dump_stack for s390/x86
- add /* CONFIG_DEBUG_PAGEALLOC */ to else and endif


Christian Borntraeger (3):
  mm: provide debug_pagealloc_enabled() without CONFIG_DEBUG_PAGEALLOC
  x86: query dynamic DEBUG_PAGEALLOC setting
  s390: query dynamic DEBUG_PAGEALLOC setting

 arch/s390/kernel/dumpstack.c |  6 +++---
 arch/s390/mm/vmem.c          | 10 ++++------
 arch/x86/kernel/dumpstack.c  |  5 ++---
 arch/x86/mm/init.c           |  7 ++++---
 arch/x86/mm/pageattr.c       | 14 ++++----------
 include/linux/mm.h           |  9 +++++++--
 6 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.3.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
