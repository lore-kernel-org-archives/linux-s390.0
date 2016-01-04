Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] Allow gmap fault to retry
Date: Mon,  4 Jan 2016 12:19:53 +0100
Message-Id: <1451906395-80878-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Eric B Munson <emunson@akamai.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mel Gorman <mgorman@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello,

sorry for the delay since the last version.

During Jasons work with postcopy migration support for s390 a problem regarding
gmap faults was discovered.

The gmap code will call fixup_user_fault which will end up always in
handle_mm_fault. Till now we never cared about retries, but as the userfaultfd
code kind of relies on it. this needs some fix.

This patchset does not take care of the futex code. I will now look closer at
this.

Thanks,
    Dominik

v2 -> v3:
- In case of retrying check vma again
- Do the accounting of major/minor faults once

v1 -> v2:
- Instread of passing the VM_FAULT_RETRY from fixup_user_fault we do retries
  within fixup_user_fault, like get_user_pages_locked do.
- gmap code will now take retry if fixup_user_fault drops the lock.

Dominik Dingel (2):
  mm: bring in additional flag for fixup_user_fault to signal unlock
  s390/mm: enable fixup_user_fault retrying

 arch/s390/mm/pgtable.c | 31 ++++++++++++++++++++++++++++---
 include/linux/mm.h     |  5 +++--
 kernel/futex.c         |  2 +-
 mm/gup.c               | 30 +++++++++++++++++++++++++-----
 4 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.3.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
