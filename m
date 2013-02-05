Return-Path: <owner-linux-mm@kvack.org>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] software dirty bits for s390
Date: Tue,  5 Feb 2013 10:12:04 -0800
Message-Id: <1360087925-8456-2-git-send-email-schwidefsky@de.ibm.com>
In-Reply-To: <1360087925-8456-1-git-send-email-schwidefsky@de.ibm.com>
References: <1360087925-8456-1-git-send-email-schwidefsky@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org, linux-s390@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,

good news, I got performance results for a selected set of workloads
with my software dirty bit patch (thanks Christian!). We found no
downsides to the software dirty bits, and a substantial improvement
in CPU utilization for the FIO test with mostly read mappings.

The patch can now go upstream.

Martin Schwidefsky (1):
  s390/mm: implement software dirty bits

 arch/s390/include/asm/page.h    |   22 -------
 arch/s390/include/asm/pgtable.h |  131 ++++++++++++++++++++++++++-------------
 arch/s390/include/asm/sclp.h    |    1 -
 arch/s390/include/asm/setup.h   |   16 ++---
 arch/s390/kvm/kvm-s390.c        |    2 +-
 arch/s390/lib/uaccess_pt.c      |    2 +-
 arch/s390/mm/pageattr.c         |    2 +-
 arch/s390/mm/vmem.c             |   24 +++----
 drivers/s390/char/sclp_cmd.c    |   10 +--
 include/asm-generic/pgtable.h   |   10 ---
 include/linux/page-flags.h      |    8 ---
 mm/rmap.c                       |   24 -------
 12 files changed, 112 insertions(+), 140 deletions(-)

-- 
1.7.9.5

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
