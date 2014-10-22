From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] mm: new function to forbid zeropage mappings for a process
Date: Wed, 22 Oct 2014 13:09:26 +0200
Message-ID: <1413976170-42501-1-git-send-email-dingel@linux.vnet.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Bob Liu <lliubbo@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Jianyu Zhan <nasa4836@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, kvm@vger.kernel.org, linux390@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Sasha Levin <sasha.levi>
List-ID: <linux-s390.vger.kernel.org>

s390 has the special notion of storage keys which are some sort of page flags
associated with physical pages and live outside of direct addressable memory.
These storage keys can be queried and changed with a special set of instructions.
The mentioned instructions behave quite nicely under virtualization, if there is: 
- an invalid pte, then the instructions will work on memory in the host page table
- a valid pte, then the instructions will work with the real storage key

Thanks to Martin with his software reference and dirty bit tracking,
the kernel does not issue any storage key instructions as now a 
software based approach will be taken, on the other hand distributions 
in the wild are currently using them.

However, for virtualized guests we still have a problem with guest pages 
mapped to zero pages and the kernel same page merging.  
With each one multiple guest pages will point to the same physical page
and share the same storage key.

Let's fix this by introducing a new function which s390 will define to
forbid new zero page mappings.  If the guest issues a storage key related 
instruction we flag the mm_struct, drop existing zero page mappings
and unmerge the guest memory.

v2 -> v3:
 - Clearing up patch description Patch 3/4
 - removing unnecessary flag in mmu_context (Paolo)

v1 -> v2: 
 - Following Dave and Paolo suggestion removing the vma flag

Dominik Dingel (4):
  s390/mm: recfactor global pgste updates
  mm: introduce mm_forbids_zeropage function
  s390/mm: prevent and break zero page mappings in case of storage keys
  s390/mm: disable KSM for storage key enabled pages

 arch/s390/include/asm/pgalloc.h |   2 -
 arch/s390/include/asm/pgtable.h |   8 +-
 arch/s390/kvm/kvm-s390.c        |   2 +-
 arch/s390/kvm/priv.c            |  17 ++--
 arch/s390/mm/pgtable.c          | 180 ++++++++++++++++++----------------------
 include/linux/mm.h              |   4 +
 mm/huge_memory.c                |   2 +-
 mm/memory.c                     |   2 +-
 8 files changed, 106 insertions(+), 111 deletions(-)

-- 
1.8.5.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
