Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:59600 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETS3g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 May 2020 14:29:36 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 0/7] padata: parallelize deferred page init
Date: Wed, 20 May 2020 14:26:38 -0400
Message-Id: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Daniel Jordan <daniel.m.jordan@oracle.com>

Deferred struct page init is a bottleneck in kernel boot--the biggest
for us and probably others.  Optimizing it maximizes availability for
large-memory systems and allows spinning up short-lived VMs as needed
without having to leave them running.  It also benefits bare metal
machines hosting VMs that are sensitive to downtime.  In projects such
as VMM Fast Restart[1], where guest state is preserved across kexec
reboot, it helps prevent application and network timeouts in the guests.

So, multithread deferred init to take full advantage of system memory
bandwidth.

Extend padata, a framework that handles many parallel singlethreaded
jobs, to handle multithreaded jobs as well by adding support for
splitting up the work evenly, specifying a minimum amount of work that's
appropriate for one helper thread to do, load balancing between helpers,
and coordinating them.  More documentation in patches 4 and 7.

This series is the first step in a project to address other memory
proportional bottlenecks in the kernel such as pmem struct page init,
vfio page pinning, hugetlb fallocate, and munmap.  Deferred page init
doesn't require concurrency limits, resource control, or priority
adjustments like these other users will because it happens during boot
when the system is otherwise idle and waiting for page init to finish.

This has been run on a variety of x86 systems and speeds up kernel boot
by 3% to 49%, saving up to 1.6 out of 4 seconds.  Patch 5 has more
numbers.

Please review and test, and thanks to Alex, Andrew, Josh, and Pavel for
their feedback in the last version.

The powerpc and s390 lists are included in case they want to give this a
try, they had enabled this feature when it was configured per arch.

Series based on 5.7-rc6 plus these three from mmotm

  mm-call-touch_nmi_watchdog-on-max-order-boundaries-in-deferred-init.patch
  mm-initialize-deferred-pages-with-interrupts-enabled.patch
  mm-call-cond_resched-from-deferred_init_memmap.patch

and it's available here:

  git://oss.oracle.com/git/linux-dmjordan.git padata-mt-definit-v2
  https://oss.oracle.com/git/gitweb.cgi?p=linux-dmjordan.git;a=shortlog;h=refs/heads/padata-mt-definit-v2

and the future users and related features are available as
work-in-progress:

  git://oss.oracle.com/git/linux-dmjordan.git padata-mt-wip-v0.4
  https://oss.oracle.com/git/gitweb.cgi?p=linux-dmjordan.git;a=shortlog;h=refs/heads/padata-mt-wip-v0.4

v2:
 - Improve the problem statement (Andrew, Josh, Pavel)
 - Add T-b's to unchanged patches (Josh)
 - Fully initialize max-order blocks to avoid buddy issues (Alex)
 - Parallelize on section-aligned boundaries to avoid potential
   false sharing (Alex)
 - Return the maximum thread count from a function that architectures
   can override, with the generic version returning 1 (current
   behavior).  Override for x86 since that's the only arch this series
   has been tested on so far.  Other archs can test with more threads
   by dropping patch 6.
 - Rebase to v5.7-rc6, rerun tests

RFC v4 [2] -> v1:
 - merged with padata (Peter)
 - got rid of the 'task' nomenclature (Peter, Jon)

future work branch:
 - made lockdep-aware (Jason, Peter)
 - adjust workqueue worker priority with renice_or_cancel() (Tejun)
 - fixed undo problem in VFIO (Alex)

The remaining feedback, mainly resource control awareness (cgroup etc),
is TODO for later series.

[1] https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf
    https://www.youtube.com/watch?v=pBsHnf93tcQ
    https://lore.kernel.org/linux-mm/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/

[2] https://lore.kernel.org/linux-mm/20181105165558.11698-1-daniel.m.jordan@oracle.com/

Daniel Jordan (7):
  padata: remove exit routine
  padata: initialize earlier
  padata: allocate work structures for parallel jobs from a pool
  padata: add basic support for multithreaded jobs
  mm: parallelize deferred_init_memmap()
  mm: make deferred init's max threads arch-specific
  padata: document multithreaded jobs

 Documentation/core-api/padata.rst |  41 +++--
 arch/x86/mm/init_64.c             |  12 ++
 include/linux/memblock.h          |   3 +
 include/linux/padata.h            |  43 ++++-
 init/main.c                       |   2 +
 kernel/padata.c                   | 277 ++++++++++++++++++++++++------
 mm/Kconfig                        |   6 +-
 mm/page_alloc.c                   |  67 +++++++-
 8 files changed, 373 insertions(+), 78 deletions(-)


base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
prerequisite-patch-id: 4ad522141e1119a325a9799dad2bd982fbac8b7c
prerequisite-patch-id: 169273327e56f5461101a71dfbd6b4cfd4570cf0
prerequisite-patch-id: 0f34692c8a9673d4c4f6a3545cf8ec3a2abf8620
-- 
2.26.2
