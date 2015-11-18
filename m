Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Allow gmap fault to retry 
Date: Thu, 19 Nov 2015 00:49:56 +0100
Message-Id: <1447890598-56860-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-s390@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, Eric B Munson <emunson@akamai.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mel Gorman <mgorman@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello,

during Jasons work with postcopy migration support for s390 a problem regarding
gmap faults was discovered.

The gmap code will call fixup_userfault which will end up always in
handle_mm_fault. Till now we never cared about retries, but as the userfaultfd
code kind of relies on it, this needed some fix. This patchset includes the
retry logic fory gmap fault scenarios, as well as passing back VM_FAULT_RETRY
from fixup_userfault.

Thanks,
    Dominik

Dominik Dingel (2):
  mm: fixup_userfault returns VM_FAULT_RETRY if asked
  s390/mm: allow gmap code to retry on faulting in guest memory

 arch/s390/mm/pgtable.c | 28 ++++++++++++++++++++++++----
 mm/gup.c               |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.3.9

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
